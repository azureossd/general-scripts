ECHO OFF
:: "Stopping all containers......"
::docker stop $(docker ps -aq)
FOR /f "tokens=*" %%i IN ('docker ps -q') DO docker stop %%i
:: "Remove all containers......"
::docker rm $(docker ps -a -q)
FOR /f "tokens=*" %%i IN ('docker ps -q') DO docker rm %%i

:: "Starting MongoDB container......"
:: User: admin
:: Password: password
:: URL to connect: mongodb://admin:password@localhost:27017/
docker run -d -p 27017:27017 -e MONGO_INITDB_ROOT_USERNAME=admin -e MONGO_INITDB_ROOT_PASSWORD=password --name=azureossd_mongodb --rm mongo:latest

:: Getting ip address for Docker Desktop Linux VM.
setlocal EnableDelayedExpansion

for /f "tokens=3" %%a in ('ping host.docker.internal ^| find /i "reply"') do (
  set dockervmipaddress=%%a
  set dockervmipaddress=!dockervmipaddress:~0,-1!
)

:: "Starting PostgreSQL container......"
:: User: postgres
:: Password: password
docker run -d -p 5432:5432 -e POSTGRES_PASSWORD=password --add-host=host:"%dockervmipaddress%" --name=azureossd_postgres --rm postgres:latest

:: "Starting PgAdmin"
:: User: youralias@microsoft.com
:: Password: password
docker run -d -p 8082:80 -e PGADMIN_DEFAULT_EMAIL=youralias@microsoft.com -e PGADMIN_DEFAULT_PASSWORD=password --name=azureossd_pgadmin --rm dpage/pgadmin4
:: To connect to postgresql container, add the host from ping result: ping host.docker.internal

:: "Starting MariaDB"
:: User: root
:: Password: password
docker run -d -p 3306:3306 -e MYSQL_ROOT_PASSWORD=password --name=azureossd_mariadb --rm mariadb:latest

:: "Starting Redis"
:: Password: password
docker run -d -p 6379:6379 --name=azureossd_redis --rm redis:latest redis-server --requirepass password
::To use a redis client you can use docker run -it --link azureossd_redis:redis_server --name azureossd_redis-client --rm redis:latest redis-cli -h redis_server -a password -p 6379

:: "Starting SQL Server"
:: User: sa
:: Password: password
docker run -d -p 1433:1433 -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=password' -e 'MSSQL_PID=Express' --name=azureossd_sqlserver --rm mcr.microsoft.com/mssql/server:2017-latest-ubuntu 
:: To connect use docker exec -it <container_id|container_name> /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P <your_password>

