// lib/screens/about_screen.dart
import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("À propos"),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Task Manager",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "Version 1.0.0",
              style: TextStyle(fontSize: 16, color: Colors.white70),
            ),
            const SizedBox(height: 24),
            const Text(
              "Politique de confidentialité :",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "L’application Task Manager ne collecte aucune donnée personnelle. "
              "Toutes les informations que vous entrez (catégories, projets, tâches) "
              "sont stockées localement sur votre appareil et ne sont pas partagées "
              "avec des tiers. Les données restent accessibles uniquement par vous.",
              style: TextStyle(fontSize: 14, color: Colors.white70),
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () => _showFullPrivacyPolicy(context),
              child: const Text(
                "Voir la politique complète",
                style: TextStyle(
                  color: Colors.teal,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showFullPrivacyPolicy(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.grey[900],
          title: const Text(
            "Politique de confidentialité complète",
            style: TextStyle(color: Colors.white),
          ),
          content: const SingleChildScrollView(
            child: Text(
              "Dernière mise à jour : 11 septembre 2025\n\n"
              "1. Introduction\n"
              "L’application Task Manager est développée par Nahi Amine. "
              "Nous accordons une grande importance à la protection de votre vie privée.\n\n"
              "2. Collecte et Utilisation des Données\n"
              "- Aucune collecte de données personnelles : L’Application n’envoie "
              "aucune donnée à des serveurs externes. Toutes les informations que vous "
              "entrez sont stockées localement sur votre appareil.\n"
              "- Données locales : Les données que vous créez restent exclusivement "
              "sur votre appareil.\n\n"
              "3. Permissions\n"
              "- Accès à Internet : L’Application peut demander l’accès à Internet "
              "uniquement pour ouvrir les liens GitHub que vous avez ajoutés.\n\n"
              "4. Sécurité des Données\n"
              "Les données stockées localement sont accessibles uniquement par vous.\n\n"
              "5. Modifications de la Politique de Confidentialité\n"
              "Cette politique peut être mise à jour occasionnellement. "
              "Votre utilisation continue de l’Application après toute modification "
              "constitue votre acceptation de la nouvelle politique.\n\n"
              "6. Contact\n"
              "Pour toute question, contactez-nous via le service du store.",
              style: TextStyle(color: Colors.white70, fontSize: 14),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                "Fermer",
                style: TextStyle(color: Colors.teal),
              ),
            ),
          ],
        );
      },
    );
  }
}
