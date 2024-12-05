import 'package:flutter/material.dart';
import 'package:flutter_application_1/menu/drawer.page.dart';

// Modèle pour représenter une excursion
class Excursion {
  final String title;
  final String description;
  final double price;
  final String imageUrl;

  Excursion({
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
  });
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Voyage App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
  //excursions: ExcursionsPage(),
    );
  }
}

class ExcursionsPage extends StatelessWidget {
  // Liste des excursions proposées
  final List<Excursion> excursions = [
    Excursion(
      title: 'Excursion à la plage',
      description: 'Profitez d\'une journée de détente à la plage avec des activités nautiques.',
      price: 50.0,
      imageUrl: 'https://www.civitatis.com/f/mozambique/maputo/excursion-playa-calanga-589x392.jpg',
    ),
    Excursion(
      title: 'Visite des montagnes',
      description: 'Explorez les montagnes avec un guide local et découvrez la beauté naturelle.',
      price: 75.0,
      imageUrl: 'https://media.atlasformen.com/blogmedia/uploads/2023/07/destination-montagne.png',
    ),
    Excursion(
      title: 'Plongée sous-marine',
      description: 'Explorez les fonds marins avec une plongée sous-marine guidée dans un environnement riche en biodiversité.',
      price: 120.0,
      imageUrl: 'https://static.wixstatic.com/media/3e3818_b924ed049be842d98c9bced55cd1dc92~mv2.png/v1/fill/w_740,h_416,al_c,q_85,usm_0.66_1.00_0.01,enc_auto/3e3818_b924ed049be842d98c9bced55cd1dc92~mv2.pngs',
    ),
    Excursion(
      title: 'Tour en hélicoptère',
      description: 'Vivez l\'expérience unique d\'un tour en hélicoptère pour voir les paysages magnifiques depuis les airs.',
      price: 250.0,
      imageUrl: 'https://media-cdn.tripadvisor.com/media/attractions-splice-spp-674x446/0b/bb/d8/55.jpg',
    ),
    Excursion(
      title: 'Safari dans la jungle',
      description: 'Venez découvrir la faune sauvage avec un safari organisé dans la jungle.',
      price: 100.0,
      imageUrl: 'https://media.atlasformen.com/blogmedia/uploads/2023/07/destination-montagne.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        title: Text("Liste des excursions"),
        backgroundColor: Colors.blue,
        actions: [],
      ),
      body: ListView.builder(
        itemCount: excursions.length,
        itemBuilder: (context, index) {
          final excursion = excursions[index];
          return Card(
            margin: EdgeInsets.all(10.0),
            child: ListTile(
              leading: Image.network(excursion.imageUrl), // Affichage de l'image
              title: Text(excursion.title),
              subtitle: Text(excursion.description),
              trailing: Text('\$${excursion.price}'),
              onTap: () {
                // Naviguer vers la page de détails de l'excursion
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ExcursionDetailsPage(excursion: excursion),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

// Page de détails de l'excursion
class ExcursionDetailsPage extends StatelessWidget {
  final Excursion excursion;

  ExcursionDetailsPage({required this.excursion});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(excursion.title),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Image.network(excursion.imageUrl), // Affichage de l'image de l'excursion
            SizedBox(height: 16),
            Text(
              excursion.title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              excursion.description,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'Prix: \$${excursion.price}',
              style: TextStyle(fontSize: 20, color: Colors.green),
            ),
          ],
        ),
      ),
    );
  }
}