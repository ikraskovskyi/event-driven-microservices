# Shared Dockerfile for building an image of any service.
# Pass the service name as the MODULE build argument.
# Example (run from the project root):
#   docker build --build-arg MODULE=order-service -t order-service .

FROM maven:3.9.11-eclipse-temurin-21 AS build
ARG MODULE
WORKDIR /workspace

COPY pom.xml ./
COPY contracts/pom.xml contracts/
COPY order-service/pom.xml order-service/
COPY payment-service/pom.xml payment-service/
COPY inventory-service/pom.xml inventory-service/
COPY notification-service/pom.xml notification-service/
COPY analytics-service/pom.xml analytics-service/

COPY contracts/src contracts/src
COPY ${MODULE}/src ${MODULE}/src

RUN --mount=type=cache,target=/root/.m2 \
    mvn -B -q -pl "${MODULE}" -am package -DskipTests && \
    cp "${MODULE}"/target/"${MODULE}"-*.jar /workspace/app.jar

FROM eclipse-temurin:21.0.8_9-jre
WORKDIR /app

RUN groupadd --system app && useradd --system --gid app app
COPY --from=build /workspace/app.jar app.jar
USER app

ENTRYPOINT ["java", "-jar", "/app/app.jar"]
