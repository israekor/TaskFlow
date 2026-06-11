# TaskFlow – Application de Gestion de Tâches

## Présentation du projet

**TaskFlow** est une application mobile développée avec **Flutter** permettant aux utilisateurs de gérer efficacement leurs tâches quotidiennes. L’application offre un système complet de gestion des tâches incluant l’authentification des utilisateurs, les opérations CRUD, la catégorisation des tâches, la gestion des priorités, la définition de dates limites ainsi que des statistiques de suivi.

L’objectif de TaskFlow est de fournir une interface simple, intuitive et organisée pour améliorer la productivité des utilisateurs.

---

## Fonctionnalités principales

### Authentification

* Création d’un nouveau compte utilisateur.
* Connexion sécurisée à l’application.
* Gestion des sessions utilisateurs.

### Gestion des tâches (CRUD)

* Ajouter une nouvelle tâche.
* Consulter la liste des tâches.
* Modifier les informations d’une tâche.
* Supprimer une tâche.
* Changer le statut d’une tâche (en cours ou terminée).
* Consulter les détails d’une tâche.

### Organisation des tâches

* Classification par catégories :

  * Travail
  * Étude
  * Personnel
  * Autres
* Gestion du niveau de priorité :

  * Faible
  * Moyenne
  * Haute
* Définition d’une date limite pour chaque tâche.

### Recherche et filtrage

* Recherche rapide des tâches par titre.
* Filtrage des tâches selon leur catégorie, leur priorité ou leur état.

### Statistiques

* Nombre total de tâches.
* Nombre de tâches terminées.
* Nombre de tâches en cours.

---

# Architecture du projet

L’application suit l’architecture **MVC (Model – View – Controller)**. Cette architecture permet de séparer l’interface utilisateur, la logique métier et les données afin d’obtenir une application plus claire, maintenable et évolutive.

## Structure du projet

```text
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
```

---

## Modèle (Model)

Le **Model** représente la structure des données manipulées par l’application et les entités stockées dans la base SQLite.

Les modèles utilisés sont :

### User

Représente un utilisateur avec les informations suivantes :

* Identifiant (`id`)
* Nom
* Adresse e-mail
* Mot de passe

### Task

Représente une tâche avec les informations suivantes :

* Identifiant (`id`)
* Titre
* Description
* Catégorie
* Priorité
* Date limite
* Statut de la tâche
* Utilisateur propriétaire

Les modèles contiennent les méthodes :

* `toMap()` : convertit un objet Dart en une structure compatible avec SQLite.
* `fromMap()` : convertit les données provenant de SQLite en objets Dart.

---

## Vue (View)

La **View** correspond aux interfaces graphiques développées avec Flutter. Elle permet l’interaction entre l’utilisateur et l’application.

Les principales vues sont :

* **LoginPage** : authentification de l’utilisateur.
* **RegisterPage** : création d’un nouveau compte.
* **HomePage** : affichage de la liste des tâches.
* **AddTaskPage** : ajout d’une nouvelle tâche.
* **EditTaskPage** : modification d’une tâche.
* **TaskDetailsPage** : consultation des détails d’une tâche.

---

## Contrôleur (Controller)

Le **Controller** contient la logique métier et assure la communication entre la vue, les modèles et la base de données.

Les contrôleurs implémentés sont :

### AuthController

Responsable de :

* L’inscription des utilisateurs.
* La connexion des utilisateurs.
* La validation des informations d’authentification.

### TaskController

Responsable de :

* L’ajout des tâches.
* La récupération des tâches.
* La mise à jour des tâches.
* La suppression des tâches.
* La gestion du changement de statut des tâches.
* La recherche et le filtrage.

---

## Gestion de la base de données

La persistance des données est assurée par SQLite à travers la classe `DatabaseHelper`.

Cette classe utilise le **design pattern Singleton** afin de garantir une seule instance de connexion à la base de données pendant toute l’exécution de l’application.

Ses responsabilités principales sont :

* Création de la base de données `taskflow.db`.
* Création des tables `users` et `tasks`.
* Gestion de l’ouverture et des requêtes SQLite.
* Centralisation des opérations liées à la base de données.

---

## Fonctionnement de l’architecture MVC

Le flux de communication entre les différentes couches de l’application est représenté par le schéma suivant :

```text
Utilisateur
     |
     | Interaction
     v
View (Interface Flutter)
     |
     | Actions utilisateur
     v
Controller (Logique métier)
     |
     | Manipulation des données
     v
Model
     |
     | Conversion des objets
     v
SQLite (Base de données)
```

---

## Captures d’écran

Les principales captures d’écran de l’application sont disponibles dans le dossier :

```
captures_d_ecran/
```

---

## Installation et exécution du projet

### 1. Cloner le dépôt GitHub

```bash
git clone https://github.com/israekor/TaskFlow.git
```

### 2. Accéder au dossier du projet

```bash
cd TaskFlow
```

### 3. Installer les dépendances

```bash
flutter pub get
```

### 4. Lancer l’application

```bash
flutter run
```

---

## Technologies utilisées

| Technologie | Description                                                      |
| ----------- | ---------------------------------------------------------------- |
| Flutter     | Framework de développement d’interfaces mobiles multiplateformes |
| Dart        | Langage de programmation principal de l’application              |
| SQLite      | Base de données locale embarquée                                 |
| Sqflite     | Plugin Flutter permettant l’accès à SQLite                       |
| MVC         | Architecture utilisée pour la séparation des responsabilités     |

---

## Avantages de l’architecture MVC

L’adoption de l’architecture MVC dans TaskFlow apporte plusieurs avantages :

* Une séparation claire entre l’interface, les données et la logique métier.
* Une meilleure organisation du code source.
* Une maintenance et une évolution plus simples de l’application.
* Une meilleure réutilisation des composants.
* Une facilité de test et de débogage.

---

## Auteur

Projet réalisé dans le cadre d’un projet académique de développement mobile avec Flutter.
