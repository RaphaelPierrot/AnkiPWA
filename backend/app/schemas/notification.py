from pydantic import BaseModel
from pydantic.config import ConfigDict

from uuid import UUID

class NotificationSend(BaseModel):

    model_config = ConfigDict(from_attributes=True)

    title: str
    message: str

class NotificationRegister(BaseModel):

    model_config = ConfigDict(from_attributes=True)

    device_token: str
    platform: str  # ex : "ios", "android", "web"

class NotificationOut(BaseModel):

    model_config = ConfigDict(from_attributes=True)

    id: UUID
    user_id: UUID
    device_token: str
    platform: str

