from sqlalchemy import Column, String, ForeignKey
from sqlalchemy.dialects.postgresql import UUID
from app.db.base_class import Base
import uuid

class NotificationToken(Base):
    __tablename__ = "notification_tokens"

    id = Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    user_id = Column(UUID(as_uuid=True), ForeignKey("users.id", ondelete="CASCADE"))
    device_token = Column(String)
    platform = Column(String)  # ex: 'ios', 'android', 'web'
