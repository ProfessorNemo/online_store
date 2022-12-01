# frozen_string_literal: true

class CreateGenres < ActiveRecord::Migration[6.1]
  def self.up
    execute <<~SQL.squish
      DROP TABLE IF EXISTS genres;

      CREATE TABLE genres (
          genre_id serial PRIMARY KEY,
          name_genre TEXT,
          CONSTRAINT uniq_genre UNIQUE (name_genre),
          created_at timestamp(6) NOT NULL,
          updated_at timestamp(6) NOT NULL
      );
    SQL
  end

  def self.down
    execute 'DROP TABLE genres'
  end
end
