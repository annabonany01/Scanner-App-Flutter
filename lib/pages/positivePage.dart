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
      padding: const EdgeInsets.all(20),
      physics: const BouncingScrollPhysics(),
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
            const SizedBox(height: 8),
            Text(
              option['title'],
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
