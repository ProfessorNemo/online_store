# frozen_string_literal: true

class Buy < ApplicationRecord
  has_many :buy_books, dependent: :destroy
  has_many :books, through: :buy_books
  belongs_to :client
  has_many :buy_steps, dependent: :destroy
  has_many :steps, through: :buy_steps

  # Вывести номера всех оплаченных заказов и даты, когда они были оплачены.
  scope :request1, lambda {
    connection.select_all("SELECT buy_id, date_step_end
                                      FROM steps
                                          INNER JOIN buy_steps USING (step_id )
                                      WHERE buy_steps.step_id = 1 and date_step_end IS NOT Null")
  }

  # Вывести информацию о каждом заказе: его номер, кто его сформировал (фамилия пользователя) и его стоимость
  # (сумма произведений количества заказанных книг и их цены), в отсортированном по номеру заказа виде. Последний
  # столбец назвать Стоимость.
  scope :request2, lambda {
    connection.select_all("SELECT buy_id, name_client, SUM(price * buy_books.amount) as Стоимость
                                FROM clients
                                    INNER JOIN buys USING(client_id)
                                    INNER JOIN buy_books USING(buy_id)
                                    INNER JOIN books USING(book_id)
                                GROUP BY buy_id, name_client
                                ORDER BY buy_id")
  }

  # Вывести номера заказов (buy_id) и названия этапов, на которых они в данный момент находятся.
  # Если заказ доставлен –  информацию о нем не выводить. Информацию отсортировать по возрастанию buy_id.
  scope :request3, lambda {
    connection.select_all("SELECT buy_id, name_step
                                    FROM buy_steps
                                         JOIN steps USING(step_id)
                                    WHERE date_step_beg IS NOT NULL and date_step_end IS NULL
                                    ORDER BY buy_id")
  }
end
