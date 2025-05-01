from sqlalchemy import Column, String, DateTime, ForeignKey, JSON
from sqlalchemy.dialects.postgresql import UUID

from app.db.base_class import Base
import uuid
from datetime import datetime, timezone
class Deck(Base):
    __tablename__ = "decks"

    id = Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    user_id = Column(UUID(as_uuid=True), ForeignKey("users.id", ondelete="CASCADE"))
    name = Column(String, index=True)
    description = Column(String, nullable=True)
    tags = Column(JSON, default=[])

    created_at = Column(DateTime, default=lambda: datetime.now(timezone.utc))
