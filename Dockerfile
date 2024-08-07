# syntax=docker/dockerfile:1
FROM openjdk:8-jdk AS base-amd64
FROM arm64v8/openjdk:8-jdk AS base-arm64

FROM maven:3.8.6-openjdk-8 AS build
WORKDIR /app
COPY ./pom.xml pom.xml
RUN mvn install

COPY ./src src/
RUN mvn package -DskipTests

FROM base-${TARGETARCH}
WORKDIR /app
COPY --from=build /app/target/my-java-app-1.0.jar app.jar
EXPOSE 8080
CMD ["java", "-jar", "app.jar"]
