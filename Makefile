PROJECT_NAME := rails_sandbox

deb:
	docker-compose up debian

debb:
	docker-compose build debian

al:
	docker-compose up alpine

alb:
	docker-compose build alpine

rdb:
	docker-compose up db

down:
	docker-compose down

clean:
	@make down
	docker-compose rm
	docker image rm $(PROJECT_NAME)_debian $(PROJECT_NAME)_alpine
