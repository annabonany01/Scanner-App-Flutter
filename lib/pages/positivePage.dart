import 'package:flutter/material.dart';

class PositivePage extends StatelessWidget {
  PositivePage({
    Key? key,
  }) : super(key: key);

  final List<Map<String, dynamic>> _positiveOptions = [
    {'icon': Icons.thumb_up, 'title': 'Actitud'},
    {'icon': Icons.done_outline_rounded, 'title': 'Participació activa'},
    {'icon': Icons.groups_2_rounded, 'title': 'Treball en equip'},
    {'icon': Icons.lightbulb_outline, 'title': 'Creativitat'},
    {'icon': Icons.assignment_turned_in, 'title': 'Responsabilitat'},
    {'icon': Icons.moving_rounded, 'title': 'Esforç'},

  ];

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      padding: EdgeInsets.all(20),
      physics: BouncingScrollPhysics(),
      mainAxisSpacing: 20,
      crossAxisSpacing: 20,
      children: _positiveOptions
          .map((option) => _optionCard(context, option))
          .toList(),
    );
  }

  Widget _optionCard(BuildContext context, Map<String, dynamic> option) {
    return InkWell(
      onTap: () => {},
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(70),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(option['icon'], size: 30, color: Colors.green,),
            SizedBox(height: 8),
            Text(
              option['title'],
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // void _showNotesDialog(BuildContext context, String option) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text('Añadir nota'),
  //         content: TextField(
  //           controller: notesController,
  //           decoration: InputDecoration(
  //             hintText: 'Añade una nota',
  //           ),
  //         ),
  //         actions: [
  //           TextButton(
  //             onPressed: () => Navigator.of(context).pop(),
  //             child: Text('CANCELAR'),
  //           ),
  //           TextButton(
  //             onPressed: () {
  //               // Aquí se podría guardar la nota en el perfil del alumno
  //               notesController.clear();
  //               Navigator.of(context).pop();
  //             },
  //             child: Text('GUARDAR'),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }
}
