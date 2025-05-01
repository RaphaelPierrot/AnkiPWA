from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.ext.asyncio import AsyncSession
from fastapi.security import OAuth2PasswordBearer, OAuth2PasswordRequestForm
from app.db.session import get_db
from app.crud.user import get_user_by_email, create_user
from app.schemas.user import UserCreate, UserLogin, UserOut
from app.core.security import verify_password, create_access_token
from jose import JWTError, jwt
from app.models.user import User
from uuid import UUID
import os

router = APIRouter()
oauth2_scheme = OAuth2PasswordBearer(tokenUrl="/api/v1/users/login")

SECRET_KEY = os.getenv("SECRET_KEY", "secret")
ALGORITHM = "HS256"

@router.post("/register", response_model=UserOut)
async def register(user: UserCreate, db: AsyncSession = Depends(get_db)):
    existing = await get_user_by_email(user.email, db)
    if existing:
        raise HTTPException(status_code=400, detail="Email déjà utilisé")
    return await create_user(user, db)

@router.post("/login")
async def login(form_data: OAuth2PasswordRequestForm = Depends(), db: AsyncSession = Depends(get_db)):
    user = await get_user_by_email(form_data.username, db)
    if not user or not verify_password(form_data.password, user.hashed_password):
        raise HTTPException(status_code=401, detail="Identifiants invalides")
    token = create_access_token({"sub": str(user.id)})
    return {"access_token": token, "token_type": "bearer"}

async def get_current_user(token: str = Depends(oauth2_scheme), db: AsyncSession = Depends(get_db)) -> User:
    try:
        payload = jwt.decode(token, SECRET_KEY, algorithms=[ALGORITHM])
        user_id: str = payload.get("sub")
        if user_id is None:
            raise HTTPException(status_code=401, detail="Token invalide")
    except JWTError:
        raise HTTPException(status_code=401, detail="Token invalide")
    user = await db.get(User, UUID(user_id))
    if user is None:
        raise HTTPException(status_code=401, detail="Utilisateur non trouvé")
    return user

@router.get("/me", response_model=UserOut)
async def read_user_me(current_user: User = Depends(get_current_user)):
    return current_user
