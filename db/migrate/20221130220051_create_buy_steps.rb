# frozen_string_literal: true

class CreateBuySteps < ActiveRecord::Migration[6.1]
  def self.up
    execute <<~SQL.squish
      DROP TABLE IF EXISTS buy_steps CASCADE;

      CREATE TABLE IF NOT EXISTS buy_steps (
          buy_step_id serial PRIMARY KEY,
          buy_id INT,
          step_id INT,
          date_step_beg DATE,
          date_step_end DATE,
          FOREIGN KEY (buy_id) REFERENCES buys (buy_id),
          FOREIGN KEY (step_id)  REFERENCES steps (step_id)
      );
    SQL
  end

  def self.down
    execute 'DROP TABLE buy_steps'
  end
end
