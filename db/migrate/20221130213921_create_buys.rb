# frozen_string_literal: true

class CreateBuys < ActiveRecord::Migration[6.1]
  def self.up
    execute <<~SQL.squish
      DROP TABLE IF EXISTS buys CASCADE;

      CREATE TABLE IF NOT EXISTS buys (
          buy_id INT GENERATED ALWAYS AS IDENTITY,
          buy_description TEXT,
          client_id  INT DEFAULT (NULL),
          PRIMARY KEY(buy_id),
          FOREIGN KEY (client_id) REFERENCES clients (client_id),
          created_at timestamp(6) NOT NULL,
          updated_at timestamp(6) NOT NULL
      );
    SQL
  end

  def self.down
    execute 'DROP TABLE buys'
  end
end
