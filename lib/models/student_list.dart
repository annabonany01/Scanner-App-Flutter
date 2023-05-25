import 'package:qr_scanner/models/student.dart';
import 'package:random_color/random_color.dart';

class StudentList {
  List<Student> students = [
    Student(name: 'Joan', id: 1836286826, color: RandomColor().randomColor()),
    Student(name: 'Sara', id: 1836284628, color: RandomColor().randomColor()),
    Student(name: 'Pau', id: 232874982, color: RandomColor().randomColor()),
    Student(name: 'Laura', id: 15344331, color: RandomColor().randomColor()),
    Student(name: 'Àlex', id: 2787286852, color: RandomColor().randomColor()),
    Student(name: 'Claudia', id: 572428752, color: RandomColor().randomColor()),
    Student(name: 'Marc', id: 2786824275, color: RandomColor().randomColor()),
    Student(name: 'Maria', id: 217587175, color: RandomColor().randomColor()),
    Student(name: 'Anna', id: 1758675586, color: RandomColor().randomColor()),
    Student(name: 'Nora', id: 7585868666, color: RandomColor().randomColor()),
    Student(name: 'Roger', id: 4276868638, color: RandomColor().randomColor()),
    Student(name: 'Bruna', id: 1475789972, color: RandomColor().randomColor()),
    Student(name: 'Pere', id: 2563427688, color: RandomColor().randomColor()),
    Student(name: 'Blanca', id: 7745242423, color: RandomColor().randomColor()),
    Student(name: 'Andrea', id: 784563254, color: RandomColor().randomColor()),
    Student(name: 'Laura', id: 6323246656, color: RandomColor().randomColor()),
    Student(name: 'Carla', id: 1234567890, color: RandomColor().randomColor()),
    Student(name: 'Emma', id: 9876543210, color: RandomColor().randomColor()),
    Student(name: 'Daniel', id: 2468135790, color: RandomColor().randomColor()),
    Student(name: 'Sofia', id: 1357924680, color: RandomColor().randomColor()),
    Student(name: 'Liam', id: 3692581470, color: RandomColor().randomColor()),
    Student(name: 'Olivia', id: 5701846239, color: RandomColor().randomColor()),
    Student(name: 'Adam', id: 8246059317, color: RandomColor().randomColor()),
    Student(name: 'Natalia', id: 6950381274, color: RandomColor().randomColor()),
    Student(name: 'Mia', id: 3852794160, color: RandomColor().randomColor()),
    Student(name: 'Oriol', id: 5876139402, color: RandomColor().randomColor()),
    Student(name: 'Isabel', id: 7819403265, color: RandomColor().randomColor()),
  ];

  // Singleton pattern: instancia única de StudentManager
  static final StudentList _instance = StudentList._internal();
  factory StudentList() => _instance;
  
  StudentList._internal();

  Student? findStudentByDocumentIdentifier(String identifier) {
    for (var student in students) {
      if (student.id == identifier) {
        return student;
      }
    }
    return null;
  }

  void addStudent(Student student) {
    students.add(student);
  }
}