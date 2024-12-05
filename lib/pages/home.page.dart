import 'package:flutter/material.dart';

import '../menu/drawer.page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        title: const Center(child: Text("Home page")),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Wrap(
          children: [
            InkWell(
              child: Ink.image(
                  height:180,
                  width: 180,
                  image: const AssetImage('images/apropos.png')),
              onTap: (){
                Navigator.pop(context);
                Navigator.pushNamed(context,"/apropos");
              },
            ),
            InkWell(
              child: Ink.image(
                  height:180,
                  width: 180,
                  image: const AssetImage('images/excursion.png')),
              onTap: (){
                Navigator.pop(context);
                Navigator.pushNamed(context,"/excursions");
              },
            ),
            InkWell(
              child: Ink.image(
                  height:180,
                  width: 180,
                  image: const AssetImage('images/meteo.png')),
              onTap: (){
                Navigator.pop(context);
                Navigator.pushNamed(context,"/metio");
              },
            ),
            InkWell(
              child: Ink.image(
                  height:180,
                  width: 180,
                  image: const AssetImage('images/gallerie.png')),
              onTap: (){
                Navigator.pop(context);
                Navigator.pushNamed(context,"/gallerie");
              },
            ),
            InkWell(
              child: Ink.image(
                  height:180,
                  width: 180,
                  image: const AssetImage('images/pays.png')),
              onTap: (){
                Navigator.pop(context);
                Navigator.pushNamed(context,"/pays");
              },
            ),
                  InkWell(
              child: Ink.image(
                  height:180,
                  width: 180,
                  image: const AssetImage('images/contact.png')),
              onTap: (){
                Navigator.pop(context);
                Navigator.pushNamed(context,"/contact");
              },
            ),
            InkWell(
              child: Ink.image(
                  height:180,
                  width: 180,
                  image: const AssetImage('images/deconnexion.png')),
              onTap: (){
                Navigator.pop(context);
                Navigator.pushNamed(context,"/authentification");
              },
            )
          ],
        ),
      ),
    );
  }

  
  }




