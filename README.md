**🎓 Exercice OpenShift complet : Build, Push et Démarrage d'une Application Python sans Exposer le Service**

🔥 **Contexte de l'exercice**
Dans cet exercice, nous allons pratiquer toutes les étapes essentielles nécessaires pour travailler avec **OpenShift et son registre Quay.io**. L'objectif est de construire, pousser, et déployer une application **NodeJS** sans utiliser de privilèges root.


🎯 **Objectifs**
1. **Créer une application NodeJS** à partir d'un Dockerfile (sans privilèges root) 
2. **Créer un dépôt sur le registre Quay.io** (ou via le registre OpenShift si possible)
3. **Créer un compte Robot sur Quay.io** et **pousser l'image**
4. **Déployer l'application sur OpenShift**
5. **Vérifier l'état du déploiement**

🛠️ **Prérequis**
- Accès à **OpenShift Sandbox** ou une instance OpenShift locale.
- Accès à **Quay.io** (ou le registre intégré OpenShift Registry si vous y avez accès).
- **Podman** ou **Docker** installé localement.
- **CLI OpenShift (oc)** configurée pour pointer vers votre cluster OpenShift.

🔥 **Étape 1 : Création de l'Application Python**

Créez la structure suivante sur votre poste de travail :

```
📁 demo-app
 ├── 📄 app.js
 ├── 📄 package.json
 └── 📄 Dockerfile
```


📄 **Contenu de `app.js`**

Ce fichier **app.js** sera une simple application **Express** qui écoute sur le port **3000** mais qui **n'affiche rien à l'extérieur**.

```js
const express = require('express');
const app = express();
const port = 3000;
// Définition de la route principale
app.get('/', (req, res) => {
 res.send('Welcome to OpenShift');
});
// Lancement de l'application
app.listen(port, () => {
 console.log(`Example app listening at http://0.0.0.0:${port}`);
});
```

📄 **Contenu de `package.json`**

Ce fichier déclare les dépendances nécessaires pour l'application. Ici, nous avons besoin de **Express**.

```json
{
  "dependencies": {
    "express": "^4.21.2"
  }
}

```

📄 **Contenu de `Dockerfile`**

Ce Dockerfile suit les **principes OCI** et **n'exécute pas en tant que root**. Il utilise **un utilisateur non-root** et la base d'image **nodejs-18**.

```dockerfile
# Utilisation de l'image Node.js certifiée par Red Hat
FROM registry.access.redhat.com/ubi8/nodejs-16

# Définir le répertoire de travail
WORKDIR /app

# Donner les permissions à tous les utilisateurs
RUN chmod -R 777 /app

# Copier le fichier de dépendances
COPY package*.json ./

# Installer les dépendances
RUN npm install

# Copier le fichier d'application dans le conteneur
COPY app.js /app

# Exporter le port 3000
EXPOSE 3000

# Exécuter l'application en tant que non-root
USER 1001

# Commande de démarrage
CMD ["node", "app.js"]
```

🔥 **Étape 2 : Construire et Pousser l'Image vers le Registre**


🔥 **Étape 3 : Déploiement de l'application sur OpenShift**

🔥 **Étape 4 : Vérification du déploiement**

🔥 **Étape 5 : Test de l'Application**
