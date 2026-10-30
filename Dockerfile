# Use official Apache Tomcat 9
FROM tomcat:9.0-jdk11-openjdk-slim

# Copy pre-built WAR from dist/ to Tomcat webapps
COPY dist/*.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080
CMD ["catalina.sh", "run"]