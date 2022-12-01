
RUN_ARGS := $(wordlist 2, $(words $(MAKECMDGOALS)), $(MAKECMDGOALS))

drop:
	rails db:drop

up:
	rails db:create
	rails db:migrate
	rake import:from_xlsx_authors
	rake import:from_xlsx_genres
	rake import:from_xlsx_books
	rake import:from_xlsx_cities
	rake import:from_xlsx_clients
	rake import:from_xlsx_buys
	rake import:from_xlsx_buy_books
	rake import:from_xlsx_steps
	rake import:from_xlsx_buy_steps


migration:
	bundle exec rails g migration $(RUN_ARGS)

model:
	bundle exec rails g model $(RUN_ARGS)

create:
	bundle exec rails db:create

migrate:
	bundle exec rails db:migrate

rubocop:
	rubocop -A

run-console:
	bundle exec rails console

c: run-console

.PHONY:	db
