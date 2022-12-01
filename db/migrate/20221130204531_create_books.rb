# frozen_string_literal: true

class CreateBooks < ActiveRecord::Migration[6.1]
  def self.up
    execute <<~SQL.squish
      DROP TABLE IF EXISTS books CASCADE;

      CREATE TABLE books (
          book_id serial PRIMARY KEY,
          title TEXT,
          author_id INT NOT NULL,
          genre_id INT,
          price NUMERIC(8, 2),
          amount INT,
          FOREIGN KEY (author_id) REFERENCES authors (author_id) ON DELETE CASCADE,
          FOREIGN KEY (genre_id)  REFERENCES genres (genre_id) ON DELETE SET NULL,
          created_at timestamp(6) NOT NULL,
          updated_at timestamp(6) NOT NULL
      );
    SQL
  end

  def self.down
    execute 'DROP TABLE books'
  end
end
