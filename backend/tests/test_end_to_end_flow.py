import pytest
from uuid import uuid4
from io import BytesIO
from datetime import datetime, UTC, timedelta
@pytest.mark.asyncio
@pytest.mark.e2e
async def test_end_to_end_review_flow(client):
    # ÉTAPE 1 : Inscription + login
    email = f"user_{uuid4()}@test.com"
    password = "testpass123"
    await client.post("/api/v1/users/register", json={"email": email, "password": password})
    res = await client.post("/api/v1/users/login", data={"username": email, "password": password})
    token = res.json()["access_token"]
    headers = {"Authorization": f"Bearer {token}"}

    # ÉTAPE 2 : Créer un deck
    res = await client.post("/api/v1/decks/", json={
        "name": "Deck E2E",
        "description": "Deck complet",
        "tags": ["e2e"]
    }, headers=headers)
    assert res.status_code == 200

    # ÉTAPE 3 : Récupérer le deck_id
    res = await client.get("/api/v1/decks/", headers=headers)
    deck_id = res.json()[0]["id"]

    # ÉTAPE 4 : Importer une carte via CSV
    csv_content = b"front,back\nCombien font 2+2 ?,4"
    files = {"file": ("test.csv", BytesIO(csv_content), "text/csv")}
    
    res = await client.post(f"/api/v1/csv/import/{deck_id}", files=files, headers=headers)
    assert res.status_code == 200

    # ÉTAPE 5 : Démarrer une session
    res = await client.post(f"/api/v1/sessions/{deck_id}", headers=headers)
    assert res.status_code == 200
    assert "cards" in res.json()
    card_id = res.json()["cards"][0]["id"]

    # ÉTAPE 6 : Soumettre la réponse avec qualité = 5
    res = await client.post(f"/api/v1/sessions/submit/{card_id}?quality=5", headers=headers)
    assert res.status_code == 200
    assert "soumise" in res.text.lower()
    

    # ÉTAPE 7 : Vérifier la mise à jour de la carte (repetitions, interval…)
    res = await client.get(f"/api/v1/cards/{deck_id}", headers=headers)

    cards = res.json()

    assert isinstance(cards, list), f"Réponse inattendue : {cards}"
    assert len(cards) > 0

    card = cards[0]
    assert card["repetitions"] >= 1
    assert card["interval"] >= 1
    assert card["ease_factor"] >= 1.3
    # Optionnel : vérifier due_date
    
    due_date = datetime.fromisoformat(card["due_date"]).replace(tzinfo=UTC)
    now = datetime.now(UTC)
    assert due_date > now - timedelta(seconds=5), f"{due_date=} vs {now=}"