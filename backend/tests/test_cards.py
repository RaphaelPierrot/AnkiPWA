import pytest
from uuid import uuid4

@pytest.mark.asyncio
async def test_add_card_to_deck(client):
    # Register + Login
    email = f"test_{uuid4()}@example.com"
    password = "testpass123"
    await client.post("/api/v1/users/register", json={"email": email, "password": password})
    res = await client.post("/api/v1/users/login", data={"username": email, "password": password})
    token = res.json()["access_token"]
    headers = {"Authorization": f"Bearer {token}"}

    # Create Deck
    await client.post("/api/v1/decks/", json={
        "name": "Deck Test",
        "description": "Pour test carte",
        "tags": ["unit"]
    }, headers=headers)

    # Récupération deck
    res = await client.get("/api/v1/decks/", headers=headers)
    decks = res.json()
    assert len(decks) > 0, "Aucun deck trouvé pour l'utilisateur"
    deck_id = decks[0]["id"]

    # Ajouter une carte
    res = await client.post(f"/api/v1/cards/{deck_id}", json={
        "front": "Quelle est la capitale de la France ?",
        "back": "Paris",
        "media": None,
        "latex": None
    }, headers=headers)

    assert res.status_code == 200
    assert res.json()["front"] == "Quelle est la capitale de la France ?"
@pytest.mark.asyncio
async def test_list_cards_in_deck(client):
    # Refaire l'inscription + login + création deck comme ci-dessus...

    email = f"test_{uuid4()}@example.com"
    password = "testpass123"
    await client.post("/api/v1/users/register", json={"email": email, "password": password})
    res = await client.post("/api/v1/users/login", data={"username": email, "password": password})
    token = res.json()["access_token"]
    headers = {"Authorization": f"Bearer {token}"}

    await client.post("/api/v1/decks/", json={
        "name": "Deck List Test",
        "description": "Deck pour liste",
        "tags": ["list"]
    }, headers=headers)

    res = await client.get("/api/v1/decks/", headers=headers)
    deck_id = res.json()[0]["id"]

    await client.post(f"/api/v1/cards/{deck_id}", json={
        "front": "2+2 ?",
        "back": "4",
        "media": None,
        "latex": None
    }, headers=headers)

    # Récupération des cartes
    res = await client.get(f"/api/v1/cards/{deck_id}", headers=headers)
    cards = res.json()
    assert len(cards) > 0
    assert cards[0]["back"] == "4"
