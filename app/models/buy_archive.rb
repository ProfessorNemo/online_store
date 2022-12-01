# frozen_string_literal: true

class BuyArchive < ApplicationRecord
  # Сравнить ежемесячную выручку от продажи книг за текущий и предыдущий годы.
  # Для этого вывести год, месяц, сумму выручки в отсортированном сначала по
  # возрастанию месяцев, затем по возрастанию лет виде. Название столбцов: Год, Месяц, Сумма.
  scope :request1, lambda {
    connection.select_all("SELECT EXTRACT( YEAR FROM date_payment ) AS Год,
                               to_char(date_payment, 'TMMonth') AS Месяц,
                               SUM(amount * price) AS Сумма
                            FROM buy_archives
                            GROUP BY 1,2
                            UNION ALL
                            SELECT EXTRACT( YEAR FROM date_step_beg ) AS Год,
                                   to_char(date_step_beg, 'TMMonth') AS Месяц,
                                   SUM(books.price * buy_books.amount) AS Сумма
                            FROM books
                               JOIN buy_books USING(book_id)
                               JOIN buy_steps USING(buy_id)
                               JOIN steps USING(step_id)
                            WHERE name_step = 'Оплата' AND date_step_end is NOT NULL
                            GROUP BY EXTRACT( YEAR FROM date_step_beg ), to_char(date_step_beg, 'TMMonth')
                            ORDER BY 2, 1")
  }

  # Для каждой отдельной книги необходимо вывести информацию о количестве проданных экземпляров
  # и их стоимости за 2020 и 2019 год . Вычисляемые столбцы назвать Количество и Сумма.
  # Информацию отсортировать по убыванию стоимости.
  scope :request2, lambda {
    connection.select_all("SELECT title, SUM(Количество) AS Количество, SUM(Сумма) AS Сумма
                              FROM ( SELECT title, SUM(buy_books.amount) AS Количество,
                                   SUM(books.price * buy_books.amount) AS Сумма
                                   FROM buy_books
                                       JOIN books USING (book_id)
                                       JOIN buys USING(buy_id)
                                       JOIN buy_steps USING(buy_id)
                                       JOIN steps USING(step_id)
                                   WHERE name_step ='Оплата' AND date_step_end IS NOT NULL
                              GROUP BY title
                              UNION ALL
                              SELECT title, SUM(buy_archives.amount) AS Количество,
                                     SUM(buy_archives.price * buy_archives.amount) AS Сумма
                                     FROM buy_archives
                                          JOIN books USING (book_id)
                              GROUP BY books.title ) AS dummy
                              GROUP BY title
                              ORDER BY Сумма DESC")
  }
end
