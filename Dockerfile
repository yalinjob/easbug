# Stage 1: Builder Stage
FROM maven:3.8.7-eclipse-temurin-17 as builder

WORKDIR /usr/src/app

# Copy pom.xml and download dependencies
COPY pom.xml ./
RUN mvn dependency:resolve

# Copy source code and build the application
COPY src ./src
RUN mvn package -DskipTests

# Stage 2: Final Image
FROM eclipse-temurin:17-jre-alpine

WORKDIR /home/app

# Copy the built JAR file from the builder stage
COPY --from=builder /usr/src/app/target/*.jar ./app.jar

# Expose the application port (adjust as needed)
EXPOSE 8080

# Run the application
CMD ["java", "-jar", "app.jar"]
