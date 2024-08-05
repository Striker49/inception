start:
	cd srcs/ && \
	sudo docker-compose up --build
stop:
	cd srcs/ && \
	sudo docker-compose down
prune:
	sudo docker system prune --all --volumes
delete_volumes:
	make stop
	sudo docker volume ls -q | xargs sudo docker volume rm
fclean:
	sudo docker rmi -f $$(docker images -qa); \
	sudo docker rm -vf $$(docker ps -aq); \
	make prune
re:
	make stop
	make prune
	make delete_volumes
	make start