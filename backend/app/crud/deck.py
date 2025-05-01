from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.future import select
from app.models.deck import Deck
from app.schemas.deck import DeckCreate
import uuid
from uuid import UUID


async def get_decks_by_user(user_id: UUID, db: AsyncSession):
    result = await db.execute(select(Deck).where(Deck.user_id == user_id))
    return result.scalars().all()


async def create_deck(user_id: str, deck: DeckCreate, db: AsyncSession):
    new_deck = Deck(
        id=uuid.uuid4(),
        user_id=user_id,
        name=deck.name,
        description=deck.description,
        tags=deck.tags
    )
    db.add(new_deck)
    await db.commit()
    await db.refresh(new_deck)
    return new_deck
