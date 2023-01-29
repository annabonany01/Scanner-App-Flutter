// To parse this JSON data, do
//
//     final DocElement = DocElementFromMap(jsonString);

import 'dart:convert';
import 'dart:io';

class DocElement {
  DocElement({
    required this.check,
    required this.mark,
    required this.image,
    required this.name,
    this.id,
  });

  bool check;
  int mark;
  File image;
  String name;
  String? id;
  

  factory DocElement.fromJson(String str) =>
      DocElement.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DocElement.fromMap(Map<String, dynamic> json) => DocElement(
    check: json["check"],
    mark: json["mark"],
    image: json["image"],
    name: json["name"],
    id: json["id"]
  );

  Map<String, dynamic> toMap() =>
      {"check": check, "mark": mark, "id": id, "image": image, "name": name};
}
