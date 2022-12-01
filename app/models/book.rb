# frozen_string_literal: true

class Book < ApplicationRecord
  belongs_to :author
  belongs_to :genre
  has_many :buy_books, dependent: :destroy
  has_many :buys, through: :buy_books

  # Уменьшить количество тех книг на складе, которые были включены в заказ с номером 5.
  scope :request1, lambda {
    connection.select_all("UPDATE books
                               SET amount = books.amount - buy_books.amount
                               FROM buy_books
                               WHERE buy_books.buy_id = 5 AND books.book_id = buy_books.book_id")
  }
end
