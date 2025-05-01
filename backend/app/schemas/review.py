
from pydantic import BaseModel, Field
from pydantic.config import ConfigDict

from typing import Optional
from uuid import UUID
from datetime import datetime
class ReviewAnswer(BaseModel):
    card_id: UUID
    quality: int = Field(..., ge=0, le=5)
    reviewed_at: datetime

class ReviewBase(BaseModel):

    model_config = ConfigDict(from_attributes=True)

    quality: int  # entre 0 et 5

class ReviewCreate(ReviewBase):
    pass

class ReviewOut(BaseModel):

    model_config = ConfigDict(from_attributes=True)

    id: UUID
    card_id: UUID
    user_id: UUID
    next_review: datetime
    interval: int
    repetition: int
    efactor: float
    last_quality: int

