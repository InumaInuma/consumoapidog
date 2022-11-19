import 'package:http/http.dart' as http;

import '../model/model.dart';

var base = "https://dog.ceo";
getWorlData() async {
  try {
    Uri url = Uri.parse("$base/api/breeds/list/all");
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var data = modelFromJson(response.body);
      return data.message;
    } else {
      throw Exception('falla conexion');
    }
  } catch (e) {
    print(e.toString());
  }
}
