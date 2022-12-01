# frozen_string_literal: true

class Genre < ApplicationRecord
  has_many :books, dependent: :destroy
  validates :name_genre, presence: true, uniqueness: true
end
