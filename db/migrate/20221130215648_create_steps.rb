# frozen_string_literal: true

class CreateSteps < ActiveRecord::Migration[6.1]
  def self.up
    execute <<~SQL.squish
      DROP TABLE IF EXISTS steps CASCADE;

      CREATE TABLE IF NOT EXISTS steps (
          step_id serial PRIMARY KEY,
          name_step TEXT,
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
