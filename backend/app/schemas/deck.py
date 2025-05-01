
from pydantic import BaseModel
from pydantic.config import ConfigDict

from typing import List, Optional
from uuid import UUID

class DeckBase(BaseModel):

    model_config = ConfigDict(from_attributes=True)

    name: str
    description: Optional[str] = None
    tags: List[str] = []

class DeckCreate(DeckBase):
    pass

class DeckOut(DeckBase):
    id: UUID
    user_id: UUID

