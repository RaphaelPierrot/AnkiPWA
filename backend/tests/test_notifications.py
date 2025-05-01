import pytest
from uuid import uuid4

@pytest.mark.asyncio
async def test_send_notification(client):
    email = f"notif_{uuid4()}@example.com"
    password = "testpass123"
    await client.post("/api/v1/users/register", json={"email": email, "password": password})
    res = await client.post("/api/v1/users/login", data={"username": email, "password": password})
    token = res.json()["access_token"]
    headers = {"Authorization": f"Bearer {token}"}

    res = await client.post("/api/v1/notifications/send", json={
        "title": "Rappel",
        "message": "Tu as une session à faire !"
    }, headers=headers)

    assert res.status_code == 200
    assert "envoyée" in res.text.lower()
