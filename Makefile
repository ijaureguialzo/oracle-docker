#!make

ifneq (,$(wildcard ./.env))
    include .env
    export
else
$(error No se encuentra el fichero .env)
endif

help: _header
	${info }
	@echo Opciones:
	@echo ----------------------
	@echo start / stop / restart
	@echo ----------------------
	@echo workspace
	@echo user [name=egibide] [password=12345Abcde]
	@echo ----------------------
	@echo ps / logs / stats
	@echo clean
	@echo ----------------------

_header:
	${info }
	@echo ----------------
	@echo Oracle en Docker
	@echo ----------------

start:
	@docker compose up -d --remove-orphans

stop:
	@docker compose down

restart: stop start

workspace:
	@docker compose exec server /bin/bash

name?="egibide"
password?="12345Abcde"

user:
	@docker compose cp crear_usuario.sql server:/tmp/crear_usuario.sql
	@docker compose exec -u root server /bin/sh -c "sed -i 's/egibide/$(name)/g' /tmp/crear_usuario.sql"
	@docker compose exec -u root server /bin/sh -c "sed -i 's/12345Abcde/$(password)/g' /tmp/crear_usuario.sql"
	@docker compose exec server /bin/sh -c "echo exit | sqlplus -S system/${ORACLE_PASSWORD} @/tmp/crear_usuario.sql"
	@docker compose exec -u root server /bin/sh -c "rm -f /tmp/crear_usuario.sql"

ps:
	@docker ps

logs:
	@docker compose logs server

stats:
	@docker stats

clean:
	@docker compose down -v --remove-orphans
