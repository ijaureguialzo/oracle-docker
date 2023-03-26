#!make

THIS_FILE := $(lastword $(MAKEFILE_LIST))

ifneq (,$(wildcard ./.env))
    include .env
    export
else
$(error No se encuentra el fichero .env)
endif

ARCH := $(shell docker context use default && docker run --rm alpine uname -m)

help: _header
	${info }
	@echo Opciones:
	@echo ----------------------
	@echo start / stop / restart
	@echo ----------------------
	@echo ps / logs / stats
	@echo clean
	@echo ----------------------

_header:
	${info }
	@echo ----------------
	@echo Oracle en Docker
	@echo ----------------

_colima-start:
	@colima start --profile colima-oracle --arch x86_64 --memory 4

_colima-stop:
	@colima stop --profile colima-oracle

_colima-delete:
	@colima delete --profile colima-oracle -f

_context-colima:
	@docker context use colima-oracle

_context-docker-desktop:
	@docker context use default

_start_command:
	@docker compose up -d --remove-orphans

start:
ifneq ("$(ARCH)", "default aarch64")
	@$(MAKE) -f $(THIS_FILE) _start_command
else
	@$(MAKE) -f $(THIS_FILE) _colima-start _context-colima _start_command _context-docker-desktop
endif

_stop_command:
	@docker compose stop

stop:
ifneq ("$(ARCH)", "default aarch64")
	@$(MAKE) -f $(THIS_FILE) _stop_command
else
	@$(MAKE) -f $(THIS_FILE) _context-colima _stop_command _colima-stop
endif

restart: stop start

_ps_command:
	@docker ps

ps:
ifneq ("$(ARCH)", "default aarch64")
	@$(MAKE) -f $(THIS_FILE) _ps_command
else
	@$(MAKE) -f $(THIS_FILE) _context-colima _ps_command _context-docker-desktop
endif

_logs_command:
	@docker compose logs server

logs:
ifneq ("$(ARCH)", "default aarch64")
	@$(MAKE) -f $(THIS_FILE) _logs_command
else
	@$(MAKE) -f $(THIS_FILE) _context-colima _logs_command _context-docker-desktop
endif

_stats_command:
	@docker stats

stats:
ifneq ("$(ARCH)", "default aarch64")
	@$(MAKE) -f $(THIS_FILE) _stats_command
else
	@$(MAKE) -f $(THIS_FILE) _context-colima _stats_command _context-docker-desktop
endif

_clean_command:
	@docker compose down -v --remove-orphans

clean:
ifneq ("$(ARCH)", "default aarch64")
	@$(MAKE) -f $(THIS_FILE) _clean_command
else
	@$(MAKE) -f $(THIS_FILE) _context-colima _clean_command _colima-delete _context-docker-desktop
endif
