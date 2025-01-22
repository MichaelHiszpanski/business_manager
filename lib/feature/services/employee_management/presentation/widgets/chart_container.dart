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
            titlesData: FlTitlesData(
              leftTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              topTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              rightTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, meta) {
                    String text = '';
                    switch (value.toInt()) {
                      case 0:
                        text =
                            'E ${employeesNumber?.toStringAsFixed(0)}' ?? '0.1';
                        break;
                      case 1:
                        text = "T ${taskNumber?.toStringAsFixed(0)}" ?? '0.1';
                        break;
                      case 2:
                        text = "D ${taskDoneNumber?.toStringAsFixed(0)}" ?? '0.1';
                        break;
                      case 3:
                        text = "N ${otherNumber?.toStringAsFixed(0)}" ?? '0.1';
                        break;
                    }
                    return Text(
                      text,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                      ),
                    );
                  },
                ),
              ),
            ),
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
                    color:Colors.orange,
                    width: 16,
                  ),
                ],
              ),
              BarChartGroupData(
                x: 2,
                barRods: [
                  BarChartRodData(
                      toY: taskDoneNumber ?? 0.1,
                      color:  Colors.green,
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
