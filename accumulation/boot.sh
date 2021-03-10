#!/bin/sh
SERVICE_NAME=my-api-beta
PATH_TO_JAR=/home/jornah/www/my-api-beta/my-api-beta-1111-SNAPSHOT.jar
PID_PATH_NAME=my-api-beta.pid
SERVER_PORT=8090
APPLICATION_USERNAME=my-admin
APPLICATION_PASSWORD=123456
NGINX_CONFIG_FILE=/etc/nginx/conf.d/my-api.conf

case $1 in
    start)
        echo "Starting $SERVICE_NAME ..."
        if [ ! -f $PID_PATH_NAME ]; then
            nohup java -server -Dserver.tomcat.basedir=. -Dserver.port=${SERVER_PORT} -jar $PATH_TO_JAR --spring.config.name=common,environment --logging.config=config/logback.xml -Xverify:none -Xms256m 2>> /dev/null >> /dev/null &
            echo $! > $PID_PATH_NAME
            until $(curl --output /dev/null --silent --head --fail http://127.0.0.1:${SERVER_PORT}/health); do
                echo "Waiting for $SERVICE_NAME starting ..."
                sleep 3
            done
            echo "$SERVICE_NAME started ..."
            sed -i "s/upstream my-api {/upstream my-api {\n    server 127.0.0.1:${SERVER_PORT};/" ${NGINX_CONFIG_FILE}
            /etc/init.d/nginx reload
        else
            echo "$SERVICE_NAME is already running ..."
        fi
    ;;
    stop)
        if [ -f $PID_PATH_NAME ]; then
            PID=$(cat $PID_PATH_NAME);
            echo "$SERVICE_NAME stopping ..."
            sed --in-place "/127.0.0.1:${SERVER_PORT}/d" ${NGINX_CONFIG_FILE}
            /etc/init.d/nginx reload
            curl -X GET http://127.0.0.1:${SERVER_PORT}/health > status.txt
            if grep -q "{\"status\":\"UP\"}" status.txt; then
                curl -X POST -u ${APPLICATION_USERNAME}:${APPLICATION_PASSWORD} http://127.0.0.1:${SERVER_PORT}/shutdown
                until ! $(curl --output /dev/null --silent --head --fail http://127.0.0.1:${SERVER_PORT}/health); do
                    echo "Waiting for $SERVICE_NAME stopping ..."
                    sleep 3
                done
            fi
            ps -aux | grep $SERVICE_NAME | grep $PID > /dev/null
            if [ $? -eq 0 ]; then
                sleep 3
                kill -15 $PID
            fi
            echo "$SERVICE_NAME stopped ..."
            rm $PID_PATH_NAME
        else
            echo "$SERVICE_NAME is not running ..."
        fi
    ;;
    restart)
        if [ -f $PID_PATH_NAME ]; then
            PID=$(cat $PID_PATH_NAME);
            echo "$SERVICE_NAME stopping ...";
            sed --in-place "/127.0.0.1:${SERVER_PORT}/d" ${NGINX_CONFIG_FILE}
            /etc/init.d/nginx reload
            curl -X GET http://127.0.0.1:${SERVER_PORT}/health > status.txt
            if grep -q "{\"status\":\"UP\"}" status.txt; then
                curl -X POST -u ${APPLICATION_USERNAME}:${APPLICATION_PASSWORD} http://127.0.0.1:${SERVER_PORT}/shutdown
                until ! $(curl --output /dev/null --silent --head --fail http://127.0.0.1:${SERVER_PORT}/health); do
                    echo "Waiting for $SERVICE_NAME stopping ..."
                    sleep 3
                done
            fi
            ps -aux | grep $SERVICE_NAME | grep $PID > /dev/null
            if [ $? -eq 0 ]; then
                sleep 3
                kill -15 $PID
            fi
            echo "$SERVICE_NAME stopped ...";
            rm $PID_PATH_NAME

            echo "$SERVICE_NAME starting ..."
            nohup java -server -Dserver.tomcat.basedir=. -Dserver.port=${SERVER_PORT} -jar $PATH_TO_JAR --spring.config.name=common,environment --logging.config=config/logback.xml -Xverify:none -Xms256m 2>> /dev/null >> /dev/null &
            echo $! > $PID_PATH_NAME
            until $(curl --output /dev/null --silent --head --fail http://127.0.0.1:${SERVER_PORT}/health); do
                echo "Waiting for $SERVICE_NAME starting ..."
                sleep 3
            done
            sed -i "s/upstream my-api {/upstream my-api {\n    server 127.0.0.1:${SERVER_PORT};/" ${NGINX_CONFIG_FILE}
            /etc/init.d/nginx reload
            echo "$SERVICE_NAME started ..."
        else
            echo "$SERVICE_NAME is not running ..."
        fi
    ;;
esac