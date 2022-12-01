# frozen_string_literal: true

class BuyStep < ApplicationRecord
  belongs_to :buy
  belongs_to :step
end
