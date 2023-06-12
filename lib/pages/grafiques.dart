import 'package:flutter/material.dart';
import 'package:qr_scanner/widgets/PDF_generator.dart';
import 'package:screenshot/screenshot.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Grafiques extends StatefulWidget {
  final String name;

  const Grafiques({super.key, required this.name});
  @override
  State<Grafiques> createState() => _GrafiquesState();
}

class _GrafiquesState extends State<Grafiques> {
  final screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    final List<ChartData> data1 = [
      ChartData(1, 3),
      ChartData(2, 2),
      ChartData(3, 6),
      ChartData(4, 8),
    ];
    final List<ChartData> data2 = [
      ChartData(1, 2),
      ChartData(2, 4),
      ChartData(3, 5),
      ChartData(4, 3),
    ];
    final List<ChartData> data3 = [
      ChartData(1, 5),
      ChartData(2, 6),
      ChartData(3, 8),
      ChartData(4, 9),
    ];
    final List<ChartData> data4 = [
      ChartData(1, 6),
      ChartData(2, 9),
      ChartData(3, 4),
      ChartData(4, 7),
    ];

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        title: const Text('Gràfiques'),
        backgroundColor: const Color.fromARGB(255, 147, 203, 183),
        centerTitle: true,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            );
          },
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Screenshot(
              controller: screenshotController,
              child: Container(
                height: 500,
                child: SfCartesianChart(
                  primaryXAxis: CategoryAxis(
                    title: AxisTitle(
                        text: 'Documents',
                        textStyle: const TextStyle(
                            fontSize: 15, fontStyle: FontStyle.italic)),
                    labelPlacement: LabelPlacement.onTicks,
                  ),
                  primaryYAxis: NumericAxis(
                      title: AxisTitle(
                          text: 'Qualificacions',
                          textStyle: const TextStyle(
                              fontSize: 15, fontStyle: FontStyle.italic)),
                      maximum: 10),
                  legend: Legend(
                      isVisible: true,
                      title: LegendTitle(
                          text: 'Competències',
                          textStyle: const TextStyle(
                              fontSize: 13, fontWeight: FontWeight.bold),
                          alignment: ChartAlignment.near),
                      position: LegendPosition.bottom,
                      overflowMode: LegendItemOverflowMode.wrap,
                      height: '100%'),
                  series: <ChartSeries>[
                    LineSeries<ChartData, int>(
                      name: 'Digital',
                      dataSource: data1,
                      markerSettings:
                          const MarkerSettings(isVisible: true, width: 5, height: 5),
                      xValueMapper: (ChartData point, _) => point.x,
                      yValueMapper: (ChartData point, _) => point.y,
                    ),
                    LineSeries<ChartData, int>(
                      name: 'Matemàtica i en ciència, tecnologia i enginyeria',
                      dataSource: data2,
                      markerSettings:
                          const MarkerSettings(isVisible: true, width: 5, height: 5),
                      xValueMapper: (ChartData point, _) => point.x,
                      yValueMapper: (ChartData point, _) => point.y,
                    ),
                    LineSeries<ChartData, int>(
                      name: 'Personal, social i d\'aprendre a aprendre',
                      dataSource: data3,
                      markerSettings:
                          const MarkerSettings(isVisible: true, width: 5, height: 5),
                      xValueMapper: (ChartData point, _) => point.x,
                      yValueMapper: (ChartData point, _) => point.y,
                    ),
                    LineSeries<ChartData, int>(
                      name: 'Comunicació lingüística',
                      dataSource: data4,
                      markerSettings:
                          const MarkerSettings(isVisible: true, width: 5, height: 5),
                      xValueMapper: (ChartData point, _) => point.x,
                      yValueMapper: (ChartData point, _) => point.y,
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 40,
              child: ElevatedButton(
                onPressed: () {
                  screenshotController
                      .capture()
                      .then((capturedImage) async {
                    PdfGenerator.generatePDF(context, capturedImage!, widget.name);
                  }).catchError((onError) {
                    print(onError);
                  });
                },
                style: ElevatedButton.styleFrom(
                  textStyle:
                      const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  backgroundColor: Colors.purple[300],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                ),
                child: const Text('Desar com a PDF'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ChartData {
  final int x;
  final int y;

  ChartData(this.x, this.y);
}
