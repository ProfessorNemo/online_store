# frozen_string_literal: true
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


client = Client.new name_client: 'Попов Илья', city_id: '1', email: 'popov@mail.ru'
client.save
buy = Buy.new buy_description: 'Связаться со мной по вопросу доставки', client_id: '5'
buy.save
buy_book_order_one = BuyBook.new buy_id: '5', book_id: '8', amount: '2'
buy_book_order_one.save
buy_book_order_two = BuyBook.new buy_id: '5', book_id: '2', amount: '1'
buy_book_order_two.save
