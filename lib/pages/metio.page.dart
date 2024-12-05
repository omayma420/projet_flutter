import 'package:flutter/material.dart';
import 'meteo-details.page.dart';
import '../menu/drawer.page.dart';

class metio extends StatelessWidget {
  const metio({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController txtVille = TextEditingController();

    void _onGetMeteoDetails(BuildContext context) {
      String ville = txtVille.text;
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MeteoDetailsPage(ville)),
      );
      txtVille.clear();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Page Météo")),
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
           
              
              const Text(
                "Bienvenue sur l'application Météo. Entrez une ville pour connaître les prévisions météo.",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.black54,
                ),
                textAlign: TextAlign.center, // Aligner le texte au centre
              ),
              const SizedBox(height: 30),
              
              // Champ de saisie pour la ville
              Container(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  controller: txtVille,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.location_city, color: Colors.blue),
                    hintText: "Entrez le nom de la ville",
                    hintStyle: const TextStyle(color: Colors.blueGrey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.blueAccent, width: 1),
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  ),
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              
              const SizedBox(height: 20),

              // Bouton de recherche
              ElevatedButton(
                onPressed: () {
                  _onGetMeteoDetails(context);
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                  
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Chercher la Météo",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
