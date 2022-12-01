# frozen_string_literal: true

class Buy < ApplicationRecord
  has_many :buy_books, dependent: :destroy
  has_many :books, through: :buy_books
  belongs_to :client
  has_many :buy_steps, dependent: :destroy
  has_many :steps, through: :buy_steps
end
