import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:t7crudapi/pages/detail.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //Variabel
  var dataJson;

  //Fungsi
  getData() async {
    //untuk mengambil data
    http.Response hasil = await http.get(
        "https://script.google.com/macros/s/AKfycbyb7fjSjSdviltbeDkGCaqzVdUbayoTBToPy5yItN3BKrcPI8J-/exec",
        headers: {"Accept": "application/json"});

    this.setState(() {
      dataJson = json.decode(hasil.body);
      dataJson = dataJson["users"];
      print(dataJson);
    });
  }

  //untuk memulai fungsi saat pertama kali di jalankan
  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        actions: [
          FlatButton(
              onPressed: () {
                Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => new Detail()));
              },
              child: Icon(
                Icons.add,
                color: Colors.white,
              )),
          FlatButton(
              onPressed: () {
                getData();
              },
              child: Icon(
                Icons.refresh,
                color: Colors.white,
              ))
        ],
      ),
      body: ListView.builder(
          itemCount: dataJson == null ? 0 : dataJson.length,
          itemBuilder: (context, i) {
            if (dataJson.length > 0) {
              return Container(
                  padding: EdgeInsets.all(2.0),
                  child: Card(
                    child: ListTile(
                      title: Text(dataJson[i]['name']),
                      subtitle: Text(dataJson[i]['email']),
                      trailing: Text(dataJson[i]['address']),
                    ),
                  ));
            } else {
              return Container();
            }
          }),
    );
  }
}
