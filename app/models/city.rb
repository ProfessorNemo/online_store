# frozen_string_literal: true

class City < ApplicationRecord
  has_many :clients, dependent: nil
  validates :name_city, presence: true, uniqueness: true
end
