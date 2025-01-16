import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ChartContainer extends StatelessWidget {
  final double? employeesNumber;
  final double? taskNumber;
  final double? taskDoneNumber;
  final double? otherNumber;

  const ChartContainer({
    super.key,
    this.employeesNumber,
    this.taskNumber,
    this.taskDoneNumber,
    this.otherNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.4,
        color: Colors.transparent,
        padding: const EdgeInsets.all(16.0),
        child: BarChart(
          BarChartData(
            gridData: const FlGridData(show: false),
            titlesData: const FlTitlesData(show: false),
            borderData: FlBorderData(show: false),
            barGroups: [
              BarChartGroupData(
                x: 0,
                barRods: [
                  BarChartRodData(
                    toY: employeesNumber ?? 0.1,
                    color: Colors.blue,
                    width: 16,
                  ),
                ],
              ),
              BarChartGroupData(
                x: 1,
                barRods: [
                  BarChartRodData(
                    toY: taskNumber ?? 0.1,
                    color: Colors.green,
                    width: 16,
                  ),
                ],
              ),
              BarChartGroupData(
                x: 2,
                barRods: [
                  BarChartRodData(
                      toY: taskDoneNumber ?? 0.1,
                      color: Colors.orange,
                      width: 16),
                ],
              ),
              BarChartGroupData(
                x: 3,
                barRods: [
                  BarChartRodData(
                    toY: otherNumber ?? 0.1,
                    color: Colors.red,
                    width: 16,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Flexible(
//   child: Container(
//
//     height: MediaQuery.of(context).size.height * 0.4,
//     color: Colors.transparent,
//     padding: const EdgeInsets.all(16.0),
//     child: LineChart(
//       LineChartData(
//         gridData: FlGridData(show: true),
//         // Show grid lines
//         titlesData: const FlTitlesData(show: false),
//         // Show axis titles
//         borderData: FlBorderData(show: false),
//         // Show border
//         minX: 0,
//         maxX: 7,
//         minY: 0,
//         maxY: 6,
//         lineBarsData: [
//           LineChartBarData(
//             spots: [
//               FlSpot(0, 1),
//               FlSpot(1, 2),
//               FlSpot(2, 1.5),
//               FlSpot(3, 3.2),
//               FlSpot(4, 2.8),
//               FlSpot(5, 4),
//               FlSpot(6, 3.5),
//             ],
//             isCurved: true,
//             color: Colors.blue,
//             barWidth: 3,
//             belowBarData: BarAreaData(
//               show: true,
//               color: Colors.blue.withOpacity(0.3),
//             ),
//             dotData: FlDotData(show: false),
//           ),
//         ],
//       ),
//     ),
//   ),
// ),
