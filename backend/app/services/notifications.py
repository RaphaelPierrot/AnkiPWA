from datetime import datetime, timedelta, UTC
from typing import List
from uuid import UUID
from app.schemas.notification import NotificationSend
from sqlalchemy.ext.asyncio import AsyncSession

async def send_notification(user_id: UUID, data: NotificationSend, db: AsyncSession):
    # Simulation d’envoi de notification (par ex. push ou email)
    print(f"[DEBUG] Notification à {user_id} — {data.title}: {data.message}")
    return True

# Exemple de structure de notification
def build_revision_notification(card_front: str) -> dict:
    return {
        "title": "⏰ Temps de réviser !",
        "body": f"Question : {card_front}",
        "data": {"type": "review"}
    }

# Simuler une planification (à remplacer par une tâche asynchrone ou celery)
def get_scheduled_notifications(now: datetime = None) -> List[dict]:
    now = now or datetime.now(UTC)
    return [{
        "title": "Révision quotidienne",
        "body": "Tu as des cartes à réviser aujourd'hui 📚",
        "time": (now + timedelta(hours=1)).isoformat()
    }]
