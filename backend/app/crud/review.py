from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.future import select
from app.models.review import Review
from app.schemas.review import ReviewCreate
from datetime import datetime, timedelta, timezone
import uuid

async def get_next_review_card(user_id: str, db: AsyncSession):
    result = await db.execute(
        select(Review).where(
            Review.user_id == user_id,
            Review.next_review <= datetime.now(timezone.utc)
        ).order_by(Review.next_review.asc())
    )
    return result.scalars().first()

async def update_review_sm2(card_id: str, user_id: str, quality: int, db: AsyncSession):
    result = await db.execute(
        select(Review).where(
            Review.card_id == card_id,
            Review.user_id == user_id
        )
    )
    review = result.scalars().first()

    if not review:
        # Création initiale
        review = Review(
            id=uuid.uuid4(),
            card_id=card_id,
            user_id=user_id,
            repetition=0,
            interval=1,
            efactor=2.5,
            next_review=datetime.now(timezone.utc),
            last_quality=quality
        )

    if quality < 3:
        review.repetition = 0
        review.interval = 1
    else:
        review.repetition += 1
        review.efactor = max(1.3, review.efactor + (0.1 - (5 - quality) * (0.08 + (5 - quality) * 0.02)))
        if review.repetition == 1:
            review.interval = 1
        elif review.repetition == 2:
            review.interval = 6
        else:
            review.interval = int(review.interval * review.efactor)

    review.next_review = datetime.now(timezone.utc) + timedelta(days=review.interval)
    review.last_quality = quality

    db.add(review)
    await db.commit()
    await db.refresh(review)
    return review
