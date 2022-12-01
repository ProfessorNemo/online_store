# frozen_string_literal: true

require 'roo'

namespace :import do
  desc 'Import data from xlsx files'

  data = Roo::Spreadsheet.open('db/import.xlsx')

  task from_xlsx_authors: :environment do
    puts 'Importing Data Authors'

    sheet = data.sheet(0)

    headers = sheet.row(1)

      sheet.each_with_index do |row, idx|
        next if idx.zero?

        author_data = [headers, row].transpose.to_h

        if Author.exists?(name_author: author_data['name_author'])
          puts "Author with name #{author_data['name_author']} already exists"

          next
        end

        author = Author.new(author_data)

        puts "Saving Author with name '#{author.name_author}'"

        author.save!
      end
  end

  task from_xlsx_genres: :environment do
    puts 'Importing Data Genres'

    sheet = data.sheet(1)

    headers = sheet.row(1)

    sheet.each_with_index do |row, idx|
      next if idx.zero?

      genre_data = [headers, row].transpose.to_h

      if Genre.exists?(name_genre: genre_data['name_genre'])
        puts "Genre with name #{genre_data['name_genre']} already exists"

        next
      end

      genre = Genre.new(genre_data)

      puts "Saving Author with title '#{genre.name_genre}'"

      genre.save!
    end
  end

  task from_xlsx_books: :environment do
    puts 'Importing Data Books'

    sheet = data.sheet(2)

    headers = sheet.row(1)

    sheet.each_with_index do |row, idx|
      next if idx.zero?

      book_data = [headers, row].transpose.to_h

      book = Book.new(book_data)

      puts "Saving Book with title '#{book.title}'"

      book.save!
    end
  end

  task from_xlsx_cities: :environment do
    puts 'Importing Data Cities'

    sheet = data.sheet(3)

    headers = sheet.row(1)

    sheet.each_with_index do |row, idx|
      next if idx.zero?

      city_data = [headers, row].transpose.to_h

      if City.exists?(name_city: city_data['name_city'])
        puts "City with name #{city_data['name_city']} already exists"

        next
      end

      city = City.new(city_data)

      puts "Saving City with title '#{city.name_city}'"

      city.save!
    end
  end

  task from_xlsx_clients: :environment do
    puts 'Importing Data Clients'

    sheet = data.sheet(4)

    headers = sheet.row(1)

    sheet.each_with_index do |row, idx|
      next if idx.zero?

      client_data = [headers, row].transpose.to_h

      if Client.exists?(email: client_data['email'])
        puts "Client with email #{client_data['email']} already exists"

        next
      end

      client = Client.new(client_data)

      puts "Saving Client with name '#{client.name_client}'"

      client.save!
    end
  end

  task from_xlsx_buys: :environment do
    puts 'Importing Data Buys'

    sheet = data.sheet(5)

    headers = sheet.row(1)

    sheet.each_with_index do |row, idx|
      next if idx.zero?

      buy_data = [headers, row].transpose.to_h

      buy = Buy.new(buy_data)

      puts "Saving Buy with description'#{buy.buy_description}'"

      buy.save!
    end
  end

  task from_xlsx_buy_books: :environment do
    puts 'Importing Data Buy_Books'

    sheet = data.sheet(6)

    headers = sheet.row(1)

    sheet.each_with_index do |row, idx|
      next if idx.zero?

      buy_book_data = [headers, row].transpose.to_h

      buy_book = BuyBook.new(buy_book_data)

      puts "Saving Buy with order number '#{buy_book.buy_id}'"

      buy_book.save!
    end
  end

  task from_xlsx_steps: :environment do
    puts 'Importing Data Steps'

    sheet = data.sheet(7)

    headers = sheet.row(1)

    sheet.each_with_index do |row, idx|
      next if idx.zero?

      step_data = [headers, row].transpose.to_h

      if Step.exists?(name_step: step_data['name_step'])
        puts "Step with title #{step_data['name_step']} already exists"

        next
      end

      step = Step.new(step_data)

      puts "Saving Step with title '#{step.name_step}'"

      step.save!
    end
  end

  task from_xlsx_buy_steps: :environment do
    puts 'Importing Data Buy_Steps'

    sheet = data.sheet(8)

    headers = sheet.row(1)

    sheet.each_with_index do |row, idx|
      next if idx.zero?

      buy_step_data = [headers, row].transpose.to_h

      buy_step = BuyStep.new(buy_step_data)

      puts "Saving BuyStep with order number '#{buy_step.buy_id}'"

      buy_step.save!
    end
  end
end
