from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.future import select
from app.models.user import User
from app.schemas.user import UserCreate
from app.core.security import hash_password
import uuid
from datetime import datetime, timezone

async def get_user_by_email(email: str, db: AsyncSession):
    result = await db.execute(select(User).where(User.email == email))
    return result.scalar_one_or_none()

async def create_user(user: UserCreate, db: AsyncSession):
    new_user = User(
        id=uuid.uuid4(),
        email=user.email,
        hashed_password=hash_password(user.password),
        created_at=datetime.now(timezone.utc)
    )
    db.add(new_user)
    await db.commit()
    await db.refresh(new_user)
    return new_user
