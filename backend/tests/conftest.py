import pytest
from httpx import AsyncClient
from httpx import ASGITransport
from sqlalchemy.ext.asyncio import create_async_engine, AsyncSession
from sqlalchemy.orm import sessionmaker
from app.main import app
from app.db.base_class import Base
from app.db.session import get_db
from app.core.security import hash_password
from app.models.user import User
import uuid
from datetime import UTC, datetime
DATABASE_URL = "sqlite+aiosqlite:///./test.db"

engine_test = create_async_engine(DATABASE_URL, connect_args={"check_same_thread": False})
TestingSessionLocal = sessionmaker(engine_test, class_=AsyncSession, expire_on_commit=False)

async def override_get_db():
    async with TestingSessionLocal() as session:
        yield session

app.dependency_overrides[get_db] = override_get_db



@pytest.fixture(scope="module")
async def client():
    async with engine_test.begin() as conn:
        await conn.run_sync(Base.metadata.create_all)

    # Crée un user avant les tests
    async with TestingSessionLocal() as db:
        test_user = User(
            id=uuid.uuid4(),
            email="test@example.com",
            hashed_password=hash_password("testpass123"),
            created_at=datetime.now(UTC)
        )
        db.add(test_user)
        await db.commit()

    transport = ASGITransport(app=app)
    async with AsyncClient(transport=transport, base_url="http://test") as c:
        yield c

    async with engine_test.begin() as conn:
        await conn.run_sync(Base.metadata.drop_all)
