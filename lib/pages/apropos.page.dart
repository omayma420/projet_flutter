import 'package:flutter/material.dart';
import '../menu/drawer.page.dart';

class apropos extends StatelessWidget {
  const apropos({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        title: const Text("À propos"),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Titre de l'agence
            Text(
              "Bienvenue chez Flyaway ✈️✨",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),

            // Image illustrative
            Center(
              child: Image.asset(
                'images/travel.png', // Remplacez par le chemin de votre image
                height: 150,
              ),
            ),
            const SizedBox(height: 16),

            // Description
            Text(
              "Flyaway, votre partenaire de confiance pour explorer le monde. "
              "Nous transformons vos rêves de voyage en réalité avec des services personnalisés et une expérience unique.",
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 24),

            // Informations de contact
            Text(
              "Contactez-nous 📞",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.phone, color: Colors.blueAccent),
                const SizedBox(width: 8),
                Text("+216 123 456 789"), // Remplacez par le numéro réel
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.email, color: Colors.blueAccent),
                const SizedBox(width: 8),
                Text("contact@flyaway.com"), // Remplacez par l'email réel
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.location_on, color: Colors.blueAccent),
                const SizedBox(width: 8),
                Text("123 Rue du Paradis, Sfax, Tunisie"), // Remplacez par l'adresse réelle
              ],
            ),
          ],
        ),
      ),
    );
  }
}