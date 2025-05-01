import pytest

from uuid import uuid4

@pytest.mark.asyncio
async def test_register_user(client):
    unique_email = f"test_{uuid4()}@example.com"
    payload = {
        "email": unique_email,
        "password": "testpass123"
    }
    res = await client.post("/api/v1/users/register", json=payload)

    print("Status Code:", res.status_code)
    print("Response Body:", res.text)

    assert res.status_code == 200
    assert "email" in res.json()



@pytest.mark.asyncio
async def test_login_user(client):
    res = await client.post("/api/v1/users/login", data={
        "username": "test@example.com",
        "password": "testpass123"
    })
    assert res.status_code == 200
    assert "access_token" in res.json()
