from sqlalchemy import Column, String, DateTime, ForeignKey
from sqlalchemy.dialects.postgresql import UUID
from app.db.base_class import Base
import uuid
from datetime import datetime, timezone, UTC
from sqlalchemy import Column, Integer, Float, DateTime


class Card(Base):
    __tablename__ = "cards"

    id = Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    deck_id = Column(UUID(as_uuid=True), ForeignKey("decks.id", ondelete="CASCADE"))
    front = Column(String)
    back = Column(String)
    media = Column(String, nullable=True)  # URL de fichier audio/image/vidéo
    latex = Column(String, nullable=True)
    created_at = Column(DateTime, default=lambda: datetime.now(timezone.utc))
    repetitions = Column(Integer, default=0)
    interval = Column(Integer, default=1)  # en jours
    ease_factor = Column(Float, default=2.5)
    due_date = Column(DateTime(timezone=True), default=datetime.now(UTC))
    user_id = Column(UUID(as_uuid=True), ForeignKey("users.id"), nullable=False)
