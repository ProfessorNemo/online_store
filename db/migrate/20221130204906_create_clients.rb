# frozen_string_literal: true

class CreateClients < ActiveRecord::Migration[6.1]
  def self.up
    execute <<~SQL.squish
      DROP TABLE IF EXISTS clients CASCADE;

      CREATE TABLE IF NOT EXISTS clients (
          client_id serial PRIMARY KEY,
          name_client TEXT,
          city_id INT,
          email varchar(80) NOT NULL,
          FOREIGN KEY (city_id) REFERENCES cities (city_id),
          CONSTRAINT uniq_email UNIQUE (email),
          created_at timestamp(6) NOT NULL,
          updated_at timestamp(6) NOT NULL
      );
    SQL
  end

  def self.down
    execute 'DROP TABLE clients'
  end
end
