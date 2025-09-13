#!/bin/bash

# Install default databases
if [[ -v OMAKUB_FIRST_RUN_DBS ]]; then
	dbs=$OMAKUB_FIRST_RUN_DBS
else
	AVAILABLE_DBS=("MySQL" "Redis" "PostgreSQL")
	dbs=$(gum choose "${AVAILABLE_DBS[@]}" --no-limit --height 5 --header "Select databases (runs in Docker)")
fi

if [[ -n "$dbs" ]]; then
	for db in $dbs; do
		case $db in
		MySQL)
			# Check if mysql8 container already exists
			if sudo docker ps -a --filter "name=mysql8" --format "{{.Names}}" | grep -q "^mysql8$"; then
				echo "MySQL container 'mysql8' already exists, skipping..."
				# Start it if it's stopped
				if ! sudo docker ps --filter "name=mysql8" --format "{{.Names}}" | grep -q "^mysql8$"; then
					echo "Starting existing MySQL container..."
					sudo docker start mysql8
				fi
			else
				echo "Creating new MySQL container..."
				sudo docker run -d --restart unless-stopped -p "127.0.0.1:3306:3306" --name=mysql8 -e MYSQL_ROOT_PASSWORD= -e MYSQL_ALLOW_EMPTY_PASSWORD=true mysql:8.4
			fi
			;;
		Redis)
			# Check if redis container already exists
			if sudo docker ps -a --filter "name=redis" --format "{{.Names}}" | grep -q "^redis$"; then
				echo "Redis container 'redis' already exists, skipping..."
				# Start it if it's stopped
				if ! sudo docker ps --filter "name=redis" --format "{{.Names}}" | grep -q "^redis$"; then
					echo "Starting existing Redis container..."
					sudo docker start redis
				fi
			else
				echo "Creating new Redis container..."
				sudo docker run -d --restart unless-stopped -p "127.0.0.1:6379:6379" --name=redis redis:7
			fi
			;;
		PostgreSQL)
			# Check if postgres16 container already exists
			if sudo docker ps -a --filter "name=postgres16" --format "{{.Names}}" | grep -q "^postgres16$"; then
				echo "PostgreSQL container 'postgres16' already exists, skipping..."
				# Start it if it's stopped
				if ! sudo docker ps --filter "name=postgres16" --format "{{.Names}}" | grep -q "^postgres16$"; then
					echo "Starting existing PostgreSQL container..."
					sudo docker start postgres16
				fi
			else
				echo "Creating new PostgreSQL container..."
				sudo docker run -d --restart unless-stopped -p "127.0.0.1:5432:5432" --name=postgres16 -e POSTGRES_HOST_AUTH_METHOD=trust postgres:16
			fi
			;;
		esac
	done
fi
