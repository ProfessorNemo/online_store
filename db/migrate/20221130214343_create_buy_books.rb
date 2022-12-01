# frozen_string_literal: true

class CreateBuyBooks < ActiveRecord::Migration[6.1]
  def self.up
    execute <<~SQL.squish
      DROP TABLE IF EXISTS buy_books CASCADE;

      CREATE TABLE IF NOT EXISTS buy_books (
          buy_book_id serial PRIMARY KEY,
          buy_id INT,
          book_id INT,
          amount INT,
          FOREIGN KEY (buy_id) REFERENCES buys (buy_id),
          FOREIGN KEY (book_id)  REFERENCES books (book_id),
          created_at timestamp(6) NOT NULL,
          updated_at timestamp(6) NOT NULL
      );
    SQL
  end

  def self.down
    execute 'DROP TABLE buy_books'
  end
end
