from typing import Union
from app.dependencies.user import get_current_user_id
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.future import select
from app.models.card import Card
from app.schemas.card import CardCreate
import uuid
from datetime import datetime, timezone
from fastapi import Depends
async def get_card_by_id(card_id: str, db: AsyncSession) -> Card:
    card_uuid = uuid.UUID(card_id)  # ← conversion ici
    result = await db.execute(select(Card).where(Card.id == card_uuid))
    return result.scalar_one_or_none()
async def get_cards_by_deck(deck_id: Union[str, uuid.UUID], db: AsyncSession, user_id: uuid.UUID):
    if isinstance(deck_id, str):
        deck_id = uuid.UUID(deck_id)

    result = await db.execute(select(Card).where(Card.deck_id == deck_id, Card.user_id == user_id))
    return result.scalars().all()


async def create_card(deck_id: uuid.UUID, user_id: uuid.UUID, card: CardCreate, db: AsyncSession):
    new_card = Card(
    id=uuid.uuid4(),
    user_id=user_id,
    deck_id = uuid.UUID(deck_id) if isinstance(deck_id, str) else deck_id,
    front=card.front,
    back=card.back,
    media=card.media,
    latex=card.latex,
    created_at=datetime.now(timezone.utc)
    )

    db.add(new_card)
    await db.commit()
    await db.refresh(new_card)
    return new_card
