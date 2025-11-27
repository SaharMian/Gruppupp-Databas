from models import Loan, Book, Member
from datetime import date, timedelta
from sqlalchemy import and_, func


DEFAULT_LOAN_DAYS = 14


def create_loan(session, book_id, member_id, loan_days=DEFAULT_LOAN_DAYS):
book = session.get(Book, book_id)
member = session.get(Member, member_id)
if not book:
raise ValueError('Boken hittades inte')
if not member:
raise ValueError('Medlemmen hittades inte')
if book.available_copies <= 0:
raise ValueError('Ingen tillgänglig kopia')


loan_date = date.today()
due_date = loan_date + timedelta(days=loan_days)


loan = Loan(book_id=book.id, member_id=member.id, loan_date=loan_date, due_date=due_date)
book.available_copies -= 1
session.add(loan)
session.commit()
return loan


def return_loan(session, loan_id):
loan = session.get(Loan, loan_id)
if not loan:
raise ValueError('Lånet hittades inte')
if loan.return_date is not None:
raise ValueError('Lånet är redan återlämnat')


loan.return_date = date.today()
book = session.get(Book, loan.book_id)
book.available_copies = (book.available_copies or 0) + 1
session.commit()
return loan


def list_active_loans(session):
return session.query(Loan).filter(Loan.return_date == None).all()


def list_overdue_loans(session):
today = date.today()
return session.query(Loan).filter(and_(Loan.return_date == None, Loan.due_date < today)).all()


# Stats


def most_borrowed_books(session, limit=5):
return session.query(Book.title, Book.author, func.count(Loan.id).label('total'))\
.join(Loan, Loan.book_id == Book.id)\
.group_by(Book.id)\
.order_by(func.count(Loan.id).desc())\
.limit(limit)\
.all()




def member_with_most_loans(session):
sub = session.query(Loan.member_id, func.count(Loan.id).label('total'))\
.group_by(Loan.member_id)\
.subquery()


}