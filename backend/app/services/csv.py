import csv
import io
from app.schemas.card import CardCreate

def parse_csv_to_cards(file_content: bytes) -> list[CardCreate]:
    cards = []
    reader = csv.DictReader(io.StringIO(file_content.decode("utf-8")))
    for row in reader:
        cards.append(CardCreate(
            front=row.get("front", ""),
            back=row.get("back", ""),
            media=row.get("media"),
            latex=row.get("latex")
        ))
    return cards

def export_cards_to_csv(cards: list[dict]) -> str:
    output = io.StringIO()
    writer = csv.DictWriter(output, fieldnames=["front", "back", "media", "latex"])
    writer.writeheader()
    for card in cards:
        writer.writerow(card)
    return output.getvalue()
