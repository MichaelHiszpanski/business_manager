import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ChartContainer extends StatelessWidget {
  const ChartContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return  Flexible(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.4,
        color: Colors.transparent,
        padding: const EdgeInsets.all(16.0),
        child: BarChart(
          BarChartData(
            gridData: FlGridData(show: false),
            // Disable grid lines
            titlesData: FlTitlesData(show: false),
            // Disable axis titles
            borderData: FlBorderData(show: false),
            // Disable border
            barGroups: [
              BarChartGroupData(
                x: 0,
                barRods: [
                  BarChartRodData(
                      toY: 8, color: Colors.blue, width: 16),
                ],
              ),
              BarChartGroupData(
                x: 1,
                barRods: [
                  BarChartRodData(
                      toY: 10, color: Colors.green, width: 16),
                ],
              ),
              BarChartGroupData(
                x: 2,
                barRods: [
                  BarChartRodData(
                      toY: 5, color: Colors.orange, width: 16),
                ],
              ),
              BarChartGroupData(
                x: 3,
                barRods: [
                  BarChartRodData(
                      toY: 12, color: Colors.red, width: 16),
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
