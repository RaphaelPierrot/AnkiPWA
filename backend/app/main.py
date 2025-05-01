from fastapi import FastAPI
from app.api.v1.routes import users, decks, cards, review, notifications, sessions, csv

app = FastAPI()

app.include_router(users.router, prefix="/api/v1/users", tags=["Users"])
app.include_router(decks.router, prefix="/api/v1/decks", tags=["Decks"])
app.include_router(cards.router, prefix="/api/v1/cards", tags=["Cards"])
app.include_router(review.router, prefix="/api/v1/review", tags=["Review"])
app.include_router(notifications.router, prefix="/api/v1/notifications", tags=["Notifications"])
app.include_router(sessions.router, prefix="/api/v1/sessions", tags=["Sessions"])
app.include_router(csv.router, prefix="/api/v1/csv", tags=["CSV"])
