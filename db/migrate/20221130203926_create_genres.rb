# frozen_string_literal: true

class CreateGenres < ActiveRecord::Migration[6.1]
  def self.up
    execute <<~SQL.squish
      DROP TABLE IF EXISTS genres;

      CREATE TABLE genres (
          genre_id INT GENERATED ALWAYS AS IDENTITY,
          name_genre TEXT,
          PRIMARY KEY(genre_id),
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
