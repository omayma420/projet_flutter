import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'pages/authentification.page.dart';
import 'pages/apropos.page.dart';
import 'pages/gallerie.page.dart';
import 'pages/metio.page.dart';
import 'pages/users.page.dart'; 
import 'pages/contact.page.dart';
import 'pages/pays.page.dart';

import 'pages/home.page.dart';
import 'pages/inscription.page.dart';
import 'pages/Excursion.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  final routes = <String, WidgetBuilder>{
    '/inscription': (context) =>  InscriptionPage(),
    '/authentification': (context) => AuthentificationPage(),
    '/home': (context) => const HomePage(),
    '/apropos': (context) => const apropos(),
    '/gallerie': (context) =>  GalleriePage(),
    '/metio': (context) => const metio(),
    '/pays': (context) =>  pays(),
    '/excursions': (context) => ExcursionsPage(),
    '/users': (context) => UsersPage(), // Ajout de la page UsersPage

'/contact': (context) => ContactFormPage()
  };

 @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: routes,
      home: FutureBuilder<SharedPreferences>(
        future: SharedPreferences.getInstance(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator()); // Afficher un loader pendant le chargement des préférences
          }

          if (snapshot.hasData) {
            bool isConnected = snapshot.data!.getBool('connecte') ?? false;
            // Si l'utilisateur est connecté, rediriger vers la page d'accueil
            if (isConnected) {
              return const HomePage();
            } else {
              // Si non connecté, rediriger vers la page d'authentification
              return AuthentificationPage();
            }
          }

          // Si aucune donnée n'est chargée, retourner la page d'authentification par défaut
          return AuthentificationPage();
        },
      ),
    );
  }
}