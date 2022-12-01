# frozen_string_literal: true

class BuyBook < ApplicationRecord
  belongs_to :book
  belongs_to :buy
end
