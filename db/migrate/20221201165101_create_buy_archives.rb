# frozen_string_literal: true

class CreateBuyArchives < ActiveRecord::Migration[6.1]
  def self.up
    execute <<~SQL.squish
      DROP TABLE IF EXISTS buy_archives;

      CREATE TABLE buy_archives (
          buy_archive_id serial PRIMARY KEY,
          buy_id         INT,
          client_id      INT,
          book_id        INT,
          date_payment   DATE,
          amount         INT,
          price          NUMERIC(8, 2)
      );

      INSERT INTO buy_archives (buy_id, client_id, book_id, date_payment, amount, price)
      VALUES (2, 1, 1, '2019-02-21', 2, 670.60),
             (2, 1, 3, '2019-02-21', 1, 450.90),
             (1, 2, 2, '2019-02-10', 2, 520.30),
             (1, 2, 4, '2019-02-10', 3, 780.90),
             (1, 2, 3, '2019-02-10', 1, 450.90),
             (3, 4, 4, '2019-03-05', 4, 780.90),
             (3, 4, 5, '2019-03-05', 2, 480.90),
             (4, 1, 6, '2019-03-12', 1, 650.00),
             (5, 2, 1, '2019-03-18', 2, 670.60),
             (5, 2, 4, '2019-03-18', 1, 780.90);
    SQL
  end

  def self.down
    execute 'DROP TABLE buy_archives'
  end
end
