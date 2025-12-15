# 🚀 CodeBrief

> **CodeBrief** est une application Flutter de gestion de projets et de tâches destinée aux développeurs.
> Elle permet d’organiser des projets par catégories, de suivre les technologies utilisées et d’ajouter des liens utiles (GitHub, documentation, etc.).

---

## ✨ Fonctionnalités

- 📂 **Catégories** : Organisation structurée des projets.
- 📁 **Projets** : Création et suivi de projets.
- 📝 **Tâches** : Gestion des tâches par projet.
- 🛠 **Technologies** : Ajout des technologies utilisées.
- 🔗 **Liens** : Intégration de liens GitHub et ressources externes.
- 💾 **Stockage** : Persistance locale des données.
- 🎨 **UI** : Interface Material Design (mode sombre).
- 🌐 **Support** : Web, Android et Desktop.

---

## 🛠️ Stack technique

- **Flutter** (SDK ^3.6.0)
- **Dart**
- **Material Design**
- `shared_preferences`
- `uuid`

---

## 📱 Plateformes supportées

| Plateforme | Statut |
|:---|:---|
| Web (Chrome) | ✅ |
| Android | ✅ |
| Linux Desktop | ✅ |
| iOS | ⚠️ Configuration requise |

---

## 🚀 Installation

### Prérequis

- Flutter installé
- Chrome ou un émulateur Android

**Vérifier l’environnement :**
```
flutter doctor
```
1. Cloner le projet

```
git clone [https://github.com/ton-username/code_brief.git](https://github.com/ton-username/code_brief.git)
cd code_brief
```
Installer les dépendances
```
flutter pub get
```
3. Lancer l’application

Web :

```
flutter run -d chrome
```
Android :

```
flutter run
```

🎨 Icône & Branding
Outil : Icône générée avec flutter_launcher_icons

Web Favicon : web/favicon.png

Nom Web : <title>CodeBrief</title>

📂 Structure du projet
Plaintext
lib/
 ├── models/       # Modèles de données
 ├── services/     # Services (ex: stockage local)
 ├── screens/      # Écrans de l'application
 └── main.dart     # Point d'entrée
🧪 Tests
```
flutter test
```
📌 État du projet
✅ Application stable et fonctionnelle

Améliorations possibles

[ ] Synchronisation cloud

[ ] Authentification utilisateur

[ ] Export des projets

[ ] Mode collaboratif

[ ] Notifications

👤 Auteur
Amine Développeur Flutter Projet personnel

📄 Licence
Projet privé – usage personnel ou éducatif.
