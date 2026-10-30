# Use Tomcat with a newer JDK runtime
FROM tomcat:9.0-jdk21-openjdk-slim

# Copy pre-built WAR file from dist/ to Tomcat webapps
COPY dist/*.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080
CMD ["catalina.sh", "run"]