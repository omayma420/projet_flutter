import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UsersPage extends StatefulWidget {
  @override
  _UsersPageState createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  List<String> users = [];

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  // Charger les utilisateurs depuis SharedPreferences
  Future<void> _loadUsers() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      users = prefs.getStringList("users") ?? [];
    });
  }

  // Fonction pour supprimer un utilisateur
  Future<void> _deleteUser(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    users.removeAt(index);
    prefs.setStringList("users", users);
    _loadUsers();  // Mettre à jour la liste après suppression
  }

  // Fonction pour modifier un utilisateur
  Future<void> _editUser(int index) async {
    // Ici, vous pouvez ajouter une fonctionnalité de modification (par exemple, ouvrir un formulaire de modification)
    String user = users[index];
    List<String> userData = user.split(',');

    // Vous pouvez ouvrir un formulaire d'édition avec les informations existantes et permettre à l'utilisateur de les modifier.
    showDialog(
      context: context,
      builder: (context) {
        final TextEditingController nomController = TextEditingController(text: userData[0]);
        final TextEditingController prenomController = TextEditingController(text: userData[1]);
        final TextEditingController loginController = TextEditingController(text: userData[2]);
        final TextEditingController passwordController = TextEditingController(text: userData[3]);

        return AlertDialog(
          title: const Text("Modifier l'utilisateur"),
          content: Column(
            children: [
              TextField(controller: nomController, decoration: const InputDecoration(labelText: "Nom")),
              TextField(controller: prenomController, decoration: const InputDecoration(labelText: "Prénom")),
              TextField(controller: loginController, decoration: const InputDecoration(labelText: "Login")),
              TextField(controller: passwordController, decoration: const InputDecoration(labelText: "Mot de passe")),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                // Mettre à jour l'utilisateur dans la liste
                users[index] = "${nomController.text},${prenomController.text},${loginController.text},${passwordController.text}";
                SharedPreferences.getInstance().then((prefs) {
                  prefs.setStringList("users", users);
                  _loadUsers(); // Mettre à jour la liste après modification
                });
                Navigator.pop(context);
              },
              child: const Text("Enregistrer"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Annuler"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Liste des utilisateurs"),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: DataTable(
            columns: const [
              DataColumn(label: Text("Nom")),
              DataColumn(label: Text("Prénom")),
              DataColumn(label: Text("Login")),
              DataColumn(label: Text("Actions")),
            ],
            rows: List.generate(
              users.length,
              (index) {
                List<String> userData = users[index].split(',');
                return DataRow(cells: [
                  DataCell(Text(userData[0])),  // Nom
                  DataCell(Text(userData[1])),  // Prénom
                  DataCell(Text(userData[2])),  // Login
                  DataCell(
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () => _editUser(index),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => _deleteUser(index),
                        ),
                      ],
                    ),
                  ),  // Actions (modifier, supprimer)
                ]);
              },
            ),
          ),
        ),
      ),
    );
  }
}
