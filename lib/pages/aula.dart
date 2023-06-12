import 'package:flutter/material.dart';
import 'package:flutter_initicon/flutter_initicon.dart';
import 'package:qr_scanner/pages/student_info.dart';
import '../models/student.dart';
import '../models/student_list.dart';

class Aula extends StatelessWidget {
  final StudentList studentList = StudentList();

  Aula({super.key});

  @override
  Widget build(BuildContext context) {
    List<Student> students = studentList.students;
    students.sort((a, b) => a.name.compareTo(b.name));
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: GridView.count(
          physics: const BouncingScrollPhysics(),
          crossAxisCount: 3,
          children: List.generate(students.length, (index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => StudentInfo(
                          name: students[index].name,
                          id: students[index].id,
                          color: students[index].color,
                        )));
              },
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Initicon(
                        text: students[index].name,
                        backgroundColor: students[index].color,
                        size: 40,
                      ),
                      SizedBox(height: 10),
                      Text(
                        students[index].name,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
