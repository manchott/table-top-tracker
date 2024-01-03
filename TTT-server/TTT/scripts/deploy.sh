#!/bin/bash

ROOT=/home/ec2-user/app

echo "> Build 파일 복사"

cp $ROOT/zip/*.jar $ROOT/

echo "> 현재 구동중인 애플리케이션 pid 확인"

CURRENT_PID=$(pgrep -fl ttt-springboot-webservice | grep jar | awk '{print $1}')

echo "현재 구동중인 애플리게이션 pid: $CURRENT_PID"

if [ -z $CURRENT_PID ]
then
     echo ">현재 구동 중인 애플리케이션이 없으므로 종료하지 않습니다."
else
     echo "> kill -15 $CURRENT_PID"
     kill -15 $CURRENT_PID
    sleep 5
fi

echo "> 새 애플리케이션 배포"

JAR_NAME=$(ls -tr $ROOT/*.jar | tail -n 1)

echo "> JAR Name: $JAR_NAME"

echo "> JAR Name: $JAR_NAME 에 실행권한 추가"

chmod +x $JAR_NAME

echo "> $JAR_NAME 실행"

nohup java -jar \
 -Dspring.config.location=optional:/application.yml,/home/ec2-user/app/application-prod.yml,/home/ec2-user/app/application-oauth.yml \
 -Dspring.profiles.active=prod \
 $JAR_NAME > $ROOT/nohup.out 2>&1 &
