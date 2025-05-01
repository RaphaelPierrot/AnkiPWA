from fastapi import APIRouter, Depends
from sqlalchemy.ext.asyncio import AsyncSession
from app.db.session import get_db
from app.crud.notification import register_device_token, get_tokens_by_user
from app.schemas.notification import NotificationRegister, NotificationOut
from app.models.user import User
from app.api.v1.routes.users import get_current_user
from app.services.notifications import send_notification  
from app.schemas.notification import NotificationSend  

router = APIRouter()

@router.post("/send")
async def send(
    data: NotificationSend,
    db: AsyncSession = Depends(get_db),
    current_user: User = Depends(get_current_user)
):
    await send_notification(current_user.id, data, db)
    return {"message": "Notification envoyée avec succès"}

@router.post("/register", response_model=NotificationOut)
async def register_token(
    data: NotificationRegister,
    db: AsyncSession = Depends(get_db),
    current_user: User = Depends(get_current_user)
):
    return await register_device_token(current_user.id, data, db)

@router.get("/schedule", response_model=list[NotificationOut])
async def view_tokens(
    db: AsyncSession = Depends(get_db),
    current_user: User = Depends(get_current_user)
):
    return await get_tokens_by_user(current_user.id, db)

