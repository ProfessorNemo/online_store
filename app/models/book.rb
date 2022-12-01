# frozen_string_literal: true

class Book < ApplicationRecord
  belongs_to :author
  belongs_to :genre
  has_many :buy_books, dependent: :destroy
  has_many :buys, through: :buy_books
end
