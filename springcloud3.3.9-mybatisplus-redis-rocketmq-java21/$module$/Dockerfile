# 镜像如果不可用时 请更换
FROM openjdk:21-oracle
VOLUME /tmp
ADD $projectName$/build/libs/*.jar app.jar
RUN sh -c 'touch /app.jar'
ENV JAVA_OPTS="-XX:+UseZGC -XX:+UseCompressedOops -XX:+TieredCompilation -Xms128m"
ENTRYPOINT [ "sh", "-c", "java \$JAVA_OPTS -Djava.security.egd=file:/dev/./urandom -jar /app.jar" ]
EXPOSE 8080