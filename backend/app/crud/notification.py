from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.future import select
from app.models.notification import NotificationToken
from app.schemas.notification import NotificationRegister
import uuid

async def register_device_token(user_id: str, data: NotificationRegister, db: AsyncSession):
    token = NotificationToken(
        id=uuid.uuid4(),
        user_id=user_id,
        device_token=data.device_token,
        platform=data.platform
    )
    db.add(token)
    await db.commit()
    await db.refresh(token)
    return token

async def get_tokens_by_user(user_id: str, db: AsyncSession):
    result = await db.execute(select(NotificationToken).where(NotificationToken.user_id == user_id))
    return result.scalars().all()
