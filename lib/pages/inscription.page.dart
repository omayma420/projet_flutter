import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InscriptionPage extends StatelessWidget {
  final TextEditingController txtNom = TextEditingController();
  final TextEditingController txtPrenom = TextEditingController();
  final TextEditingController txtLogin = TextEditingController();
  final TextEditingController txtPassword = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  InscriptionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Image d'arrière-plan (en ligne)
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  "https://png.pngtree.com/thumb_back/fw800/background/20190222/ourmid/pngtree-world-travel-famous-building-theme-poster-background-goddessworld-famous-buildingcastlewhite-image_50264.jpg",
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Contenu principal avec un effet semi-transparent
          Center(
            child: Container(
              padding: const EdgeInsets.all(20.0),
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Form(
                key: _formKey,
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    // Titre "Inscription"
                    const Text(
                      "Inscription",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(height: 30),

                    // Champ Nom
                    _buildTextField(
                      controller: txtNom,
                      hintText: "Nom",
                      icon: Icons.person,
                    ),
                    const SizedBox(height: 20),

                    // Champ Prénom
                    _buildTextField(
                      controller: txtPrenom,
                      hintText: "Prénom",
                      icon: Icons.person_outline,
                    ),
                    const SizedBox(height: 20),

                    // Champ Login (Email)
                    _buildTextField(
                      controller: txtLogin,
                      hintText: "Identifiant (Email)",
                      icon: Icons.email,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Ce champ est obligatoire';
                        }
                        if (!RegExp(r"^[a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$")
                            .hasMatch(value)) {
                          return 'Veuillez entrer un email valide';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),

                    // Champ Mot de passe
                    _buildTextField(
                      controller: txtPassword,
                      hintText: "Mot de passe",
                      icon: Icons.lock,
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Ce champ est obligatoire';
                        }
                        if (value.length < 6) {
                          return 'Le mot de passe doit contenir au moins 6 caractères';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 30),

                    // Bouton Inscription
                    ElevatedButton(
                      onPressed: () => _onInscrire(context),
                      child: const Text("Inscription"),
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50),
                        backgroundColor: Colors.blue,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Lien pour les utilisateurs existants
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text(
                        "J'ai déjà un compte",
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Champ de texte générique avec validation
  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    bool obscureText = false,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        hintText: hintText,
        filled: true,
        fillColor: Colors.white.withOpacity(0.8),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      validator: validator ??
          (value) => value!.isEmpty ? 'Ce champ est obligatoire' : null,
    );
  }

  /// Méthode appelée lors de l'inscription
  Future<void> _onInscrire(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      // Récupérer la liste des utilisateurs existants
      List<String> users = prefs.getStringList("users") ?? [];

      // Créer un nouvel utilisateur sous forme de chaîne
      String newUser =
          "${txtNom.text},${txtPrenom.text},${txtLogin.text},${txtPassword.text}";
      users.add(newUser);

      // Sauvegarder les utilisateurs dans SharedPreferences
      await prefs.setStringList("users", users);

      // Rediriger vers la page d'accueil après l'inscription
      Navigator.pushReplacementNamed(context, '/home');
    }
  }
}
