CodeBrief
CodeBrief est une application Flutter de gestion de projets et de tâches destinée aux développeurs. Elle permet d’organiser des projets par catégories, de suivre les technologies utilisées et d’ajouter des liens utiles (GitHub, documentation, etc.).

✨ Fonctionnalités
📂 Organisation : Gestion efficace de catégories.

📁 Projets : Création et suivi de projets de développement.

📝 Tâches : Gestion des tâches détaillée par projet.

🛠 Tech Stack : Ajout et visualisation des technologies utilisées.

🔗 Ressources : Liens rapides vers GitHub ou des documentations externes.

💾 Persistance : Stockage local des données (pas de perte au redémarrage).

🎨 UI/UX : Interface Material Design avec un thème sombre adapté aux devs.

🌐 Multi-plateforme : Support Web, Android et Desktop.

🛠️ Stack technique
Framework : Flutter (SDK ^3.6.0)

Langage : Dart

Design System : Material Design

Dépendances clés :

shared_preferences (Stockage local)

uuid (Génération d'identifiants uniques)

📱 Plateformes supportées
Plateforme	Statut
Web (Chrome)	✅ Fonctionnel
Android	✅ Fonctionnel
Linux Desktop	✅ Fonctionnel
iOS	⚠️ Configuration requise
🚀 Installation
Prérequis

Assurez-vous d'avoir installé :

Flutter SDK

Chrome (pour le web) ou un émulateur Android.

Vérifier l’environnement :

Bash
flutter doctor
1. Cloner le projet

Remplacez ton-username par votre nom d'utilisateur GitHub.

Bash
git clone https://github.com/ton-username/code_brief.git
cd code_brief
2. Installer les dépendances

Bash
flutter pub get
3. Lancer l’application

Pour le Web :

Bash
flutter run -d chrome
Pour Android :

Bash
flutter run
🎨 Icône & Branding
Outil : Icônes générées avec flutter_launcher_icons.

Web Favicon : web/favicon.png.

Titre Web : <title>CodeBrief</title> défini dans index.html.

📂 Structure du projet
Voici l'arborescence simplifiée du code source :

Plaintext
lib/
├── models/       # Modèles de données (Projet, Tâche, Catégorie)
├── services/     # Logique métier et stockage (SharedPrefs)
├── screens/      # Écrans de l'interface utilisateur
└── main.dart     # Point d'entrée de l'application
🧪 Tests
Pour lancer les tests unitaires et widgets :

Bash
flutter test
📌 État du projet & Roadmap
État actuel : ✅ Application stable et fonctionnelle (MVP).

Améliorations futures envisagées :

[ ] Synchronisation cloud (Firebase ou Supabase).

[ ] Authentification utilisateur.

[ ] Export des données de projets (JSON/PDF).

[ ] Mode collaboratif.

[ ] Système de notifications de rappel.

👤 Auteur
Amine

Développeur Flutter

Projet personnel

📄 Licence
Ce projet est privé et destiné à un usage personnel ou éducatif.
