# Use Tomcat with JDK 21+ support
FROM tomcat:9.0-jdk21-openjdk-slim

# Copy your pre-compiled WAR file to Tomcat ROOT
COPY dist/*.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080
CMD ["catalina.sh", "run"]