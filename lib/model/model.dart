// To parse this JSON data, do
//
//     final model = modelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Model modelFromJson(String str) => Model.fromJson(json.decode(str));

String modelToJson(Model data) => json.encode(data.toJson());

class Model {
    Model({
        required this.message,
        required this.status,
    });

    Map<String, List<String>> message;
    String status;
 
    factory Model.fromJson(Map<String, dynamic> json) => Model(
        message: Map.from(json["message"]).map((k, v) => MapEntry<String, List<String>>(k, List<String>.from(v.map((x) => x)))),
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "message": Map.from(message).map((k, v) => MapEntry<String, dynamic>(k, List<dynamic>.from(v.map((x) => x)))),
        "status": status,
    };
}
