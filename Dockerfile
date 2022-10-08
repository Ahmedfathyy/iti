# build code
FROM maven:3.6.0-jdk-11-slim AS build
WORKDIR /usr/app
COPY . .
RUN mvn -f pom.xml clean package


# make artifact
FROM openjdk:11-jre-slim
COPY --from=build /usr/app/target/iti-g111-1.0.0.jar /usr/local/lib/iti-g111-1.0.0.jar
ENTRYPOINT ["java","-jar","/usr/local/lib/iti-g111-1.0.0.jar"]