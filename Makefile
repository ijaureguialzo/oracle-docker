#!make

THIS_FILE := $(lastword $(MAKEFILE_LIST))

ifneq (,$(wildcard ./.env))
    include .env
    export
else
$(error No se encuentra el fichero .env)
endif

ARCH := $(shell docker run --rm alpine uname -m)

help: _header
	${info }
	@echo Opciones:
	@echo ---------------------------------------------
	@echo start / stop / restart
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

_start_command:
	@docker-compose up -d --remove-orphans

start:
ifneq ("$(ARCH)", "aarch64")
	@$(MAKE) -f $(THIS_FILE) _start_command
else
	@$(MAKE) -f $(THIS_FILE) colima-start context-colima _start_command context-docker-desktop
endif

_stop_command:
	@docker-compose stop

stop:
ifneq ("$(ARCH)", "aarch64")
	@$(MAKE) -f $(THIS_FILE) _stop_command
else
	@$(MAKE) -f $(THIS_FILE) context-colima _stop_command colima-stop
endif

restart: stop start

colima-start:
	@colima start --profile colima-oracle --arch x86_64 --memory 4

colima-stop:
	@colima stop --profile colima-oracle

context-colima:
	@docker context use colima-oracle

context-docker-desktop:
	@docker context use default

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
