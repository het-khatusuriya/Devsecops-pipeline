FROM adoptopenjdk/openjdk11:alpine-slim as build
WORKDIR /app

# Copy Maven wrapper files
COPY mvnw .
COPY .mvn .mvn
COPY pom.xml .
COPY src src

# Install dos2unix to convert Windows line endings to Unix line endings
RUN apk add --no-cache dos2unix && dos2unix mvnw

# Make sure the mvnw file is executable
RUN chmod +x mvnw

# Run the Maven build
RUN ./mvnw package

# Copy the jar file to the final image
COPY target/*.jar app.jar

FROM adoptopenjdk/openjdk11:alpine-slim
VOLUME /tmp

# Add a new system user
RUN addgroup --system javauser && adduser -S -s /bin/false -G javauser javauser

WORKDIR /app
COPY --from=build /app/app.jar .

# Set permissions for the application files
RUN chown -R javauser:javauser /app

USER javauser

# Run the application
ENTRYPOINT ["java", "-jar", "app.jar"]