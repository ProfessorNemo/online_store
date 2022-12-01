# frozen_string_literal: true

class Author < ApplicationRecord
  has_many :books, dependent: :destroy
  validates :name_author, presence: true, uniqueness: true
end
