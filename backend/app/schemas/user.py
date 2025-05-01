from pydantic import BaseModel, EmailStr
from pydantic.config import ConfigDict

from uuid import UUID
from datetime import datetime

class UserBase(BaseModel):

    model_config = ConfigDict(from_attributes=True)

    email: EmailStr

class UserCreate(BaseModel):

    model_config = ConfigDict(from_attributes=True)

    email: EmailStr
    password: str

class UserOut(UserBase):
    id: UUID
    created_at: datetime

class UserLogin(BaseModel):

    model_config = ConfigDict(from_attributes=True)

    email: EmailStr
    password: str

