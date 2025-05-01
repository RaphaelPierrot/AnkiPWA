import os
from pydantic_settings import BaseSettings, SettingsConfigDict

env = os.getenv("ENV", "dev")
env_file = ".env" if env == "dev" else ".env.prod"

class Settings(BaseSettings):
    DATABASE_URL: str
    SECRET_KEY: str
    ACCESS_TOKEN_EXPIRE_MINUTES: int = 60
    ALGORITHM: str = "HS256"
    ENV: str = env

    model_config = SettingsConfigDict(
        env_file=env_file,
        extra="ignore"
    )

settings = Settings()



