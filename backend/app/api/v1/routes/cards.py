from uuid import UUID
from app.dependencies.user import get_current_user_id
from fastapi import APIRouter, Depends
from sqlalchemy.ext.asyncio import AsyncSession
from app.db.session import get_db
from app.crud.card import get_cards_by_deck
from app.crud.card import create_card as create_card_crud
from app.schemas.card import CardCreate, CardOut

router = APIRouter()

@router.get("/{deck_id}", response_model=list[CardOut])
async def list_cards(
    deck_id: str,
    db: AsyncSession = Depends(get_db),
    user_id: UUID = Depends(get_current_user_id)  
):
    return await get_cards_by_deck(deck_id, db, user_id)

@router.post("/{deck_id}", response_model=CardOut)
async def create_card(
    deck_id: UUID,
    card: CardCreate,
    db: AsyncSession = Depends(get_db),
    user_id: UUID = Depends(get_current_user_id),
):
    return await create_card_crud(deck_id, user_id, card, db)
