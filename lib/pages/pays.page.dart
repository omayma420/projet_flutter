import 'package:flutter/material.dart';


import '/menu/drawer.page.dart';
import 'pays_details.dart';



class pays extends StatelessWidget {
  TextEditingController txt_pays = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        title: Center(child: Text("pays Page")),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Bienvenue sur la page pays',
              style: TextStyle(fontSize: 22),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: txt_pays,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.sunny),
                hintText: "pays",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(width: 1),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _onGetMeteoDetails(context);
              },
              child: Text("chercher"),
              style: ElevatedButton.styleFrom(maximumSize: Size.fromHeight(50)),
            )
          ],
        ),
      ),
    );
  }

  void _onGetMeteoDetails(BuildContext context) {
    String v = txt_pays.text;
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PaysDetails(v)),
    );
    txt_pays.text = "";
  }
}



