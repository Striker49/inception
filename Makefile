start: dir
	cd srcs/ && \
	sudo sudo docker-compose up --build
stop:
	cd srcs/ && \
	sudo docker-compose down
prune:
	sudo docker system prune --all --volumes
delete_volumes:
	make stop
	sudo docker volume ls -q | xargs sudo docker volume rm
exec_mariadb:
	sudo docker exec -it mariadb sh
exec_wp:
	sudo docker exec -it wordpress sh
fclean:
	make delete_volumes
	sudo rm -rf /home/$(USER)/data/mariadb
	sudo rm -rf /home/$(USER)/data/wordpress
	sudo docker rmi -f $$(sudo docker images -qa); \
	sudo docker rm -vf $$(sudo docker ps -aq); \
	make prune
eval:
	sudo docker stop $$(sudo docker ps -qa); \
	sudo docker rm $$(sudo docker ps -qa); \
	sudo docker rmi -f $$(sudo docker images -qa); \
	sudo docker volume rm $$(sudo docker volume ls -q); \
	sudo docker network rm $$(sudo docker network ls -q) 2>/dev/null

dir:
	mkdir -p /home/$(USER)/data/mariadb
	mkdir -p /home/$(USER)/data/wordpress
	sudo chmod 777 /home/$(USER)/data/mariadb
	sudo chmod 777 /home/$(USER)/data/wordpress

re:
	make fclean
	make start
