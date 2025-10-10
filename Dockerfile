# Base Tomcat
FROM tomcat:9.0

# Remove default webapps
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy WAR
COPY target/maven_webapp-1.0.war /usr/local/tomcat/webapps/ROOT.war

# Expose Tomcat port
EXPOSE 8090

# Run Tomcat
CMD ["catalina.sh", "run"]

