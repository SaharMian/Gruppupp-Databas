from src.database import SessionLocal #src eventuellt ta bort, baserat på projekt upplägg
from src.models import Books

def show_all_books():
    session = SessionLocal()
    books = session.query(Books).order_by(Books.title).all()
    for b in books:
        print(f"{b.id}: {b.title} av {b.author}")
    session.close()

def search_books():
    keyword = input("Sök titel eller författare: ")
    session = SessionLocal()
    books = session.query(Books).filter(
        (Books.title.ilike(f"%{keyword}%")) | (Books.author.ilike(f"%{keyword}%"))
    ).all()
    for b in books:
        print(f"{b.id}: {b.title} av {b.author}")
    session.close()

def add_new_book():
    title = input("Titel: ")
    author = input("Författare: ")
    session = SessionLocal()
    book = Books(title=title, author=author, total_copies=1, available_copies=1)
    session.add(book)
    session.commit()
    print("Bok tillagd.")
    session.close()

def show_available_books():
    session = SessionLocal()
    books = session.query(Books).filter(Books.available_copies > 0).all()
    for b in books:
        print(f"{b.id}: {b.title} ({b.available_copies} tillgängliga)")
    session.close()

def book_menu():
    while True:
        print("\n--- Bokmeny ---")
        print("1. Visa alla böcker")
        print("2. Sök bok")
        print("3. Lägg till bok")
        print("4. Visa tillgängliga böcker")
        print("0. Tillbaka")
        val = input("Välj: ")

        if val == "1":
            show_all_books()
        elif val == "2":
            search_books()
        elif val == "3":
            add_new_book()
        elif val == "4":
            show_available_books()
        elif val == "0":
            break
        else:
            print("Ogiltigt val.")