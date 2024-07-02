# Usa un'immagine di base con Java 11 e Maven installati
FROM adoptopenjdk:11-jdk-hotspot AS build

# Copia il tuo codice sorgente e il file pom.xml nel container
WORKDIR /app
COPY . .

# Compila il progetto usando Maven
RUN ./mvnw package -DskipTests

# Usa un'immagine di base più leggera per eseguire l'applicazione Spring Boot
FROM adoptopenjdk:11-jre-hotspot

# Copia il file JAR compilato dal container di build al container di runtime
COPY --from=build /app/target/eureka-server-0.0.1-SNAPSHOT.jar /app/app.jar

# Specifica la porta su cui l'applicazione Spring Boot sarà in ascolto dentro il container
EXPOSE 8761

# Comando per avviare l'applicazione Spring Boot quando il container viene avviato
ENTRYPOINT ["java", "-jar", "/app/app.jar"]
