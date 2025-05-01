import pytest

@pytest.mark.asyncio
async def test_create_deck(client):
    # login
    res = await client.post("/api/v1/users/login", data={
        "username": "test@example.com",
        "password": "testpass123"
    })
    token = res.json()["access_token"]
    headers = {"Authorization": f"Bearer {token}"}

    # create deck
    res = await client.post("/api/v1/decks/", json={
        "name": "Mathématiques",
        "description": "Deck de test",
        "tags": ["test"]
    }, headers=headers)
    assert res.status_code == 200
    assert res.json()["name"] == "Mathématiques"

@pytest.mark.asyncio
async def test_list_decks(client):
    res = await client.post("/api/v1/users/login", data={
        "username": "test@example.com",
        "password": "testpass123"
    })
    token = res.json()["access_token"]
    headers = {"Authorization": f"Bearer {token}"}

    res = await client.get("/api/v1/decks/", headers=headers)
    assert res.status_code == 200
    assert isinstance(res.json(), list)
