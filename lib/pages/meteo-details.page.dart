import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MeteoDetailsPage extends StatefulWidget {
  final String ville;
  MeteoDetailsPage(this.ville); //constructeur

  @override
  _MeteoDetailsPageState createState() => _MeteoDetailsPageState();
}

class _MeteoDetailsPageState extends State<MeteoDetailsPage> {
  var meteoData;

  @override
  void initState() {
    super.initState();
    getMeteoData(widget.ville);
  }

  void getMeteoData(String ville) {
    print("Météo de la ville de " + ville);
    String url =
        "https://api.openweathermap.org/data/2.5/forecast?q=${ville}&appid=c109c07bc4df77a88c923e6407aef864";
    http.get(Uri.parse(url)).then((resp) {
      setState(() {
        this.meteoData = json.decode(resp.body);
        print(this.meteoData);
      });
    }).catchError((err) {
      print(err);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Météo pour ${widget.ville}", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.blue,
      ),
      body: meteoData == null
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: meteoData['list'].length,
        itemBuilder: (context, index) {
          var weather = meteoData['list'][index]['weather'][0];
          var date = DateTime.fromMillisecondsSinceEpoch(meteoData['list'][index]['dt'] * 1000);
          var temperature = meteoData['list'][index]['main']['temp'];
          var formattedTemperature = (temperature - 273.15).toStringAsFixed(1); // Conversion de Kelvin à Celsius et arrondi à 1 décimale
          var hourMinute = "${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}";
          return Card(
            color: Colors.blue,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage("images/${weather['main'].toString().toLowerCase()}.png"),
                      ),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Date: ${date.toString()}"),
                          Text("Heure et Etat: $hourMinute ${weather['main']}"),
                        ],
                      ),
                    ],
                  ),
                  Text("Température: $formattedTemperature°C"), // Affichage de la température avec l'unité Celsius
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
