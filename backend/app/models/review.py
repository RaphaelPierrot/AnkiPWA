from sqlalchemy import Column, DateTime, Integer, Float, ForeignKey
from sqlalchemy.dialects.postgresql import UUID
from app.db.base_class import Base
import uuid
from datetime import datetime

class Review(Base):
    __tablename__ = "reviews"

    id = Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    card_id = Column(UUID(as_uuid=True), ForeignKey("cards.id", ondelete="CASCADE"))
    user_id = Column(UUID(as_uuid=True), ForeignKey("users.id", ondelete="CASCADE"))
    next_review = Column(DateTime, default=datetime.utcnow)
    interval = Column(Integer, default=1)
    repetition = Column(Integer, default=0)
    efactor = Column(Float, default=2.5)
    last_quality = Column(Integer, default=0)
