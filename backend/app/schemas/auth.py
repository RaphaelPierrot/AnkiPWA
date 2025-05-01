from pydantic import BaseModel
from pydantic.config import ConfigDict


class Token(BaseModel):

    model_config = ConfigDict(from_attributes=True)

    access_token: str
    token_type: str

class TokenData(BaseModel):

    model_config = ConfigDict(from_attributes=True)

    sub: str | None = None  # Contiendra l'ID utilisateur depuis le JWT
