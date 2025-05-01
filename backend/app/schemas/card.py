
from pydantic import BaseModel
from pydantic.config import ConfigDict

from typing import Optional
from uuid import UUID
from datetime import datetime

class CardBase(BaseModel):

    model_config = ConfigDict(from_attributes=True)

    front: str
    back: str
    media: Optional[str] = None
    latex: Optional[str] = None

class CardCreate(CardBase):
    pass

class CardOut(CardBase):
    id: UUID
    front: str
    back: str
    media: str | None
    latex: str | None
    created_at: datetime
    repetitions: int
    interval: int
    ease_factor: float
    due_date: datetime | None