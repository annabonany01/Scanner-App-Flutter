import 'dart:convert';

class Document {
    bool check;
    String? id;
    String? image;
    String? mark;
    String? student;
    String? competencia;

    Document({
        required this.check,
        this.id,
        this.image,
        this.mark,
        this.student,
        this.competencia = 'No definida'
    });

    factory Document.fromJson(String str) => Document.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Document.fromMap(Map<String, dynamic> json) => Document(
        check: json["check"],
        id: json["id"],
        image: json["image"],
        mark: json["mark"],
        student: json["student"],
        competencia: json["competencia"]
    );

    Map<String, dynamic> toMap() => {
        "check": check,
        "id": id,
        "image": image,
        "mark": mark,
        "student": student,
        "competencia": competencia
    };

    Document copy() => Document(
        check: check,
        id: id,
        image: image,
        mark: mark,
        student: student,
        competencia: competencia
    );
}
