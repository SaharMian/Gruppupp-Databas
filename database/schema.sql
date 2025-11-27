CREATE DATABASE librarydb_dpu7;

CREATE TABLE members (
    id SERIAL PRIMARY KEY, -- Unikt ID för varje medlem för att identifiera varje medlem unikt
    first_name VARCHAR(255) NOT NULL, -- VARCHAR för att lagra förnamn och not null för att säkerställa att det alltid finns ett värde
    last_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL, -- Unikt e-postfält för att undvika dubbletter
    phone VARCHAR(50), -- VARCHAR istället för INTEGER för att hantera olika format av telefonnummer
    membership_date DATE DEFAULT CURRENT_DATE, -- Datum när medlemmen registrerades, standard till dagens datum
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP -- Tidsstämpel för när medlemskapet skapades, standard till nuvarande tidpunkt
);

CREATE INDEX idx_members_last_name ON members(last_name); -- Index för att snabba upp sökningar baserade på efternamn

CREATE TABLE books (
    id SERIAL PRIMARY KEY, -- Unikt ID för varje bok för att identifiera varje bok unikt
    title VARCHAR(255) NOT NULL, -- får inte vara null, eftersom varje bok måste ha en titel
    author VARCHAR(255) NOT NULL, -- får inte vara null, eftersom varje bok måste ha en författare
    isbn VARCHAR(20) UNIQUE, -- Unikt ISBN-nummer för varje bok för att undvika dubbletter av samma bok
    publication_year INTEGER,
    category VARCHAR(100),
    total_copies INTEGER DEFAULT 1 CHECK (total_copies >= 0), -- Kontroll för att säkerställa att antalet exemplar inte är negativt
    available_copies INTEGER DEFAULT 1 CHECK (available_copies >= 0), -- Kontroll för att säkerställa att tillgängliga exemplar inte är negativt
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP -- Tidsstämpel för när boken lades till i systemet, standard till nuvarande tidpunkt
);

CREATE INDEX idx_books_title ON books(title); -- Index för att snabba upp sökningar baserade på boktitel
CREATE INDEX idx_books_category ON books(category); -- Index för att snabba upp sökningar baserade på kategori

CREATE TABLE loans (
    id SERIAL PRIMARY KEY, -- Unikt ID för varje lån för att identifiera varje lån unikt
    book_id INTEGER NOT NULL REFERENCES books(id) ON DELETE CASCADE, -- Utlånad bok, referens till books-tabellen, CASCADE för att ta bort lån om boken tas bort
    member_id INTEGER NOT NULL REFERENCES members(id) ON DELETE CASCADE, -- Medlem som lånar boken, referens till members-tabellen, CASCADE för att ta bort lån om medlemmen tas bort
    loan_date DATE DEFAULT CURRENT_DATE, -- Datum när boken lånades ut, standard till dagens datum
    due_date DATE NOT NULL, -- Datum när boken ska återlämnas
    return_date DATE, -- Datum när boken återlämnades, kan vara null om boken inte är återlämnad än
    CONSTRAINT chk_due_after_loan CHECK (due_date > loan_date), -- Kontroll för att säkerställa att förfallodatum är efter lånedatum, annars fel
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP -- Tidsstämpel för när lånet skapades, standard till nuvarande tidpunkt
);

CREATE INDEX idx_loans_book_id ON loans(book_id); -- Index för att snabba upp sökningar baserade på bok-ID
CREATE INDEX idx_loans_member_id ON loans(member_id); -- Index för att snabba upp sökningar baserade på medlems-ID
