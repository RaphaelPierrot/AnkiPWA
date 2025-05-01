from fastapi import APIRouter, Depends
from sqlalchemy.ext.asyncio import AsyncSession
from app.db.session import get_db
from app.crud.review import get_next_review_card, update_review_sm2
from app.schemas.review import ReviewOut, ReviewCreate
from app.models.user import User
from app.api.v1.routes.users import get_current_user

router = APIRouter()
current_user: User = Depends(get_current_user)

@router.get("/next", response_model=ReviewOut | None)
async def get_next_card_to_review(db: AsyncSession = Depends(get_db)):
    return await get_next_review_card(current_user.id
, db)

@router.post("/{card_id}", response_model=ReviewOut)
async def submit_review(card_id: str, data: ReviewCreate, db: AsyncSession = Depends(get_db)):
    return await update_review_sm2(card_id, current_user.id
, data.quality, db)

