FROM frolvlad/alpine-oraclejdk8:slim
ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/${r'$'}TZ /etc/localtime && echo ${r'$'}TZ > /etc/timezone
VOLUME /tmp
ADD ${projectName}.jar app.jar
RUN sh -c 'touch /app.jar'
ENV JAVA_OPTS="-Xms128m -Xmx512m"
ENTRYPOINT [ "sh", "-c", "java ${r'$'}JAVA_OPTS -Djava.security.egd=file:/dev/./urandom -jar /app.jar" ]
EXPOSE 8083