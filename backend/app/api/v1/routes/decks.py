from fastapi import APIRouter, Depends
from uuid import UUID
from sqlalchemy.ext.asyncio import AsyncSession
from app.db.session import get_db
from app.dependencies.user import get_current_user_id
from app.schemas.deck import DeckCreate
from app.crud.deck import create_deck, get_decks_by_user

router = APIRouter()

@router.post("/")
async def create_new_deck(
    deck: DeckCreate,
    db: AsyncSession = Depends(get_db),
    user_id: UUID = Depends(get_current_user_id),  
):
    return await create_deck(user_id, deck, db)


@router.get("/")
async def list_decks(
    db: AsyncSession = Depends(get_db),
    user_id: UUID = Depends(get_current_user_id),  
):
    return await get_decks_by_user(user_id, db)

