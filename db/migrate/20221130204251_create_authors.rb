# frozen_string_literal: true

class CreateAuthors < ActiveRecord::Migration[6.1]
  def self.up
    execute <<~SQL.squish
      DROP TABLE IF EXISTS authors;

      CREATE TABLE authors (
          author_id INT GENERATED ALWAYS AS IDENTITY,
          name_author TEXT,
          PRIMARY KEY(author_id),
          CONSTRAINT uniq_author UNIQUE (name_author),
          created_at timestamp(6) NOT NULL,
          updated_at timestamp(6) NOT NULL
      );
    SQL
  end

  def self.down
    execute 'DROP TABLE authors'
  end
end
