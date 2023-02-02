# frozen_string_literal: true

class Genre < ApplicationRecord
  has_many :books, dependent: :destroy
  validates :name_genre, presence: true, uniqueness: true

  # Вывести жанр (или жанры), в котором было заказано больше всего экземпляров книг,
  # указать это количество. Последний столбец назвать Количество.
  scope :request1, lambda {
    connection.select_all("SELECT name_genre, SUM(buy_books.amount) as Количество
                                  FROM genres
                                      JOIN books USING(genre_id)
                                      JOIN buy_books USING(book_id)
                                  GROUP BY name_genre
                                  ORDER BY Количество DESC
                                  LIMIT 1")
  }

  def self.actions_sql
    connection.select_all("SELECT name_genre, SUM(buy_books.amount) as Количество
                                  FROM genres
                                      JOIN books USING(genre_id)
                                      JOIN buy_books USING(book_id)
                                  GROUP BY name_genre
                                  ORDER BY Количество DESC
                                  LIMIT 1")
  end
end
