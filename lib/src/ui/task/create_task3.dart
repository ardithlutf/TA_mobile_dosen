import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreensss extends StatefulWidget {
  @override
  _HomeScreensssState createState() => _HomeScreensssState();
}

class _HomeScreensssState extends State<HomeScreensss> {
  final String baseurl = 'https://limastt.herokuapp.com';
  String _valProvince;

  List<dynamic> _dataProvince = List();

  void getProvince() async {
    final response = await http.get("$baseurl/api/sprints"); //
    // untuk melakukan request ke webservice
    Map<String, dynamic> map = jsonDecode(response.body); //lalu kita decode hasil datanya
    List<dynamic> data = map["results"];
    setState(() {
      _dataProvince = data; // dan kita set kedalam variable _dataProvince
    });
    print(data[0]["id"]);
  }

  @override
  void initState() {
    super.initState();
    getProvince(); //Ketika pertama kali membuka home screen makan method ini dijalankan untuk pertama kalinya juga
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Dropdown Menu Button JSON")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            DropdownButton(
              hint: Text("Select Province"),
              value: _valProvince,
              items: _dataProvince.map((item) {
                return DropdownMenuItem(
                  child: Text(item['nama_sprint']),
                  value: item['nama_sprint'],
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _valProvince = value;
                });
              },
            ),
            Text(
              "Kamu memilih provinsi $_valProvince",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}