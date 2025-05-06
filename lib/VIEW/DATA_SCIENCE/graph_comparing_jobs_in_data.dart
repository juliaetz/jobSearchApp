import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class GraphJobsInData extends StatelessWidget{
  final Map<String, double> _data;
  const GraphJobsInData({super.key, required Map<String, double> data}) : _data = data;

  List<BarChartGroupData> createBarChartGroups(Map<String, double> data) {
    List<BarChartGroupData> barGroups = [];
    int x = 0;
    int numberOfBars = 0;
    data.forEach((key, value) {
      if (numberOfBars < 6) {
      barGroups.add(
        BarChartGroupData(
          x: x,
          barRods: [
            BarChartRodData(
              toY: value,
              color: Colors.green,
              width: 40,
              borderRadius: BorderRadius.circular(4),
            ),
          ],
        ),
      );
      x++;
      numberOfBars++;
      }
    });
    return barGroups;
  }

  @override
  Widget build(BuildContext context) {
    List<BarChartGroupData> barGroups = createBarChartGroups(_data);
    List<String> keys = _data.keys.toList();
    return Padding(
      padding: const EdgeInsets.all(10),
      child: BarChart(
        BarChartData(
          barGroups: barGroups,
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 70,
                getTitlesWidget: (double value, TitleMeta meta) {
                  String originalText = keys[value.toInt()];
                  List<String> words = originalText.split(' ');
                  List<Widget> textWidgets = [];
                  for (String word in words) {
                    textWidgets.add(Text(
                      word,
                      style: TextStyle(fontSize: 10),
                      textAlign: TextAlign.center,
                    ));
                  }
                  return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: textWidgets
                    );
                },
              ),
            ),
            rightTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: false
              ),
            ),
            topTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: false
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 45,
                maxIncluded: false,
              ),
            ),
        ),
      ),
      ),
    );
  }
}