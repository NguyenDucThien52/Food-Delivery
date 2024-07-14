# Use an official OpenJDK runtime as a parent image
FROM openjdk:17-jdk-slim

WORKDIR /app

COPY target/*.jar app.jar
COPY keyAccountService.json /keyAccountService.json
EXPOSE 8080
ENV GOOGLE_APPLICATION_CREDENTIALS="/keyAccountService.json"
# Run the app.jar when the container launches
ENTRYPOINT ["java", "-jar", "app.jar"]
