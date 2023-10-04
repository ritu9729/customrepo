FROM openjdk:8-jdk-slim

# Create a non-root user for running the application            
RUN groupadd -r ritu && useradd -r -g ritu ritu

# Set environment variables
ENV CATALINA_HOME /usr/local/tomcat
ENV PATH $CATALINA_HOME/bin:$PATH

# Install Tomcat
RUN apt-get update && \
    apt-get install -y wget && \
    wget http://archive.apache.org/dist/tomcat/tomcat-8/v8.5.61/bin/apache-tomcat-8.5.61.tar.gz && \
    tar -xzvf apache-tomcat-8.5.61.tar.gz && \
    rm apache-tomcat-8.5.61.tar.gz && \
    mv apache-tomcat-8.5.61 $CATALINA_HOME && \
    chown -R ritu:ritu $CATALINA_HOME

# Expose the port that Tomcat will run on
EXPOSE 8080

# Switch to the non-root user
USER ritu

# Start Tomcat
CMD ["catalina.sh", "run"]
