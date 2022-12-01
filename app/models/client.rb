# frozen_string_literal: true

class Client < ApplicationRecord
  has_many :buys, dependent: :destroy
  belongs_to :city

  validates :email,
            presence: true,
            uniqueness: true,
            'valid_email_2/email': true
end
