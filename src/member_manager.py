from sqlalchemy import or_
from models import Member
from datetime import date


def list_members(session):
return session.query(Member).order_by(Member.last_name, Member.first_name).all()


def add_member(session, first_name, last_name, email, membership_date=None):
if membership_date is None:
membership_date = date.today()
m = Member(
first_name=first_name,
last_name=last_name,
email=email,
membership_date=membership_date
)
session.add(m)
session.commit()
return m


def search_members(session, term):
term_like = f"%{term}%"
return session.query(Member).filter(
or_(Member.first_name.ilike(term_like), Member.last_name.ilike(term_like), Member.email.ilike(term_like))
).all()