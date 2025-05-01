import pytest
from uuid import uuid4

@pytest.mark.asyncio
async def test_review_submit(client):
    email = f"user_{uuid4()}@test.com"
    password = "testpass123"

    # Register + login
    await client.post("/api/v1/users/register", json={"email": email, "password": password})
    res = await client.post("/api/v1/users/login", data={"username": email, "password": password})
    token = res.json()["access_token"]
    headers = {"Authorization": f"Bearer {token}"}

    # Créer un deck + carte
    await client.post("/api/v1/decks/", json={
        "name": "Deck SM2",
        "description": "Test algo SM2",
        "tags": []
    }, headers=headers)
    res = await client.get("/api/v1/decks/", headers=headers)
    deck_id = res.json()[0]["id"]

    await client.post(f"/api/v1/cards/{deck_id}", json={
        "front": "Test SM2",
        "back": "Réponse",
        "media": None,
        "latex": None
    }, headers=headers)

    # Démarrer une session
    res = await client.post(f"/api/v1/sessions/{deck_id}", headers=headers)
    cards = res.json()["cards"]
    assert len(cards) == 1
    card_id = cards[0]["id"]

    # Réviser la carte
    res = await client.post(f"/api/v1/sessions/submit/{card_id}?quality=5", headers=headers)
    assert res.status_code == 200
    assert "soumise" in res.text.lower()
