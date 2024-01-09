# Docker 이미지를 생성할 때 기반이 되는 베이스 이미지 설정
FROM openjdk:17-jdk
# 관리자 이메일
LABEL maintainer="manchott@naver.com"
# jar 파일 복사
COPY /*.jar ttt-springboot.jar
# Docker 컨테이너가 시작될 때 실행할 명령 지정
ENTRYPOINT ["java", "-jar", "/ttt-springboot.jar"]