-- База даних: financial_database_vasiliev
-- Васильєв Микола Валерійович, група 491
-- Лабораторна робота 5 - Складні SQL запити

DROP TABLE IF EXISTS transactions CASCADE;
DROP TABLE IF EXISTS accounts CASCADE;
DROP TABLE IF EXISTS users CASCADE;
DROP TABLE IF EXISTS categories CASCADE;

CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    registration_date DATE DEFAULT CURRENT_DATE,
    is_active BOOLEAN DEFAULT TRUE
);

CREATE TABLE accounts (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(id),
    account_number VARCHAR(20) UNIQUE NOT NULL,
    balance DECIMAL(15,2) DEFAULT 0.00,
    account_type VARCHAR(20) CHECK (account_type IN ('checking', 'savings', 'credit'))
);

CREATE TABLE transactions (
    id SERIAL PRIMARY KEY,
    account_id INTEGER REFERENCES accounts(id),
    amount DECIMAL(10,2) NOT NULL,
    type VARCHAR(10) CHECK (type IN ('debit', 'credit')),
    description VARCHAR(200),
    transaction_date DATE DEFAULT CURRENT_DATE,
    category_id INTEGER
);

CREATE TABLE categories (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) UNIQUE NOT NULL
);

ALTER TABLE transactions ADD COLUMN IF NOT EXISTS category_id INTEGER REFERENCES categories(id);

INSERT INTO users (name, email, registration_date, is_active) VALUES
('Станіслав Гайдук','stanislav.haiduk@email.com','2024-01-08',TRUE),
('Поліна Руденко','polina.rudenko@email.com','2024-02-25',TRUE),
('Ігор Савчук','igor.savchuk@email.com','2024-03-15',TRUE),
('Уляна Білоус','uliana.bil@email.com','2024-04-10',TRUE),
('Ростислав Олійник','rostyslav.oliynyk@email.com','2024-05-20',TRUE),
('Вероніка Кушнір','veronika.kushnir@email.com','2024-06-25',TRUE),
('Давид Яременко','david.yar@email.com','2024-07-28',TRUE),
('Сніжана Клименко','snizhana.klymenko@email.com','2024-08-20',TRUE),
('Тимофій Григоренко','tymofiy.hryhorenko@email.com','2024-09-15',FALSE),
('Микола Васильєв','mykola.vasiliev@email.com','2024-10-01',TRUE);

INSERT INTO accounts (user_id, account_number, balance, account_type) VALUES
(1,'ACC001',1600.50,'checking'),(1,'ACC002',4750.00,'savings'),(1,'ACC003',2450.25,'credit'),
(2,'ACC004',800.00,'checking'),(2,'ACC005',1275.50,'savings'),
(3,'ACC006',3375.00,'checking'),(3,'ACC007',2675.25,'credit'),
(4,'ACC008',900.00,'savings'),
(5,'ACC009',2075.00,'credit'),(5,'ACC010',4375.50,'savings'),(5,'ACC011',600.00,'checking'),
(6,'ACC012',1325.00,'savings'),(6,'ACC013',900.00,'checking'),
(7,'ACC014',2975.50,'credit'),(7,'ACC015',650.00,'savings'),(7,'ACC016',1525.00,'checking'),
(8,'ACC017',2875.00,'credit'),(8,'ACC018',975.00,'savings'),
(9,'ACC019',5175.25,'checking'),
(10,'ACC020',5875.00,'savings'),(10,'ACC021',775.00,'checking'),
(1,'ACC022',1825.00,'savings'),(2,'ACC023',3175.00,'credit'),
(3,'ACC024',1075.00,'checking'),(4,'ACC025',5525.00,'savings'),
(5,'ACC026',325.00,'credit'),(6,'ACC027',2025.00,'checking'),
(7,'ACC028',3425.00,'savings'),(8,'ACC029',1175.00,'credit'),
(9,'ACC030',6075.50,'checking');

INSERT INTO categories (name) VALUES
('Покупки'),('Зарплата'),('Оплата рахунків'),('Транспорт'),('Розваги'),
('Їжа'),('Іпотека'),('Бонус'),('Інвестиція'),('Повернення');

INSERT INTO transactions (account_id, amount, type, description, transaction_date) VALUES
(1,100.00,'debit','Продукти','2024-11-01'),(1,510.00,'credit','Зарплата за роботу','2024-11-05'),
(2,210.00,'debit','Комунальні послуги','2024-11-08'),
(3,155.00,'debit','Транспортна карта','2024-11-13'),
(5,260.00,'debit','Онлайн ігри','2024-11-18'),(5,315.00,'credit','Відсотки по рахунку','2024-11-23'),
(9,410.00,'debit','Оренда','2024-11-10'),(9,575.00,'credit','Performance bonus','2024-11-14'),
(9,75.00,'debit','Сніданок','2024-11-16'),(9,145.00,'credit','Cash back','2024-11-20'),
(9,195.00,'debit','Книги','2024-11-26'),
(10,70.00,'debit','Кава','2024-11-02'),(10,360.00,'credit','Стейблкойн інвестиція','2024-11-12'),
(10,105.00,'debit','Онлайн навчання','2024-11-18'),
(11,125.00,'debit','Аксесуар для телефону','2024-11-16'),
(14,88.00,'debit','Светр','2024-11-01'),(14,295.00,'credit','Рекламація товару','2024-11-06'),
(15,112.00,'debit','Басейн','2024-11-07'),(15,340.00,'credit','Тимчасова робота','2024-11-12'),
(15,68.00,'debit','Comedy Club','2024-11-17'),
(17,138.00,'debit','Катання на лижах','2024-11-02'),(17,450.00,'credit','Біржовий трейдинг','2024-11-07'),
(17,95.00,'debit','Аудіокниги','2024-11-10'),(17,325.00,'credit','Продаж на маркетплейсі','2024-11-15'),
(20,142.00,'debit','Боулінг','2024-11-20'),(20,480.00,'credit','Процентний бонус','2024-11-25'),
(22,105.00,'debit','Дорога','2024-11-03'),(22,340.00,'credit','Додаткові години','2024-11-08'),
(22,165.00,'debit','Піца з друзями','2024-11-12'),
(25,85.00,'debit','Борщ','2024-11-21'),(25,275.00,'credit','Компенсація витрат','2024-11-26'),
(27,125.00,'debit','Кросівки для бігу','2024-11-04'),(27,445.00,'credit','Зарплата','2024-11-09'),
(27,142.00,'debit','Спортивне харчування','2024-11-10'),
(29,165.00,'debit','Escape room','2024-11-22'),(29,580.00,'credit','IDO токени','2024-11-27'),
(30,185.00,'debit','Мандрівка на природу','2024-11-05'),(30,605.00,'credit','Продаж книги','2024-11-10'),
(30,205.00,'debit','Театральна вистава','2024-11-13'),
(1,225.00,'debit','Метро','2024-11-23'),
(2,245.00,'debit','Мясо та овочі','2024-11-06'),
(3,265.00,'debit','Підписка на курси','2024-11-14'),
(5,285.00,'debit','Капучіно','2024-11-24'),
(7,305.00,'debit','Ремінь','2024-11-07'),
(10,325.00,'debit','Протеїн','2024-11-15'),
(14,345.00,'debit','Мультфільм','2024-11-25'),
(15,365.00,'debit','Поїздка до Одеси','2024-11-09'),
(17,385.00,'debit','Квиток на концерт','2024-11-17'),
(20,405.00,'debit','Настільна гра','2024-11-26'),
(22,425.00,'credit','Від батьків','2024-11-28');

UPDATE transactions SET category_id = CASE
    WHEN description ILIKE '%зарплат%' OR description ILIKE '%години%' THEN (SELECT id FROM categories WHERE name='Зарплата')
    WHEN description ILIKE '%іпотек%' OR description ILIKE '%оренд%' THEN (SELECT id FROM categories WHERE name='Іпотека')
    WHEN description ILIKE '%бонус%' OR description ILIKE '%performance%' OR description ILIKE '%cash back%' OR description ILIKE '%компенсац%' THEN (SELECT id FROM categories WHERE name='Бонус')
    WHEN description ILIKE '%інвест%' OR description ILIKE '%стейбл%' OR description ILIKE '%трейдинг%' OR description ILIKE '%токен%' OR description ILIKE '%ідо%' THEN (SELECT id FROM categories WHERE name='Інвестиція')
    WHEN description ILIKE '%повернен%' OR description ILIKE '%рекламац%' THEN (SELECT id FROM categories WHERE name='Повернення')
    WHEN description ILIKE '%їж%' OR description ILIKE '%сніданок%' OR description ILIKE '%кава%' OR description ILIKE '%піца%' OR description ILIKE '%борщ%' OR description ILIKE '%овочі%' THEN (SELECT id FROM categories WHERE name='Їжа')
    WHEN description ILIKE '%транспорт%' OR description ILIKE '%дорог%' OR description ILIKE '%метро%' THEN (SELECT id FROM categories WHERE name='Транспорт')
    WHEN description ILIKE '%комунальн%' THEN (SELECT id FROM categories WHERE name='Оплата рахунків')
    WHEN description ILIKE '%покуп%' OR description ILIKE '%аксесуар%' THEN (SELECT id FROM categories WHERE name='Покупки')
    ELSE (SELECT id FROM categories WHERE name='Розваги')
END;

-- Базові SELECT
SELECT * FROM transactions WHERE account_id = 1;
SELECT * FROM transactions WHERE account_id = 9 ORDER BY transaction_date DESC;
SELECT * FROM transactions WHERE account_id = 20 AND type = 'credit';

-- Сортування
SELECT * FROM transactions ORDER BY transaction_date DESC;
SELECT * FROM transactions ORDER BY amount DESC, transaction_date;

-- INNER JOIN
SELECT u.name, a.account_number, SUM(t.amount) AS total_amount
FROM users u
JOIN accounts a ON u.id = a.user_id
JOIN transactions t ON a.id = t.account_id
GROUP BY u.name, a.account_number;

-- LEFT JOIN
SELECT u.name, a.account_number
FROM users u
LEFT JOIN accounts a ON u.id = a.user_id
LEFT JOIN transactions t ON a.id = t.account_id
WHERE t.id IS NULL;

-- CROSS JOIN
SELECT u.name, t.description, t.amount
FROM users u
CROSS JOIN transactions t
LIMIT 6;

-- FULL OUTER JOIN
SELECT a.account_number, t.id AS transaction_id, t.amount
FROM accounts a
FULL OUTER JOIN transactions t ON a.id = t.account_id;

-- Агрегатні функції
SELECT account_type, SUM(balance) AS sum_balance FROM accounts GROUP BY account_type;
SELECT account_type, AVG(balance) AS avg_balance FROM accounts GROUP BY account_type;
SELECT type, COUNT(*) AS txn_count, SUM(amount) AS sum_amount FROM transactions GROUP BY type;

-- Оновлення
UPDATE accounts SET balance = balance + 1000 WHERE account_type = 'savings';
SELECT account_number, balance FROM accounts WHERE account_type = 'savings';

UPDATE accounts a SET balance = a.balance + 50
FROM users u
WHERE a.user_id = u.id AND u.is_active = TRUE;
SELECT a.account_number, a.balance
FROM accounts a JOIN users u ON a.user_id = u.id
WHERE u.is_active = TRUE;

-- Видалення
DELETE FROM transactions WHERE transaction_date < CURRENT_DATE - INTERVAL '60 days';
SELECT * FROM transactions WHERE transaction_date < CURRENT_DATE - INTERVAL '60 days';

DELETE FROM transactions USING accounts
WHERE transactions.account_id = accounts.id AND accounts.balance < 0;
SELECT a.account_number, a.balance FROM accounts a WHERE a.balance < 0;

-- Підзапити
SELECT a.account_number, SUM(t.amount) AS total_amount
FROM accounts a JOIN transactions t ON a.id = t.account_id
GROUP BY a.account_number
ORDER BY total_amount DESC
LIMIT 1;

SELECT u.name, SUM(t.amount) AS total_amount
FROM users u
JOIN accounts a ON u.id = a.user_id
JOIN transactions t ON a.id = t.account_id
GROUP BY u.name
HAVING SUM(t.amount) > 200;

SELECT t.id, a.account_number, t.amount, t.type, c.name AS category, t.description, t.transaction_date
FROM transactions t
JOIN accounts a ON t.account_id = a.id
LEFT JOIN categories c ON t.category_id = c.id
ORDER BY t.id;

SELECT c.id, c.name
FROM categories c
WHERE (SELECT COALESCE(SUM(t.amount),0) FROM transactions t WHERE t.category_id = c.id) > 100;

-- Stored Procedure
CREATE OR REPLACE PROCEDURE calculate_balance_proc(p_account_id INT, OUT balance DECIMAL)
LANGUAGE plpgsql AS $$
BEGIN
    SELECT COALESCE(SUM(CASE WHEN type='credit' THEN amount ELSE -amount END),0)
    INTO balance
    FROM transactions t
    WHERE t.account_id = p_account_id;
END;
$$;

CALL calculate_balance_proc(1, NULL);

-- Trigger
CREATE OR REPLACE FUNCTION update_balance() RETURNS TRIGGER AS $$
BEGIN
    IF TG_OP = 'INSERT' THEN
        UPDATE accounts
        SET balance = balance + (CASE WHEN NEW.type='credit' THEN NEW.amount ELSE -NEW.amount END)
        WHERE id = NEW.account_id;
    ELSIF TG_OP = 'UPDATE' THEN
        UPDATE accounts
        SET balance = balance
            - (CASE WHEN OLD.type='credit' THEN OLD.amount ELSE -OLD.amount END)
            + (CASE WHEN NEW.type='credit' THEN NEW.amount ELSE -NEW.amount END)
        WHERE id = NEW.account_id;
    ELSIF TG_OP = 'DELETE' THEN
        UPDATE accounts
        SET balance = balance - (CASE WHEN OLD.type='credit' THEN OLD.amount ELSE -OLD.amount END)
        WHERE id = OLD.account_id;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS balance_trigger ON transactions;
CREATE TRIGGER balance_trigger
AFTER INSERT OR UPDATE OR DELETE ON transactions
FOR EACH ROW EXECUTE FUNCTION update_balance();

-- Тест trigger
SELECT balance FROM accounts WHERE id = 1;
INSERT INTO transactions (account_id, amount, type, description) VALUES (1, 205.00, 'credit', 'Тестова транзакція');
SELECT balance FROM accounts WHERE id = 1;

-- Звіт
SELECT u.name, a.account_number, a.balance, a.account_type
FROM users u JOIN accounts a ON u.id = a.user_id
WHERE u.name = 'Микола Васильєв';

SELECT u.name, SUM(a.balance) as total
FROM users u JOIN accounts a ON u.id = a.user_id
GROUP BY u.name ORDER BY total DESC;
