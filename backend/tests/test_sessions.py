import pytest
from uuid import uuid4

@pytest.mark.asyncio
async def test_create_session(client):
    email = f"session_{uuid4()}@example.com"
    password = "testpass123"
    await client.post("/api/v1/users/register", json={"email": email, "password": password})
    res = await client.post("/api/v1/users/login", data={"username": email, "password": password})
    token = res.json()["access_token"]
    headers = {"Authorization": f"Bearer {token}"}

    # Créer un deck pour lier à une session
    await client.post("/api/v1/decks/", json={
        "name": "Deck Session",
        "description": "Test de session",
        "tags": ["sm2"]
    }, headers=headers)

    decks = await client.get("/api/v1/decks/", headers=headers)
    deck_id = decks.json()[0]["id"]

    res = await client.post(f"/api/v1/sessions/{deck_id}", headers=headers)
    assert res.status_code == 200
    assert "cards" in res.json()
