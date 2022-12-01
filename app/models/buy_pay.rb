# frozen_string_literal: true

class BuyPay < ApplicationRecord

  # 1. Создать общий счет (таблицу buy_pays) на оплату заказа с номером 5. Куда включить номер заказа,
  # количество книг в заказе (название столбца Количество) и его общую стоимость (название столбца Итого).
  # Для решения используйте ОДИН запрос.

  # 2. В таблицу buy_steps для заказа с номером 5 включить все этапы из таблицы steps, которые должен пройти
  # этот заказ. В столбцы date_step_beg и date_step_end всех записей занести Null.

  # 3. В таблицу buy_step занести дату 12.04.2020 выставления счета на оплату заказа с номером 5.
  # Правильнее было бы занести не конкретную, а текущую дату. Это можно сделать с помощью функции Now().
  # Но при этом в разные дни будут вставляться разная дата, и задание нельзя будет проверить, поэтому
  # вставим дату 12.04.2020.

  # 4. Завершить этап «Оплата» для заказа с номером 5, вставив в столбец date_step_end дату 13.04.2020,
  # и начать следующий этап («Упаковка»), задав в столбце date_step_beg для этого этапа ту же дату.
  # Реализовать два запроса для завершения этапа и начале следующего. Они должны быть записаны в общем виде,
  # чтобы его можно было применять для любых этапов, изменив только текущий этап.
  # Для примера пусть это будет этап «Оплата».
  #
  scope :request1, lambda {
    connection.select_all("CREATE TABLE buy_pays AS
                                SELECT
                                  buy_id,
                                  SUM(buy_books.amount) as Количество,
                                  SUM(books.price * buy_books.amount) as Итого
                                FROM
                                  buy_books
                                  JOIN books USING (book_id)
                                  JOIN authors USING (author_id)
                                WHERE buy_id = 5
                                GROUP BY buy_id
                                ORDER BY buy_id")
  }

  scope :request2, lambda {
    connection.select_all("INSERT INTO buy_steps (buy_id, step_id, date_step_beg, date_step_end)
                                SELECT buy_id, step_id, Null, Null
                                FROM buys
                                CROSS JOIN steps
                                WHERE buy_id = 5")
  }

  scope :request3, lambda {
    connection.select_all("UPDATE buy_steps SET date_step_beg = '2020-04-12'
                           WHERE buy_id = 5 AND step_id = 1")
  }

  scope :request4, lambda {
    connection.select_all("UPDATE buy_steps
                              SET date_step_end = CASE
                                                     WHEN step_id = (
                                                                      SELECT step_id
                                                                      FROM steps
                                                                      WHERE name_step = 'Оплата')
                                                     THEN '2020-04-13'
                                                     ELSE date_step_end
                                                  END,
                                  date_step_beg = CASE
                                                     WHEN step_id = (
                                                                      SELECT step_id
                                                                      FROM steps
                                                                      WHERE name_step = 'Упаковка')
                                                     THEN '2020-04-13'
                                                     ELSE date_step_beg
                                                   END
                              WHERE buy_id = 5")
  }
end
