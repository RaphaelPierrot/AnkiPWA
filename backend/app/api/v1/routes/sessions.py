from datetime import UTC, datetime
from http.client import HTTPException

from fastapi import APIRouter, Depends, Query
from sqlalchemy.ext.asyncio import AsyncSession
from app.db.session import get_db
from app.dependencies.user import get_current_user_id
from uuid import UUID
from app.crud.card import get_cards_by_deck
from app.models.card import Card  # si tu veux utiliser le modèle
from typing import List
from app.services.sm2 import sm2_algorithm, filter_cards_sm2
from app.schemas.review import ReviewAnswer
from app.crud.card import get_card_by_id

router = APIRouter()

@router.post("/{deck_id}")
async def start_session(
    deck_id: UUID,
    db: AsyncSession = Depends(get_db),
    user_id: UUID = Depends(get_current_user_id)
):
    cards = await get_cards_by_deck(deck_id, db, user_id)
    cards = filter_cards_sm2(cards)

    return {
        "message": "Session démarrée",
        "cards": cards
    }

@router.post("/submit/{card_id}")
async def submit_card(
    card_id: str,
    quality: int = Query(..., ge=0, le=5),
    db: AsyncSession = Depends(get_db),
):
    # Récupère la carte
    card = await get_card_by_id(card_id, db)

    # Enveloppe l'entier dans un objet ReviewAnswer
    answer = ReviewAnswer(
    card_id=card_id,
    quality=quality,
    reviewed_at=datetime.now(UTC)
    )


    # Applique l'algorithme SM2
    updated_card = sm2_algorithm(card, answer)

    # Sauvegarde et retourne
    db.add(updated_card)
    await db.commit()
    await db.refresh(updated_card)
    return {"message": f"Carte {card_id} soumise dans la session"}