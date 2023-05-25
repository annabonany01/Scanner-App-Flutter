import 'package:flutter/material.dart';
import 'package:flutter_initicon/flutter_initicon.dart';

class StudentInfo extends StatefulWidget {
  final String name;
  final int id;
  final Color color;

  StudentInfo({required this.name, required this.id, required this.color});

  @override
  State<StudentInfo> createState() => _StudentInfoState();
}

class _StudentInfoState extends State<StudentInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(widget.name),
            Initicon(
              text: widget.name,
              backgroundColor: widget.color,
              size: 35,
            ),
          ],
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            _CorrectionButton(),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _ObsButton(),
                SizedBox(width: 20),
                _AssistenciaButton(),
              ],
            ),
            SizedBox(height: 30),
            _GraficaButton()
          ]),
        ),
      ),
    );
  }
}

class _GraficaButton extends StatelessWidget {
  const _GraficaButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushReplacementNamed(context, 'obs');
      },
      child: Container(
        width: 300,
        height: 100,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(
                Icons.bar_chart_rounded,
                size: 40,
              ),
              Text('Gràfiques', style: TextStyle(fontSize: 15)),
            ],
          ),
        ),
      ),
    );
  }
}

class _AssistenciaButton extends StatelessWidget {
  const _AssistenciaButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushReplacementNamed(context, 'obs');
      },
      child: Container(
        width: 130,
        height: 130,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(
                Icons.schedule_rounded,
                size: 40,
              ),
              Text('Assistència', style: TextStyle(fontSize: 15)),
            ],
          ),
        ),
      ),
    );
  }
}

class _ObsButton extends StatelessWidget {
  const _ObsButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushReplacementNamed(context, 'obs');
      },
      child: Container(
        width: 130,
        height: 130,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(
                Icons.note_alt_outlined,
                size: 40,
              ),
              Text('Observacions', style: TextStyle(fontSize: 15)),
            ],
          ),
        ),
      ),
    );
  }
}

class _CorrectionButton extends StatelessWidget {
  const _CorrectionButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushReplacementNamed(context, 'correccio');
      },
      child: Container(
        width: 300,
        height: 100,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(
                Icons.check_circle_outline_rounded,
                size: 40,
              ),
              Text('Correcció', style: TextStyle(fontSize: 15)),
            ],
          ),
        ),
      ),
    );
  }
}
