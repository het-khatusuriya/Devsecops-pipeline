FROM openjdk:11-jdk-windowsservercore-ltsc2019 AS build
WORKDIR /app

COPY mvnw .
COPY .mvn .mvn
COPY pom.xml .
COPY src src

RUN ./mvnw.cmd package
COPY target/*.jar app.jar

FROM openjdk:11-jre-windowsservercore-ltsc2019
VOLUME C:\tmp
WORKDIR C:\app


COPY --from=build C:\app\app.jar .

ENTRYPOINT ["java", "-jar", "app.jar"]
