import 'dart:convert' as convert;
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DropdownScreen extends StatefulWidget {
  const DropdownScreen({super.key});

  @override
  State<DropdownScreen> createState() => _DropdownScreenState();
}

class _DropdownScreenState extends State<DropdownScreen> {
  String url =
      'https://dog.ceo/api/breeds/list/all';

  List _dogo = [];
  var _image = [];
  var _url = [];

  String? dogi;

  bool isCountrySelected = false;
  bool istateSelected = false;

  Future getWorlData() async {
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var jsonresponse = convert.jsonDecode(response.body.toString());
      //Map<String, dynamic> map = json.decode(response.body);
      //List<dynamic> data = map["message"];
      //print(data[0]["name"]);
      setState(() {
        _dogo = jsonresponse;
      });

      print(_dogo);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    getWorlData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("SELECCIONE RAZA")),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            if (_dogo.isEmpty)
              const Center(child: CircularProgressIndicator())
            else
              Card(
                color: Colors.blue.withOpacity(0.5),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: DropdownButton<String>(
                    underline: Container(),
                    hint: Text("select dog"),
                    icon: const Icon(Icons.keyboard_arrow_down),
                    isDense: true,
                    isExpanded: true,
                    items: _dogo.map((ctry) {
                      return DropdownMenuItem<String>(
                          value: ctry["name"], child: Text(ctry["name"]));
                    }).toList(),
                    value: dogi,
                    onChanged: ((value) {
                      setState(() {
                        _image = [];
                        dogi = value;
                        for (int i = 0; i < _dogo.length; i++) {
                          if (_dogo[i]["name"] == value) {
                            _image = _dogo[i]["states"];
                          }
                        }
                        isCountrySelected = true;
                      });
                    }),
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
