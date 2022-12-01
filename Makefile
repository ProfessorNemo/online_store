
RUN_ARGS := $(wordlist 2, $(words $(MAKECMDGOALS)), $(MAKECMDGOALS))

drop:
	rails db:drop

up:
	rails db:create
	rails db:migrate:up VERSION=20221130203926
	rails db:migrate:up VERSION=20221130204251
	rails db:migrate:up VERSION=20221130204406
	rails db:migrate:up VERSION=20221130204531
	rails db:migrate:up VERSION=20221130204906
	rails db:migrate:up VERSION=20221130213921
	rails db:migrate:up VERSION=20221130214343
	rails db:migrate:up VERSION=20221130215648
	rails db:migrate:up VERSION=20221130220051
	rails db:migrate:up VERSION=20221201165101
	rake import:from_xlsx_authors
	rake import:from_xlsx_genres
	rake import:from_xlsx_books
	rake import:from_xlsx_cities
	rake import:from_xlsx_clients
	rake import:from_xlsx_buys
	rake import:from_xlsx_buy_books
	rake import:from_xlsx_steps
	rake import:from_xlsx_buy_steps
	rails db:seed

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
