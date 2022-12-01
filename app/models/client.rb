# frozen_string_literal: true

class Client < ApplicationRecord
  has_many :buys, dependent: :destroy
  belongs_to :city

  validates :email,
            presence: true,
            uniqueness: true,
            'valid_email_2/email': true

  # Вывести фамилии всех клиентов, которые заказали книгу Булгакова «Мастер и Маргарита».
  scope :request1, lambda {
    connection.select_all("SELECT DISTINCT name_client
                              FROM
                                  clients
                                  INNER JOIN buys USING(client_id)
                                  INNER JOIN buy_books USING(buy_id)
                                  INNER JOIN books USING(book_id)
                              WHERE title ='Мастер и Маргарита' and author_id = 1")
  }

  # Вывести все заказы Баранова Павла (id заказа, какие книги, по какой цене и в каком количестве он заказал)
  # в отсортированном по номеру заказа и названиям книг виде.
  scope :request2, lambda {
    connection.select_all("SELECT buy_books.buy_id, title, price, buy_books.amount
                                  FROM
                                      clients
                                      INNER JOIN buys USING(client_id)
                                      INNER JOIN buy_books USING(buy_id)
                                      INNER JOIN books USING(book_id)
                                  WHERE name_client LIKE 'Баранов Павел'
                                  ORDER BY buy_books.buy_id, title")
  }

  # Выбрать всех клиентов, которые заказывали книги Достоевского, информацию вывести в отсортированном
  # по алфавиту виде. В решении используйте фамилию автора, а не его id.
  scope :request3, lambda {
    connection.select_all("SELECT DISTINCT name_client
                                  FROM clients
                                      JOIN buys USING (client_id)
                                      JOIN buy_books USING (buy_id)
                                      JOIN books USING (book_id)
                                      JOIN authors USING (author_id)
                                  WHERE name_author LIKE 'Достоевский%'
                                  ORDER BY name_client")
  }

  # Посчитать количество потраченных каждым клиентом денег и отсортировать их в порядке убывания
  # для оценки общей активности каждого клиента:
  scope :request4, lambda {
    connection.select_all("SELECT
                              name_client,
                              SUM(buy_books.amount * books.price) as Сумма
                          FROM
                              buy_books
                              JOIN buys USING (buy_id)
                              JOIN clients USING (client_id)
                              JOIN books USING (book_id)
                          GROUP BY name_client
                          ORDER BY Сумма DESC")
  }

  # Вывести данные клиента, имеющего наибольшие расходы (наибольшую стоимость всех оплаченных заказов)
  scope :request5, lambda {
    connection.select_all("SELECT name_client, email, MAX(books.price * buy_books.amount) AS Общая_стоимость
                                  FROM buy_steps
                                      INNER JOIN buy_books USING(buy_id)
                                      INNER JOIN buys USING(buy_id)
                                      INNER JOIN steps USING(step_id)
                                      INNER JOIN books USING(book_id)
                                      INNER JOIN clients USING(client_id)
                                  WHERE buy_steps.step_id = 1 AND date_step_end IS NOT NULL
                                  GROUP BY name_client, email
                                  HAVING MAX(books.price * buy_books.amount) >= ALL(SELECT MAX(books.price * buy_books.amount) AS Общая_стоимость
                                                                   FROM buys
                                                                          INNER JOIN buy_books USING(buy_id)
                                                                          INNER JOIN buy_steps USING(buy_id)
                                                                          INNER JOIN books USING(book_id)
                                                                     WHERE buy_steps.step_id = 1 AND date_step_end IS NOT NULL
                                                                     GROUP BY buys.client_id)")
  }
end
