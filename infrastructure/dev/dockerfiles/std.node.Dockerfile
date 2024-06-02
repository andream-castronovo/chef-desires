FROM node:18-alpine

# Definisco un parametro di argomento, che poi gli daremo nel docker-compose
# In questo modo potremo utilizzare questo Dockerfile per tutti i progetti Node
# Dovendo semplicemente cambiare il parametro.
ARG SERVICE_PATH

# WORKDIR è un po' la "CD" di Docker, nell'ambiente virtuale entra in /usr/src/server
WORKDIR /usr/src/server

# Come prima cosa installiamo le dipendenze di Docker
# l'asterisco è una wildcard per poter prendere sia package.json sia package-lock.json

# Prima copiamo la lista di dipendenze
COPY $SERVICE_PATH/package*.json ./

# Poi installiamo, RUN fa semplicemente un comando da CMD
RUN npm install


# Copia tutto dal percorso che gli diamo come parametro
# Alla workdir scelta prima (/usr/src/server)
COPY $SERVICE_PATH .

# Espone una porta, per essere usata dall'esterno.
# Quando avvieremo il container però dovremo abilitare
# Il forwarding della porta con "-p PORTA_LOCALE:PORTA_CONTAINER"
# Diremo quindi che la PORTA_CONTAINER (quella esposta, in questo caso 3000)
# Sarà messa su una porta a nostra scelta in PORTA_LOCALE.
# Accedere dunque a localhost:PORTA_LOCALE sarà come accedere a 
# localhost:PORTA_CONTAINER nella macchina virtuale di Docker.
EXPOSE 3000

# CMD, a differenza di RUN, è quello che dice esattamente come avviare la nostra applicazione
# RUN invece fa una sessione di shell in cui fa i comandi, CMD è invece resposanbile di avviare 
# la nostra app.
CMD [ "npm", "run", "start" ]