import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PaysDetails extends StatefulWidget {
  final String ville;
  PaysDetails(this.ville); //constructor

  @override
  _PaysDetailsPageState createState() => _PaysDetailsPageState();
}

class _PaysDetailsPageState extends State<PaysDetails> {
  var paysData;

  @override
  void initState() {
    super.initState();
    getPaysData(widget.ville);
  }

  void getPaysData(String ville) {
    print("Météo de la ville de " + ville);
    String url =
        "https://restcountries.com/v2/name/${ville}";
    http.get(Uri.parse(url)).then((resp) {
      setState(() {
        this.paysData = json.decode(resp.body)[0]; // Assuming you only want data for the first country returned
        print(this.paysData);
      });
    }).catchError((err) {
      print(err);
    });
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Détails du pays ${widget.ville}",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue,
      ),
      body: paysData == null
          ? Center(
        child: CircularProgressIndicator(),
      )
          : SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(
                paysData['flags']['png'],
                width: 150,
                height: 100,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: 20),
            _buildnormalSection(utf8.decode(paysData['name'].runes.toList())),
            _buildnormalSection(utf8.decode(paysData['nativeName'].runes.toList())),

            _buildBlueSection("Administration"),
            _buildSection("Capitale:", utf8.decode(paysData['capital'].runes.toList())),
            _buildSection("Langue:", "${paysData['languages'][0]['name']} (${utf8.decode(paysData['languages'][0]['nativeName'].runes.toList())})"),
            _buildBlueSection("Géographie"),
            _buildSection("Région:", paysData['region']),
            _buildSection("Superficie:", "${paysData['area']} km²"),
            _buildSection("Fuseau horaire:", paysData['timezones'][0]),
            _buildBlueSection("Démographie"),
            _buildSection("Population:", "${paysData['population']}"),

          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(width: 10),
          Text(
            value,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildBlueSection(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20),
        Text(
          title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue),
        ),
        SizedBox(height: 10),
      ],
    );
  }

  Widget _buildnormalSection(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20),
        Text(
          title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
      ],
    );
  }
}
