from uuid import UUID
from app.dependencies.user import get_current_user_id
from fastapi import APIRouter, UploadFile, File, Depends
from sqlalchemy.ext.asyncio import AsyncSession
from app.db.session import get_db
from app.services.csv import parse_csv_to_cards, export_cards_to_csv
from app.crud.card import create_card, get_cards_by_deck
from app.schemas.card import CardOut
from app.models.user import User
from app.api.v1.routes.users import get_current_user

router = APIRouter()

current_user: User = Depends(get_current_user)


@router.post("/import/{deck_id}")
async def import_csv(
    deck_id: str,
    file: UploadFile = File(...),
    db: AsyncSession = Depends(get_db),
    user_id: UUID = Depends(get_current_user_id)
):
    content = await file.read()
    cards = parse_csv_to_cards(content)
    for card in cards:
        await create_card(deck_id, user_id, card, db)

    return {"message": f"{len(cards)} cartes importées", "deck_id": deck_id}

@router.get("/export/{deck_id}", response_model=str)
async def export_csv(deck_id: str, db: AsyncSession = Depends(get_db)):
    cards = await get_cards_by_deck(deck_id, db)
    cards_dicts = [CardOut.from_orm(card).dict() for card in cards]
    return export_cards_to_csv(cards_dicts)
