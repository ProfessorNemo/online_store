# frozen_string_literal: true

class CreateCities < ActiveRecord::Migration[6.1]
  def self.up
    execute <<~SQL.squish
      DROP TABLE IF EXISTS cities CASCADE;

      CREATE TABLE cities (
          city_id INT GENERATED ALWAYS AS IDENTITY,
          name_city TEXT NOT NULL,
          days_delivery INT,
          PRIMARY KEY(city_id),
          CONSTRAINT uniq_city UNIQUE (name_city),
          created_at timestamp(6) NOT NULL,
          updated_at timestamp(6) NOT NULL
      );
    SQL
  end

  def self.down
    execute 'DROP TABLE cities'
  end
end
