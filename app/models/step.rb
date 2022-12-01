# frozen_string_literal: true

class Step < ApplicationRecord
  has_many :buy_steps, dependent: :destroy
  has_many :buys, through: :buy_steps
  validates :name_step, presence: true, uniqueness: true
end
