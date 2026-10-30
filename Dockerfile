
# Step 1: Build the Java Web Application using Maven
FROM maven:3.8.6-openjdk-11 AS build
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests || ant -f build.xml dist

# Step 2: Run the compiled WAR file on Apache Tomcat
FROM tomcat:9.0-jdk11-openjdk-slim
COPY --from=build /app/dist/*.war /usr/local/tomcat/webapps/ROOT.war
EXPOSE 8080
CMD ["catalina.sh", "run"]