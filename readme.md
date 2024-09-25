
# NOTE SUR LES DOCKER

## BUT DE L'EXERCICE

- La separation de la base de donnee entre wordpress et maraiadb permet une meilleur scalabilite et permet de mieux securiser ses bases de donnee independamment.

## LES COMMANDES DOCKER

- docker image: image qui va contenir la configuration de l'instance que l'on souhaite installer C'est comme un fichier de configuration qui va contenir tout ce qui est necessaire pour faire marcher un processus. Cette commande va afficher tous les containers installes sur la machine
- docker pull <nom_image>:<version>: commande permettant de recuperer un image avec en option la ver ion de l'image que l'on souhaite installer.
- docker run <nom_image>:<version>: ceci va lancer le docker avec le nom souhaite. le parametre -d o --detach permet de lancer le container en arriere plan. ceci ne va pas bloquer le terminal. Ceci cree un nouveau container.
    --network permet d'affilier mon container a un network
- docker ps liste tous les dockers actifs sur ma machine
- docker stop <id_container> stop le processus lie au container
- docker run -d -p 9000:80 nginx:1.27 => ceci permet de specifier le port de l'host avec lequel je souhaite communiquer. Ici je fais du port binding.
    --name => donner un nom a notre container
- docker start <id_container> ceci relance un container avec un ID qui a ete stop. ceci le relance
- docker build permet de creer une image venant d'un dockerfile
    => -t nom de l'image
    => le dernier parametre: localisation du dockerfile => '.' pour le current directory
- docker system prune nettoyer tous les dockers en cours automatiquement

## LES MOTS CLES DANS LE DOCKERFILE

- FROM: permet de donner le point de depart de notre build.
- RUN tout ce qui suit run equivaut a une commande bash dans l'environnement du container 
    => commande effectuer dans le container
- COPY: copier des fichier de l'host vers le container
    => commande effectuer dans le host
- WORKDIR : permet de changer le directory pour les futurs commandes
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
- port:
    80-8080 => le port 8080 dans le docker est relier au port 80 de la machine host

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

## COMPREHENSION GENERALE

- Docker image est un apercu de l'environnement tandis qu'un container fait tourner le software. l'image stockera les environnements, elle sera cree a partir du dockerfile qui contiendra toutes les commandes pour creer l'image Docker. la commande <Docker pull> permet de recuperer une image du Docker hub. un Docker Container eest une instance d'un Docker Image.
- Un Dockerfile est un fichier contenant toutes les commandes pour creer, assembler une Docker image.

### BASE DE DONNEE

- Dans mon Docker-compose j'utilise une base de donnee mariadb mais j'utilise des informations d'authentification propre a mySQL car ceci assure la compatibilite avec WordPress et la flexibilite la configuration de la base de donnee.
- Quand je cree un volume par exemple pour Wordpress celui-ci va stocker les fichiers de la base de donnee Wordpress. cela permet de stocker les donnees en dehors du conteneur et de les reutiliser facilement.
    => le volume est "declare" deux fois. Une fois dans le volumes en bas qui etablie la configuration. cette configuration permet de lier les repertoires des machines hotes aux volumes docker assurant la persistance des donnes meme si ceux-la sont supprimes. 
mariadb_data:/var/lib/mysql 
wordpress_data:/var/www/html
    => Ce sont les chemins utilises par defaut pour stocker les donnees

## NGINX    

### TLS / SSL

    Crypter les donnees du site. C'est un certificat qui crypte la connection entre l'utilisateur et les serveur. Eviter une fuite de donnee sensible

### REVERSE PROXY

    - Le but permet de securiser notre serveur en ne devoilant pas les addresses ip des erveurs hebergeant notre site.
    - Assurer une protection en bloquant certaines requetes
    

