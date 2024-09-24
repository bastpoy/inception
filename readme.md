
# NOTE SUR LES DOCKER

## LES COMMANDES DOCKER

- docker image: image qui va contenir la configuration de l'instance que l'on souhaite installer C'est comme un fichier de configuration qui va contenir tout ce qui est necessaire pour faire marcher un processus. Cette commande va afficher tous les containers installes sur la machine
- docker pull <nom_image>: <version>: commande permettant de recuperer un image avec en option la ver ion de l'image que l'on souhaite installer.
- docker run <nom_image>: <version>: ceci va lancer le docker avec le nom souhaite. le parametre -d o --detach permet de lancer le container en arriere plan. ceci ne va pas bloquer le terminal. Ceci cree un nouveau container.
    --network permet d'affilier mon container a un network
- docker ps liste tous les dockers actifs sur ma machine
- docker stop <id_container stop le processus lie au container
- docker run -d -p 9000:80 nginx:1.27 => ceci permet de specifier le port de l'host avec lequel je sou haite communiquer. ici je fais du port binding.
    --name => donner un nom a notre container
- docker start <id_container> ceci relance un container avec un ID qui a ete stop. ceci le relance
docker build permet de creer une image venant d'un dockerfile
    => -t nom de l'image
    => le dernier parametre: localisation du dockerfile => '.' pour le current directory
- docker system prune nettoyer tous les dockers en cours automatiquement

## LES MOTS CLES DANS LE DOCKERFILE

- FROM: permet de donner le point de depart de notre build.
- RUN tout ce qui suit run equivaut a une commande bash dans l'environnement du container 
    => commande effectuer dans le container
- COPY: copier des fichier de l'host vers le container
    => commande effectuer dans le host
- WORKDIR : permet de changer le directory pour es futurs commandes
- CMD : similaire a RUN mais ce qui suit sera la derniere commande a executer pour lancer l'executable.
- USER permet de modifier l'utilisateur pour les prochaines commandes
- ENV: ajouter des variables d'environnement
- EXPOSE : exposer un port vers l'exterieur
- VOLUME : monter un stockage pour partager de la donnee entre container

## AUTRE

- .dockerignore: comme un .gitignore pour ignorer certains fichiers.

Une application dans un container tourne dans un reseau isole. on doit exposer le port du container pour communique vers l'exterieur. On va faire du port binding pour rendre le service accessible ver s l'exterieur. Un container tourne sur un port specifique. Elles ont des ports standards de fonctionnement.

- docker Registry: un service qui fournit du stockage et qui contient des repositories
- docker repositories: Collection de docker images avec le meme nom mais des version differentes.
- dockerfile: un document texte qui contient des commandes pour assembler une image

## DOCKER-COMPOSE

- docker-compose: permet de lancer plusieurs container applications
Sur de gros projets avec enormement de container le docker-compose va nous eviter enormement de conf iguration de container.

### Commandes

- version version du docker-compose
- services: les services ques l'on veut mettre en place
    => lister tous les services
    => Dans ses services nous avons donc toutes les commandes liees a celui-ci
- image: le nom de l'image et sa version
- ports: on definie le port mapping
- environnement : les variables d'environnement
- depends_on: va attendre que les processus suivant se lancent actuel avant de lancer le processus
- Docker-compose -f <nom_du_file> up: commande pour lancer le docker compose et up permet de lancer tous les services parametrer dans le fichier
    => -d pour le lancer en detach
- la configuration network n'est pas effectue dans le docker-compose

## MONGO-NETWORK

Permet aux containers de communiquer entre eux et avec le monde exterieur