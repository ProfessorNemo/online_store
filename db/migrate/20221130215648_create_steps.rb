# frozen_string_literal: true

class CreateSteps < ActiveRecord::Migration[6.1]
  def self.up
    execute <<~SQL.squish
      DROP TABLE IF EXISTS steps CASCADE;

      CREATE TABLE IF NOT EXISTS steps (
          step_id INT GENERATED ALWAYS AS IDENTITY,
          name_step TEXT,
          PRIMARY KEY (step_id),
          CONSTRAINT uniq_name_step UNIQUE (name_step),
          created_at timestamp(6) NOT NULL,
          updated_at timestamp(6) NOT NULL
      );
    SQL
  end

  def self.down
    execute 'DROP TABLE steps'
  end
end
