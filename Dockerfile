# Utilisation de l'image Node.js certifiée par Red Hat
FROM registry.access.redhat.com/ubi8/nodejs-16

# Définir le répertoire de travail
WORKDIR /app

# Copier le fichier de dépendances
COPY package*.json ./

# Installer les dépendances
RUN npm install

# Copier le fichier d'application dans le conteneur
COPY app.js /app

# Donner les permissions à tous les utilisateurs
RUN chmod -R 777 /app

# Exporter le port 3000
EXPOSE 3000

# Exécuter l'application en tant que non-root
USER 1001

# Commande de démarrage
CMD ["node", "app.js"]
