from datetime import datetime, timedelta, UTC
from app.models.card import Card
from app.schemas.review import ReviewAnswer
from sqlalchemy.ext.asyncio import AsyncSession
from uuid import UUID

from typing import List
# Valeurs par défaut SM2
INITIAL_EASE_FACTOR = 2.5
MIN_EASE_FACTOR = 1.3


def filter_cards_sm2(cards: List[Card]) -> List[Card]:
    """
    Retourne les cartes à réviser selon la date d'échéance.
    """
    now = datetime.now(UTC)

    filtered = []
    for card in cards:
        if card.due_date is None:
            filtered.append(card)
        else:
            due_date = card.due_date
            if due_date.tzinfo is None:
                due_date = due_date.replace(tzinfo=UTC)
            if due_date <= now:
                filtered.append(card)
    return filtered


def calculate_sm2(card, quality: int):
    """
    Applique l'algorithme SM2 à une carte en fonction de la réponse.
    quality : int entre 0 et 5
    """
    assert 0 <= quality <= 5, "La qualité doit être entre 0 et 5"

    if quality < 3:
        card.repetitions = 0
        card.interval = 1
    else:
        card.repetitions += 1
        if card.repetitions == 1:
            card.interval = 1
        elif card.repetitions == 2:
            card.interval = 6
        else:
            card.interval = int(card.interval * card.ease_factor)

    # Mise à jour du ease_factor
    ef = card.ease_factor or INITIAL_EASE_FACTOR
    ef = ef + (0.1 - (5 - quality) * (0.08 + (5 - quality) * 0.02))
    card.ease_factor = max(MIN_EASE_FACTOR, ef)

    # Prochaine date de révision
    card.next_review = datetime.now() + timedelta(days=card.interval)

    return card
def sm2_algorithm(card: Card, review: ReviewAnswer) -> Card:
    # Logique simplifiée du SM2 pour la démo
    q = review.quality
    if q < 3:
        card.interval = 1
        card.repetitions = 0
    else:
        card.repetitions += 1
        if card.repetitions == 1:
            card.interval = 1
        elif card.repetitions == 2:
            card.interval = 6
        else:
            card.interval = round(card.interval * card.ease_factor)
        card.ease_factor = max(1.3, card.ease_factor + 0.1 - (5 - q) * 0.08)
    card.due = review.reviewed_at + timedelta(days=card.interval)
    return card

async def update_card_review(
    card: Card,
    quality: int,
    db: AsyncSession
):
    updated_card = calculate_sm2(card, quality)
    db.add(updated_card)
    await db.commit()
    await db.refresh(updated_card)
    return updated_card
