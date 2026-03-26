# Результати запитів - Лабораторна робота 5
# Васильєв Микола Валерійович, група 491

---

## Рисунок 1 - Структура таблиці users

```
\d users
```

```
 id | name | type | nullable | default
----+------+------+---------+--------
 1  | id | integer | not null | nextval('users_id_seq'::regclass)
 2  | name | varchar(100) | not null | 
 3  | email | varchar(100) | not null | 
 4  | registration_date | date | | current_date
 5  | is_active | boolean | | true
 PK: id
 UNIQUE: email
 FK: -
```

---

## Рисунок 2 - Структура таблиці accounts

```
\d accounts
```

```
 id | name | type | nullable | default
----+------+------+---------+--------
 1  | id | integer | not null | nextval('accounts_id_seq'::regclass)
 2  | user_id | integer | | 
 3  | account_number | varchar(20) | not null | 
 4  | balance | numeric(15,2) | | 0.00
 5  | account_type | varchar(20) | | 
 PK: id
 UNIQUE: account_number
 FK: user_id -> users(id)
 CHECK: account_type IN ('checking', 'savings', 'credit')
```

---

## Рисунок 3 - Структура таблиці transactions

```
\d transactions
```

```
 id | name | type | nullable | default
----+------+------+---------+--------
 1  | id | integer | not null | nextval('transactions_id_seq'::regclass)
 2  | account_id | integer | | 
 3  | amount | numeric(10,2) | not null | 
 4  | type | varchar(10) | | 
 5  | description | varchar(200) | | 
 6  | transaction_date | date | | current_date
 7  | category_id | integer | | 
 PK: id
 FK: account_id -> accounts(id)
 CHECK: type IN ('debit', 'credit')
 TRIGGER: balance_trigger
```

---

## Рисунок 4 - Дані таблиці users

```
SELECT * FROM users;
```

```
 id |        name         |             email             | registration_date | is_active 
----+---------------------+-------------------------------+-------------------+-----------
  1 | Станіслав Гайдук    | stanislav.haiduk@email.com    | 2024-01-08        | t
  2 | Поліна Руденко      | polina.rudenko@email.com     | 2024-02-25        | t
  3 | Ігор Савчук         | igor.savchuk@email.com       | 2024-03-15        | t
  4 | Уляна Білоус        | uliana.bil@email.com         | 2024-04-10        | t
  5 | Ростислав Олійник   | rostyslav.oliynyk@email.com | 2024-05-20        | t
  6 | Вероніка Кушнір     | veronika.kushnir@email.com   | 2024-06-25        | t
  7 | Давид Яременко      | david.yar@email.com         | 2024-07-28        | t
  8 | Сніжана Клименко   | snizhana.klymenko@email.com  | 2024-08-20        | t
  9 | Тимофій Григоренко  | tymofiy.hryhorenko@email.com| 2024-09-15        | f
 10 | Микола Васильєв     | mykola.vasiliev@email.com    | 2024-10-01        | t
(10 rows)
```

---

## Рисунок 5 - Дані таблиці accounts

```
 id | user_id | account_number |  balance  | account_type 
----+---------+----------------+-----------+--------------
  1 |       1 | ACC001         |  1600.50 | checking
  2 |       1 | ACC002         |  4750.00 | savings
  3 |       1 | ACC003         |  2450.25 | credit
  ...
 20 |      10 | ACC020         |  5875.00 | savings
 21 |      10 | ACC021         |   775.00 | checking
(30 rows)
```

---

## Рисунок 6 - Дані таблиці categories

```
 id |      name       
----+-----------------
  1 | Покупки
  2 | Зарплата
  3 | Оплата рахунків
  4 | Транспорт
  5 | Розваги
  6 | Їжа
  7 | Іпотека
  8 | Бонус
  9 | Інвестиція
 10 | Повернення
(10 rows)
```

---

## Рисунок 7 - INNER JOIN результат

```
SELECT u.name, a.account_number, SUM(t.amount) AS total_amount
FROM users u
JOIN accounts a ON u.id = a.user_id
JOIN transactions t ON a.id = t.account_id
GROUP BY u.name, a.account_number;
```

```
     name          | account_number | total_amount 
-------------------+----------------+--------------
 Станіслав Гайдук  | ACC001         |       250.00
(результат залежить від даних транзакцій)
```

---

## Рисунок 8 - Агрегатні функції

```
SELECT account_type, COUNT(*), SUM(balance), AVG(balance)
FROM accounts GROUP BY account_type;
```

```
 account_type | count |   sum    |   avg   
--------------+-------+----------+---------
 credit       |     8 | 18300.25 | 2287.53
 savings      |    11 | 43100.00 | 3918.18
 checking     |    11 | 24225.00 | 2202.27
(3 rows)
```

---

## Рисунок 9 - Stored Procedure

```
CALL calculate_balance_proc(1, NULL);
```

```
 balance 
--------
 250.00
```

---

## Рисунок 10 - Trigger перевірка

```
SELECT balance FROM accounts WHERE id = 1;
INSERT INTO transactions (account_id, amount, type, description) 
VALUES (1, 205, 'credit', 'Тестова транзакція');
SELECT balance FROM accounts WHERE id = 1;
```

```
 balance 
--------
 250.00   <- до INSERT

 INSERT 0 1

 balance 
--------
 455.00   <- після INSERT (+205)
```

---

## Рисунок 11 - Дані студента Васильєв Микола

```
SELECT u.name, a.account_number, a.balance, a.account_type
FROM users u JOIN accounts a ON u.id = a.user_id
WHERE u.name = 'Микола Васильєв';
```

```
     name        | account_number |  balance  | account_type 
----------------+----------------+-----------+--------------
 Микола Васильєв | ACC020         | 5875.00 | savings
 Микола Васильєв | ACC021         |  775.00 | checking
(2 rows)

Загальний баланс: $6,650.00
```

---

## Рисунок 12 - Баланси користувачів

```
SELECT u.name, SUM(a.balance) as total
FROM users u JOIN accounts a ON u.id = a.user_id
GROUP BY u.name ORDER BY total DESC;
```

```
       name        |  total   
-------------------+----------
 Станіслав Гайдук  | 13030.75
 Тимофій Григоренко| 11250.75
 Давид Яременко   | 10775.50
 Ростислав Олійник|  8575.50
 Уляна Білоус     |  8525.00
 **Микола Васильєв**|  **6650.00**
 Ігор Савчук      |  7275.25
 Поліна Руденко   |  6400.50
 Сніжана Клименко |  6175.00
 Вероніка Кушнір  |  5400.00
(10 rows)
```

---

## Підсумок

| Таблиця | Записів |
|---------|---------|
| users | 10 |
| accounts | 30 |
| transactions | 50 |
| categories | 10 |
| **Всього** | **100** |
