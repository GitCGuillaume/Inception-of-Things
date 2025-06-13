# Inception-of-Things

### Linux ou WSL requis.

## Part 1:
Cette partie consiste à générer des machines virtuelles avec Vagrant et Kubernetes et est une simple introduction aux Vagrantfiles.
Vagrant est un utilitaire pour gérer les cycles de vie d'une machine virtuelle, il permet d'isoler des dépendances et créer des environnements de travail de façon à ce qu'on puisse tester des configurations et tester nos projets avant l'envoi en production de nos projets.

Ce qui rend par la suite nos phases de tests et de publication beaucoup plus simples car nous pouvons créer un réseau de machines qui interagit entre elles de façon à déployer différents tests et par l'occasion tester la charge d'une machine.
Ce qui réduit considérablement les erreurs de déploiements de nos projets par la suite.

![image](https://github.com/user-attachments/assets/610bb910-2e40-4c83-99f5-0cf0057ef95f)
La 1ère ligne : Installation correspondante au serveur, un noeud serveur correspond à un hote qui permet d'utiliser les commandes serveurs de l'outil K3s afin d'intéragir avec Kubernetes.

La 2ème ligne : Installation correspondante à l'agent, un noeud agent va s'enregistrer auprès du serveur où il pourra faire tourner les pods et les services de kubernetes.

## Part 2:

Maintenant que j'ai compris le principe de Vagrant avec l'utilisation de Kubernetes, je dois mettre en place un réseau qui fera tourner 3 serveurs webs.
Le réseau doit correspondre à une configuration de 3 containers (qui correspond à faire tourner un système d'exploitation dans son propre environnement avec ses propres installations), accessibles depuis 3 services, le lien entre l'hôte et les différents services doit se faire depuis une configuration Ingress (qui consiste à faire une connexion entre le monde extérieur et le réseau de machines).
![image](https://github.com/user-attachments/assets/e438e270-8d54-47bf-9431-42fbd5d4d8ec)

Représentation sous schéma d'un réseau Kubernetes avec 3 applications.

![image](https://github.com/user-attachments/assets/049639ac-65ad-4481-8f1e-4740841b60d5)


## Part 3:

Installation requise : Docker v20.10.5 (runc >= v1.0.0-rc93) pour utiliser k3d et kubectl
```bash
bash ./install.sh pour installer brew, k3d et kubectl
```

```bash
bash ./run --create
bash ./run --delete
bash ./run --start
bash ./run --stop
bash ./run --list
```

L'intégration continue consiste à partager un dépôt Git afin de faciliter les mises à jour sur les machines et faciliter le travail des collaborateurs sur un projet.

Argo CD est un outil pour Kubernetes qui permet de synchroniser un réseau avec des dépôts Git, Argo CD est configurable depuis des fichiers de configuration, depuis une interface de ligne de commande et depuis une interface utilisateur. 
Par exemple si Argo CD est synchronisé sur un dépôt Git, et que ce même dépôt est mis à jour, et bien le projet sera mis à jour automatiquement pour tous les collaborateurs avec Argo CD installé.

Argo CD:

![image](https://github.com/user-attachments/assets/e4fc86b7-a2a1-4c5e-be77-1dbe1dd63039)

Explication du schéma :

* L'hôte de la machine met à jour un répertoire Git, par la suite l'application se synchronise dans l'état souhaité.
* Déploiement K3D : L'application Argo CD fonctionne dans un réseau Kubernetes à l'intérieur d'un Docker spécialisé pour Kubernetes.
* Kubernetes va se connecter à la plateforme Docker Hub afin d'obtenir une image d'une application qui pourra par exemple tester un projet, nous pourrons par la suite modifier la version de l'image afin de progresser dans un projet pour toute personne synchronisé.

![image](https://github.com/user-attachments/assets/2146b751-6a25-40ee-bb22-929ab7e8fe63)

Exemple d'une application afin de tester Argo CD depuis ma machine.

![image](https://github.com/user-attachments/assets/c348578d-8707-4720-9511-6566daf6edf2)

Suite à une mise à jour de Git, mon projet s'est mis à jour automatiquement, le résultat sera le même pour toute personne synchronisé à cette configuration d'Argo CD.

![image](https://github.com/user-attachments/assets/8efce489-d368-4745-86d7-1bbeb13b78a4)
