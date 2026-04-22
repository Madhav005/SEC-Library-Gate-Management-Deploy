# Use Eclipse Temurin (Official OpenJDK replacement)
FROM eclipse-temurin:17-jdk-jammy

WORKDIR /app

# Copy the JAR file
COPY app.jar app.jar

# Expose port 8080
EXPOSE 8080

# Run the jar file
# Added -Duser.timezone=Asia/Kolkata
ENTRYPOINT ["java", "-Duser.timezone=Asia/Kolkata", "-jar", "app.jar"]