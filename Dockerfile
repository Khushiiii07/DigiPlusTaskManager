# Use official OpenJDK 25 base image
FROM openjdk:25-ea-slim-bookworm

# Install Tomcat 9 inside Java 25 environment
ENV CATALINA_HOME /usr/local/tomcat
ENV PATH $CATALINA_HOME/bin:$PATH
RUN mkdir -p "$CATALINA_HOME"
WORKDIR $CATALINA_HOME

# Download and extract Tomcat 9.0.80
RUN apt-get update && apt-get install -y curl && \
    curl -fSL https://archive.apache.org/dist/tomcat/tomcat-9/v9.0.80/bin/apache-tomcat-9.0.80.tar.gz -o tomcat.tar.gz && \
    tar -xvf tomcat.tar.gz --strip-components=1 && \
    rm tomcat.tar.gz && \
    rm -rf /var/lib/apt/lists/*

# Remove default Tomcat web applications (clears default ROOT folder)
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy pre-compiled WAR file to Tomcat ROOT.war
COPY dist/*.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080
CMD ["catalina.sh", "run"]