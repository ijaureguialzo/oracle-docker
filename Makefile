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
	@echo ---------------------------------------------
	@echo start / stop / restart
	@echo start-m1 / stop-m1 / restart-m1
	@echo ---------------------------------------------
	@echo ps / logs / stats / stop-all
	@echo ps-m1 / logs-m1 / stats-m1 / stop-all-m1
	@echo clean
	@echo clean-m1 / destroy-m1
	@echo ---------------------------------------------

_header:
	@echo ----------------
	@echo Oracle en Docker
	@echo ----------------

start:
	@docker-compose up -d --remove-orphans

stop:
	@docker-compose stop

restart: stop start

colima-start:
	@colima start --profile colima-oracle --arch x86_64 --memory 4

colima-stop:
	@colima stop --profile colima-oracle

context-colima:
	@docker context use colima-oracle

context-docker-desktop:
	@docker context use default

start-m1: colima-start context-colima start context-docker-desktop

stop-m1: context-colima stop colima-stop

restart-m1: stop-m1 start-m1

ps:
	@docker ps

ps-m1: context-colima ps context-docker-desktop

logs:
	@docker-compose logs server

logs-m1: context-colima logs context-docker-desktop

stats:
	@docker stats

stats-m1: context-colima stats context-docker-desktop

stop-all:
	@docker stop $(shell docker ps -aq)

stop-all-m1: context-colima stop-all context-docker-desktop

clean:
	@docker-compose down -v --remove-orphans

clean-m1: context-colima clean context-docker-desktop

colima-delete:
	@colima delete --profile colima-oracle -f

destroy-m1: context-colima clean colima-delete context-docker-desktop
