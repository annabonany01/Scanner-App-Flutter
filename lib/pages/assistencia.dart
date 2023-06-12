import 'package:flutter/material.dart';
import 'package:qr_scanner/models/student.dart';
import 'package:qr_scanner/models/student_list.dart';

class Assistencia extends StatefulWidget {
  const Assistencia({super.key});

  @override
  _AssistenciaState createState() => _AssistenciaState();
}

class _AssistenciaState extends State<Assistencia> {
  final StudentList studentList = StudentList();
  List<String> assistencies = [
    'A classe',
    'Arriba tard',
    'Justificat',
    'Pendent'
  ];
  String dropdownvalue = 'A classe';

  @override
  Widget build(BuildContext context) {
    List<Student> students = studentList.students;
    students.sort((a, b) => a.name.compareTo(b.name));
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemCount: students.length,
            itemBuilder: (BuildContext context, int index) {
              final Student student = students[index];
              return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      student.name,
                      style: const TextStyle(fontSize: 17),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.black54,
                          width: 1,
                        ),
                        color: Colors.white54
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: DropdownButton(
                          dropdownColor: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                          value: (student.assistencia != null)
                              ? student.assistencia
                              : dropdownvalue,
                          items: assistencies.map((item) {
                            return DropdownMenuItem(
                              value: item,
                              child: Text(item),
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            setState(() {
                              student.assistencia = newValue;
                            });
                          },
                          underline: Container(
                            height: 0,
                            color: Colors.transparent,
                          ),
                          selectedItemBuilder: (BuildContext context) {
                            return assistencies.map<Widget>((String item) {
                              Widget icon;
                              if (item == 'A classe') {
                                icon =
                                    const Icon(Icons.check_circle, color: Colors.green);
                              } else if (item == 'Arriba tard') {
                                icon = const Icon(Icons.error, color: Colors.red);
                              } else if (item == 'Justificat') {
                                icon = const Icon(Icons.recommend_rounded,
                                    color: Colors.orange);
                              } else {
                                icon =
                                    const Icon(Icons.help_rounded, color: Colors.grey);
                              }
                              return Row(
                                children: [
                                  icon,
                                  const SizedBox(width: 5),
                                  Text(item),
                                ],
                              );
                            }).toList();
                          },
                        ),
                      ),
                    ),
                  ]);
            },
            separatorBuilder: (context, index) {
              return const Divider(
                color: Color.fromARGB(255, 91, 176, 146),
                thickness: 1,
              );
            },
          ),
        ),
      ),
    );
  }
}
