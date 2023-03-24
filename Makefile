help:
	@echo Opciones:
	@echo 
	@echo start / stop / restart / stop-all
	@echo stats / logs / workspace / sqlplus
	@echo clean

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

stop-all:
	@docker stop `docker ps -aq`

stats:
	@docker stats

logs:
	@docker-compose logs server

logs-m1: context-colima logs context-docker-desktop

workspace:
	@docker-compose exec server /bin/bash

sqlplus:
	@docker-compose exec server sqlplus / as sysdba

clean:
	@docker-compose down -v --remove-orphans

clean-m1: context-colima clean context-docker-desktop

colima-delete:
	@colima delete --profile colima-oracle -f

destroy-m1: context-colima clean colima-delete context-docker-desktop
