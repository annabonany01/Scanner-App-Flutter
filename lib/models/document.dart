import 'dart:convert';
import 'dart:io';
import 'package:qr_scanner/models/student.dart';

class Document {
    bool check;
    String? id;
    String? image;
    int mark;
    String? student;

    Document({
        required this.check,
        this.id,
        this.image,
        required this.mark,
        this.student,
    });

    factory Document.fromJson(String str) => Document.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Document.fromMap(Map<String, dynamic> json) => Document(
        check: json["check"],
        //id: json["id"],
        image: json["image"],
        mark: json["mark"],
        student: json["student"],
    );

    Map<String, dynamic> toMap() => {
        "check": check,
        //"id": id,
        "image": image,
        "mark": mark,
        "student": student,
    };

    Document copy() => Document(
        check: check,
        id: id,
        image: image,
        mark: mark,
        student: student,
    );
}
