import pytest
from uuid import uuid4
from io import BytesIO

@pytest.mark.asyncio
async def test_import_csv(client):
    email = f"csv_{uuid4()}@example.com"
    password = "testpass123"
    await client.post("/api/v1/users/register", json={"email": email, "password": password})
    res = await client.post("/api/v1/users/login", data={"username": email, "password": password})
    token = res.json()["access_token"]
    headers = {"Authorization": f"Bearer {token}"}

    # Créer un deck avant import
    await client.post("/api/v1/decks/", json={
        "name": "Deck Import",
        "description": "Deck pour test CSV",
        "tags": ["csv"]
    }, headers=headers)

    decks = await client.get("/api/v1/decks/", headers=headers)
    deck_id = decks.json()[0]["id"]

    # Simuler un fichier CSV
    csv_content = b"front,back\nQuestion?,Reponse!"
    files = {
        "file": ("test.csv", BytesIO(csv_content), "text/csv")
    }

    res = await client.post(f"/api/v1/csv/import/{deck_id}", files=files, headers=headers)
    assert res.status_code == 200
    assert "cartes importées" in res.json()["message"]


