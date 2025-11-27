
INSERT INTO members (first_name, last_name, email, phone, membership_date) VALUES --insert into = Data som läggs till i members-tabellen, med alla värden som ska anges

('Anna', 'Svensson', 'anna.svensson@example.com', '0701234567', '2023-01-15'), -- exempeldata för medlemmar,alla värden är med som ex förnamn i rätt format och ordning
('Erik', 'Johansson', 'erik.j@example.com', '0702345678', '2023-02-20'),
('Lisa', 'Nilsson', 'lisa.nilsson@example.com', '0703456789', '2023-03-10'),
('Johan', 'Karlsson', 'johan.k@example.com', '0704567890', '2023-04-05'),
('Maria', 'Andersson', 'maria.a@example.com', '0705678901', '2023-05-12'),
('Oskar', 'Lindberg', 'oskar.l@example.com', '0706789012', '2024-06-18'),
('Sara', 'Berg', 'sara.berg@example.com', '0707890123', '2024-07-25'),
('Daniel', 'Ek', 'daniel.ek@example.com', '0708901234', '2024-08-30'),
('Emma', 'Holm', 'emma.h@example.com', '0709012345', '2024-09-15'),
('Fredrik', 'Nyström', 'fredrik.n@example.com', '0700123456', '2024-10-01');
  

INSERT INTO books (title, author, isbn, publication_year, category, total_copies, available_copies) VALUES -- Data som läggs till i books-tabellen

('Sapiens', 'Yuval Noah Harari', '9780099590088', 2011, 'Historia', 5, 3), -- exempeldata för böcker
('Educated', 'Tara Westover', '9780399590504', 2018, 'Biografi', 3, 2),
('The Midnight Library', 'Matt Haig', '9780525559474', 2020, 'Fiktion', 4, 4),
('Atomic Habits', 'James Clear', '9780735211292', 2018, 'Självhjälp', 6, 5),
('The Great Gatsby', 'F. Scott Fitzgerald', '9780743273565', 1925, 'Klassiker', 2, 1),
('Becoming', 'Michelle Obama', '9781524763138', 2018, 'Biografi', 3, 2),
('The Alchemist', 'Paulo Coelho', '9780061122415', 1988, 'Fiktion', 4, 3),
('Thinking, Fast and Slow', 'Daniel Kahneman', '9780374533557', 2011, 'Psykologi', 5, 5),
('Norwegian Wood', 'Haruki Murakami', '9780375704024', 1987, 'Roman', 2, 1),
('Clean Code', 'Robert C. Martin', '9780132350884', 2008, 'Programmering', 3, 3),
('SQL Cookbook', 'Anthony Molinaro', '9780596009762', 2005, 'Databaser', 2, 2),
('Practical SQL', 'Anthony DeBarros', '9781593278274', 2018, 'Databaser', 3, 2),
('The Catcher in the Rye', 'J.D. Salinger', '9780316769488', 1951, 'Klassiker', 2, 2),
('The Road', 'Cormac McCarthy', '9780307387899', 2006, 'Roman', 2, 1),
('Dune', 'Frank Herbert', '9780441172719', 1965, 'Science Fiction', 4, 3);

--Uppdelad i tre sektioner för olika typer av lån, samt exempeldata för varje sektion
-- Aktiva lån (return_date = null vilket innebär att boken inte är återlämnad än) 
INSERT INTO loans (book_id, member_id, loan_date, due_date, return_date) VALUES
(1, 1, '2025-11-01', '2025-11-15', NULL),
(2, 2, '2025-11-05', '2025-11-20', NULL),
(3, 3, '2025-11-10', '2025-11-25', NULL),
(4, 4, '2025-11-12', '2025-11-26', NULL),
(5, 5, '2025-11-14', '2025-11-28', NULL),
(6, 6, '2025-11-15', '2025-11-29', NULL),
(7, 7, '2025-11-16', '2025-11-30', NULL),
(8, 8, '2025-11-17', '2025-12-01', NULL),
(9, 9, '2025-11-17', '2025-12-01', NULL),
(10, 10, '2025-11-17', '2025-12-01', NULL);

-- Återlämnade lån (return_date är satt till ett datum)
INSERT INTO loans (book_id, member_id, loan_date, due_date, return_date) VALUES
(11, 1, '2025-10-01', '2025-10-15', '2025-10-15'),
(12, 2, '2025-09-20', '2025-10-05', '2025-10-05'),
(13, 3, '2025-09-25', '2025-10-10', '2025-10-09'),
(14, 4, '2025-10-05', '2025-10-20', '2025-10-20'),
(15, 5, '2025-10-10', '2025-10-25', '2025-10-24');

-- Försenade lån (return_date är satt till ett datum efter due_date)
INSERT INTO loans (book_id, member_id, loan_date, due_date, return_date) VALUES
(1, 6, '2025-09-01', '2025-09-15', '2025-09-20'),
(2, 7, '2025-08-15', '2025-08-30', '2025-09-05'),
(3, 8, '2025-07-10', '2025-07-25', '2025-08-01'),
(4, 9, '2025-06-01', '2025-06-15', '2025-06-20'),
(5, 10, '2025-05-01', '2025-05-15', '2025-05-18');