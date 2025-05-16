import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:roamsavvy/featured/home/models/food_points_data_model.dart';

class ReviewInsightsChart extends StatefulWidget {
  final ReviewInsights insights;

  const ReviewInsightsChart({super.key, required this.insights});

  @override
  State<ReviewInsightsChart> createState() => _ReviewInsightsChartState();
}

class _ReviewInsightsChartState extends State<ReviewInsightsChart> {
  int? touchedIndex;

  @override
  Widget build(BuildContext context) {
    final colors = [Colors.green, Colors.orange, Colors.red, Colors.blue, Colors.purple];
    final labels = widget.insights.insights.keys.toList();
    final values = widget.insights.insights.values.toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Review Insights',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 180,
          child: PieChart(
            PieChartData(
              pieTouchData: PieTouchData(
                touchCallback: (event, response) {
                  setState(() {
                    if (!event.isInterestedForInteractions || response == null || response.touchedSection == null) {
                      touchedIndex = null;
                      return;
                    }
                    touchedIndex = response.touchedSection!.touchedSectionIndex;
                  });
                },
              ),
              sections: List.generate(widget.insights.insights.length, (i) {
                final isSelected = touchedIndex == i;
                return PieChartSectionData(
                  color: colors[i % colors.length],
                  value: values[i].toDouble(),
                  title: '${values[i]}%',
                  radius: isSelected ? 65 : 50,
                  titleStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                );
              }),
              sectionsSpace: 2,
              centerSpaceRadius: 30,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(widget.insights.insights.length, (i) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  Container(width: 12, height: 12, color: colors[i % colors.length]),
                  const SizedBox(width: 4),
                  Text(labels[i]),
                ],
              ),
            );
          }),
        ),
      ],
    );
  }
}