# frozen_string_literal: true

class CreateBuySteps < ActiveRecord::Migration[6.1]
  def self.up
    execute <<~SQL.squish
      DROP TABLE IF EXISTS buy_steps CASCADE;

      CREATE TABLE IF NOT EXISTS buy_steps (
          buy_step_id INT GENERATED ALWAYS AS IDENTITY,
          buy_id INT,
          step_id INT,
          date_step_beg DATE,
          date_step_end DATE,
          PRIMARY KEY (buy_step_id),
          FOREIGN KEY (buy_id) REFERENCES buys (buy_id),
          FOREIGN KEY (step_id)  REFERENCES steps (step_id),
          CONSTRAINT uniq_step UNIQUE (buy_id, step_id),
          created_at timestamp(6) NOT NULL,
          updated_at timestamp(6) NOT NULL
      );
    SQL
  end

  def self.down
    execute 'DROP TABLE buy_steps'
  end
end
