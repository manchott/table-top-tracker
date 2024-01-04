#!/bin/bash

JAR_PATH=/home/ec2-user/app/zip/TTT-server/TTT/build/libs
PROJECT_NAME=TTT
ROOT=/home/ec2-user/app
DEPLOY_LOG_PATH=/home/ec2-user/app/deploy.log

echo "> Build 파일 복사" >> $DEPLOY_LOG_PATH

cp $JAR_PATH/*.jar $ROOT/

CURRENT_PID=$(pgrep -f $PROJECT_NAME)

echo "현재 구동중인 애플리게이션 pid: $CURRENT_PID" >> $DEPLOY_LOG_PATH

if [ -z $CURRENT_PID ]
then
     echo ">현재 구동 중인 애플리케이션이 없으므로 종료하지 않습니다." >> $DEPLOY_LOG_PATH
else
     echo "> kill -15 $CURRENT_PID" >> $DEPLOY_LOG_PATH
     kill -15 $CURRENT_PID
    sleep 5
fi

echo "> 새 애플리케이션 배포" >> $DEPLOY_LOG_PATH

JAR_NAME=$(ls -tr $ROOT/*.jar | tail -n 1)

echo "> JAR Name: $JAR_NAME 에 실행권한 추가" >> $DEPLOY_LOG_PATH

chmod +x $JAR_NAME

echo "> $JAR_NAME 실행" >> $DEPLOY_LOG_PATH

nohup java -jar \
 -Dspring.config.location=optional:/application.yml,/home/ec2-user/app/application-prod.yml,/home/ec2-user/app/application-oauth.yml \
 -Dspring.profiles.active=prod \
 $JAR_NAME > $ROOT/nohup.out 2>&1 &
