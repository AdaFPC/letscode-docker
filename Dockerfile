FROM adoptopenjdk/openjdk11:alpine-jre
LABEL maintainer="Ada Cruz <adaferreira@gmail.com>"

WORKDIR /usr/share/service/
RUN mkdir -p /usr/share/service/config
RUN mkdir -p /usr/share/service/dump
RUN mkdir -p /usr/share/service/public

ENV LANG en_CA.UTF-8
ENV LANGUAGE en_CA.UTF-8
ENV LC_ALL en_CA.UTF-8

ENV HEAP_LOG_PATH /usr/share/service/dump
ENV JAVA_OPS -Xms256m -Xmx512m -XX:+HeapDumpOnOutOfMemoryError -XX:HeapDumpPath=$HEAP_LOG_PATH
ENV JAVA_DEBUG_OPS -verbose:gc -XX:+PrintGCDetails -XX:+PrintGCTimeStamps -Xloggc:$HEAP_LOG_PATH/garbage-collection.log

COPY ./target/*.jar /usr/share/service/service.jar

EXPOSE 8080

ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom",$JAVA_OPS,$JAVA_DEBUG_OPS,"-jar","/usr/share/service/service.jar"   "/usr/share/service/dockerfile-entrypoint.sh"]