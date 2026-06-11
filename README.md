TaskFlow – Gestionnaire de Tâches

Taskflow est un gestionnaire de tâches avec les fonctionnalités suivantes :
Authentification, Gestion des tâches (CRUD),gestion des Catégorie (Travail, Étude, Personnel...), Priorité des tâches (Faible, Moyenne, Haute), Date limite des tâches, Recherche et filtrage, Statistiques (Nombre de tâches terminées, Nombre de tâches en cours)

lib/
│
├── models/
│   ├── user.dart
│   └── task.dart
│
├── views/
│   ├── auth/
│   │   ├── login_page.dart
│   │   └── register_page.dart
│   │
│   ├── tasks/
│   │   ├── home_page.dart
│   │   ├── add_task_page.dart
│   │   ├── edit_task_page.dart
│   │   └── task_details_page.dart
│
├── controllers/
│   ├── auth_controller.dart
│   └── task_controller.dart
│
├── database/
│   └── database_helper.dart
│
├── widgets/
│   └── task_card.dart
│
├── utils/
│   └── constants.dart
│
└── main.dart

Architecture MVC adoptée :

Notre application TaskFlow est développée selon l’architecture MVC (Model – View – Controller). Cette architecture permet de séparer les différentes responsabilités de l’application afin d’obtenir un code plus organisé, plus maintenable et plus facile à faire évoluer.

1. Model (Modèle)

Le Model représente les données de l’application ainsi que leur structure. Il correspond aux entités manipulées dans la base de données SQLite.

Dans notre application, les modèles sont :

User : représente un utilisateur avec ses informations (id, nom, email et mot de passe).
Task : représente une tâche avec ses informations (titre, description, catégorie, priorité, date, statut et utilisateur propriétaire).

Les modèles contiennent également les méthodes :

toMap() : permet de convertir un objet Dart en données compatibles avec SQLite.
fromMap() : permet de convertir les données récupérées depuis SQLite en objets Dart.

Fichiers concernés :

lib/models/
├── user.dart
└── task.dart
2. View (Vue)

La View correspond aux interfaces graphiques avec lesquelles l’utilisateur interagit. Elle affiche les données et récupère les actions de l’utilisateur à travers les formulaires, boutons et écrans.

Dans notre application, les vues sont :

LoginPage : connexion des utilisateurs.
RegisterPage : création d’un nouveau compte.
HomePage : affichage de la liste des tâches.
AddTaskPage : ajout d’une nouvelle tâche.
EditTaskPage : modification d’une tâche.

Fichiers concernés :

lib/views/
├── auth/
│   ├── login_page.dart
│   └── register_page.dart
└── tasks/
    ├── home_page.dart
    ├── add_task_page.dart
    └── edit_task_page.dart
3. Controller (Contrôleur)

Le Controller contient la logique métier de l’application. Il joue le rôle d’intermédiaire entre la View et le Model. Il reçoit les actions de l’utilisateur, traite les données et communique avec la base SQLite.

Dans notre application :

AuthController : gère l’authentification des utilisateurs (inscription et connexion).
TaskController : gère les opérations CRUD des tâches (ajouter, afficher, modifier, supprimer et changer le statut).

Fichiers concernés :

lib/controllers/
├── auth_controller.dart
└── task_controller.dart
4. Base de données SQLite

La gestion de la base de données est centralisée dans la classe DatabaseHelper, qui utilise le pattern Singleton afin de garantir une seule instance de connexion à la base de données pendant l’exécution de l’application.

Elle est responsable de :

La création de la base taskflow.db.
La création des tables users et tasks.
L’ouverture et la gestion de la connexion SQLite.

Fichier concerné :

lib/database/database_helper.dart
Fonctionnement général de l’application

Le fonctionnement de l’architecture MVC dans l’application peut être résumé comme suit :

Utilisateur
     |
     | Interaction
     ↓
View (Interface Flutter)
     |
     | Appel des méthodes
     ↓
Controller (Logique métier)
     |
     | Manipulation des objets
     ↓
Model
     |
     | Conversion des données
     ↓
SQLite (Base de données)
Avantages de cette architecture

L’utilisation de l’architecture MVC nous a permis de :

Séparer clairement l’interface graphique, les données et la logique métier.
Faciliter la maintenance et l’évolution de l’application.
Rendre le code plus organisé et réutilisable.
Simplifier les tests et les modifications futures.



- **Captures d’écran principales de l’application :**

**![l**oading-ag-147](C:/Users/LENOVO/Pictures/Typedown/2752772b-3e95-4af7-bd09-b40d8d31c540.png)   ![0dcb292f-9c27-40a0-99a6-dc70121ba370](file:///C:/Users/LENOVO/Pictures/Typedown/0dcb292f-9c27-40a0-99a6-dc70121ba370.png)  



![3e9b0d9d-8ace-4065-bdac-ca4815fe48fd](file:///C:/Users/LENOVO/Pictures/Typedown/3e9b0d9d-8ace-4065-bdac-ca4815fe48fd.png)   ![2dcc6ce3-d330-4fff-9279-2c80e2a719e8](file:///C:/Users/LENOVO/Pictures/Typedown/2dcc6ce3-d330-4fff-9279-2c80e2a719e8.png)  





- Les étapes d’installation et d’exécution du projet:
  
  + Étape 1 : Cloner le dépôt
    
    * git clone https://github.com/israekor/TaskFlow.git
  
  + Étape 2 : Installer les dépendances
    
    * flutter pub get
  
  + Étape 3 : Exécuter l'application
    
    + flutter run
    
    
    
    

Technologies utilisées
----------------------

* **Framework principal :** Flutter & Dart

* **Base de données :** SQLite (`sqflite` plugin)














