Queries

--Grundläggande queries
-- Alla böcker sorterade efter titel
SELECT * FROM books
ORDER BY title ASC;

-- Alla medlemmar som blev medlemmar under 2024
SELECT * FROM members
WHERE membership_date BETWEEN '2024-01-01' AND '2024-12-31';

-- Alla böcker i kategorin 'Fiktion'
SELECT * FROM books
WHERE category = 'Fiktion';

-- Alla aktiva lån (inte återlämnade)
SELECT * FROM loans
WHERE return_date IS NULL;

-- Alla böcker med ett giltigt ISBN-nummer
SELECT * FROM books
WHERE isbn IS NOT NULL;



--JOIN-queries 
-- Alla lån med bokens titel och medlemmens namn
SELECT 
    l.id AS loan_id,
    b.title AS book_title,
    m.first_name || ' ' || m.last_name AS member_name,
    l.loan_date,
    l.return_date
FROM loans l
JOIN books b ON l.book_id = b.id
JOIN members m ON l.member_id = m.id;

-- Alla böcker en specifik medlem har lånat
SELECT 
    b.title,
    b.author,
    m.first_name || ' ' || m.last_name AS member_name,
    l.loan_date,
    l.return_date
FROM loans l
JOIN books b ON l.book_id = b.id
JOIN members m ON l.member_id = m.id
WHERE m.id = 5;

-- Alla medlemmar som har lånat böcker av en specifik författare
SELECT DISTINCT
    m.first_name || ' ' || m.last_name AS member_name,
    m.id AS member_id
FROM loans l
JOIN books b ON l.book_id = b.id
JOIN members m ON l.member_id = m.id
WHERE b.author = 'J.K. Rowling';

-- Böcker som aldrig har lånats
SELECT b.*
FROM books b
LEFT JOIN loans l ON b.id = l.book_id
WHERE l.book_id IS NULL;

-- Medlemmar som inte har några aktiva lån
SELECT 
    m.id,
    m.first_name,
    m.last_name
FROM members m
LEFT JOIN loans l 
    ON m.id = l.member_id 
    AND l.return_date IS NULL
WHERE l.id IS NULL;

--Aggregering och analys
-- Antal böcker per kategori
SELECT 
    category,
    COUNT(*) AS total_books
FROM books
GROUP BY category
ORDER BY total_books DESC;

-- De 5 mest populära (mest lånade) böckerna
SELECT 
    b.title,
    b.author,
    COUNT(l.id) AS total_loans
FROM loans l
JOIN books b ON l.book_id = b.id
GROUP BY b.id, b.title, b.author
ORDER BY total_loans DESC
LIMIT 5;

-- Medlemmar med flest lån
SELECT 
    m.first_name || ' ' || m.last_name AS member_name,
    COUNT(l.id) AS total_loans
FROM members m
LEFT JOIN loans l ON m.id = l.member_id
GROUP BY m.id, m.first_name, m.last_name
ORDER BY total_loans DESC;

-- Genomsnittligt antal dagar per lån (endast återlämnade)
SELECT 
    AVG(return_date - loan_date) AS avg_loan_days
FROM loans
WHERE return_date IS NOT NULL;

-- Antal försenade böcker
SELECT 
    COUNT(*) AS overdue_books
FROM loans
WHERE return_date IS NULL
  AND due_date < CURRENT_DATE;




