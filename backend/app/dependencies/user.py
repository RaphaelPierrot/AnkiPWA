from uuid import UUID
from fastapi import Depends
from app.api.v1.routes.users import get_current_user
from app.models.user import User

async def get_current_user_id(user: User = Depends(get_current_user)) -> UUID:
    return user.id

