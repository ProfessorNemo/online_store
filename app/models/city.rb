# frozen_string_literal: true

class City < ApplicationRecord
  has_many :clients, dependent: nil
  validates :name_city, presence: true, uniqueness: true

  # Вывести города, в которых живут клиенты, оформлявшие заказы в интернет-магазине.
  # Указать количество заказов в каждый город, этот столбец назвать Количество.
  # Информацию вывести по убыванию количества заказов, а затем в алфавитном порядке по названию городов.
  scope :request1, lambda {
    connection.select_all("SELECT name_city, COUNT(client_id) AS Количество
                                  FROM buys
                                      INNER JOIN clients USING (client_id)
                                      INNER JOIN cities USING (city_id)
                                  GROUP BY name_city, client_id
                                  ORDER BY Количество DESC, name_city")
  }

  # В таблице cities для каждого города указано количество дней, за которые заказ может быть доставлен в этот город
  # (рассматривается только этап Транспортировка). Для тех заказов, которые прошли этап транспортировки,
  # вывести количество дней за которое заказ реально доставлен в город. А также, если заказ доставлен с опозданием,
  # указать количество дней задержки, в противном случае вывести 0. В результат включить номер заказа (buy_id),
  # а также вычисляемые столбцы Количество_дней и Опоздание. Информацию вывести в отсортированном по номеру заказа виде.
  scope :request2, lambda {
    connection.select_all("SELECT buy_id, (date_step_end::date - date_step_beg::date) AS Количество_дней,
                              CASE
                                WHEN (date_step_end::date - date_step_beg::date) <= days_delivery THEN 0
                                ELSE (date_step_end::date - date_step_beg::date) - days_delivery
                              END AS Опоздание
                            FROM buy_steps JOIN buys USING(buy_id)
                                          JOIN clients USING(client_id)
                                          JOIN cities USING(city_id)
                            WHERE step_id = 3 AND (date_step_end::date - date_step_beg::date) IS NOT NULL
                            ORDER BY buy_id")
  }

  # Анализ по городам, показатели: количество Клиентов, Вариация заказа разных книг, Количество клиентов, Сумма продаж
  scope :request3, lambda {
    connection.select_all("SELECT name_city,
                                  COUNT(clients.client_id) AS Клиенты,
                                  COUNT(title) AS Вариация_книг,
                                  SUM(buy_books.amount) AS Количество_книг,
                                  SUM(buy_books.amount * books.price) AS Сумма_продаж
                                FROM cities
                                    JOIN clients USING(city_id)
                                    JOIN buys USING(client_id)
                                    JOIN buy_books USING(buy_id)
                                    JOIN books USING(book_id)
                                GROUP BY name_city
                                ORDER BY Сумма_продаж DESC")
  }
end
