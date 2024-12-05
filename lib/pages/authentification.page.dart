import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthentificationPage extends StatelessWidget {
  final TextEditingController txtLogin = TextEditingController(); // Renommé pour la cohérence
  final TextEditingController txtPassword = TextEditingController(); // Renommé pour la cohérence
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  AuthentificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Authentification")),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
              "https://png.pngtree.com/thumb_back/fw800/background/20190222/ourmid/pngtree-world-travel-famous-building-theme-poster-background-goddessworld-famous-buildingcastlewhite-image_50264.jpg",
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildTextField(
                    controller: txtLogin,
                    hintText: "Identifiant (Email)",
                    icon: Icons.person,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer un identifiant';
                      }
                      if (!RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
                          .hasMatch(value)) {
                        return 'Format email invalide';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  _buildTextField(
                    controller: txtPassword,
                    hintText: "Mot de passe",
                    icon: Icons.password,
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer un mot de passe';
                      }
                      if (value.length < 6) {
                        return 'Le mot de passe doit contenir au moins 6 caractères';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _onConnect(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                    ),
                    child: const Text("Connexion"),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/inscription');
                    },
                    child: const Text("S'inscrire"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    bool obscureText = false,
    required String? Function(String?) validator,
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
      validator: validator,
    );
  }

  Future<void> _onConnect(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> users = prefs.getStringList("users") ?? [];

    // Debug - Liste des utilisateurs
    print("Liste des utilisateurs : $users");

    bool isAuthenticated = false;
    for (var user in users) {
      List<String> userData = user.split(',');
      // Debug - Vérification des informations de l'utilisateur
      print("Vérification de l'utilisateur : ${userData[2]} == ${txtLogin.text} et ${userData[3]} == ${txtPassword.text}");
      if (userData.length == 4 && userData[2] == txtLogin.text && userData[3] == txtPassword.text) {
        isAuthenticated = true;
        break;
      }
    }

    if (isAuthenticated) {
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      _showDialog(context, "Erreur", "Identifiant ou mot de passe incorrect.");
    }
  }

  void _showDialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }
}
