import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nilelon/core/resources/color_manager.dart';
import 'package:nilelon/features/store_flow/analytics/presentation/cubit/analytics_cubit.dart';

class LineChartSample extends StatefulWidget {
  const LineChartSample({
    super.key,
  });
  @override
  State<LineChartSample> createState() => _LineChartSampleState();
}

class _LineChartSampleState extends State<LineChartSample> {
  late List<Color> gradientColors;
  @override
  Widget build(BuildContext context) {
    gradientColors = ColorManager.gradientColors2;
    return SizedBox(
      height: 90.h,
      child: AspectRatio(
        aspectRatio: 3.3,
        child: LineChart(
          mainData(),
        ),
      ),
    );
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: const FlGridData(
        show: false,
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
            // interval: 1,
            reservedSize: 22,
          ),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1, // Adjust interval as needed
            getTitlesWidget: (value, meta) {
              // Convert x value (index) to date or label
              final index = value.toInt();
              if (index >= 0 &&
                  index < AnalyticsCubit.get(context).chart.length) {
                final date = DateTime.parse(
                    AnalyticsCubit.get(context).chart[index]['date']);
                return Text(
                  '${date.month}/${date.day}', // Format: MM/DD
                  style: const TextStyle(fontSize: 10),
                );
              }
              return const Text('');
            },
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1000, // Adjust interval based on your data range
            getTitlesWidget: (value, meta) {
              return Text(
                value.toInt().toString(), // Format the income as an integer
                style: const TextStyle(fontSize: 10),
                textAlign: TextAlign.center,
              );
            },
          ),
        ),
      ),
      borderData: FlBorderData(
        show: false,
        // border: Border.all(color: AppStyles.primaryB),
      ),
      minX: 0,
      maxX: AnalyticsCubit.get(context).chart.length.toDouble(),
      minY: 0,
      maxY: AnalyticsCubit.get(context).maxValue.toDouble(),
      lineBarsData: [
        LineChartBarData(
          spots: AnalyticsCubit.get(context).chart.isEmpty
              ? const [
                  FlSpot(1, 0),
                  FlSpot(2, 0),
                  FlSpot(3, 0),
                  FlSpot(4, 0),
                  FlSpot(5, 0),
                  FlSpot(6, 0),
                  FlSpot(7, 0),
                  FlSpot(8, 0),
                  FlSpot(9, 0),
                  FlSpot(10, 0),
                ]
              : AnalyticsCubit.get(context).chart.asMap().entries.map((entry) {
                  final index = entry.key.toDouble();
                  final income = entry.value['totalIncome'] as double;
                  return FlSpot(index, income);
                }).toList(),

          isCurved: true,
          gradient: LinearGradient(
            colors: gradientColors,
          ),
          color: ColorManager.primaryO, //AppStyles.primaryB6,
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: true,
          ),
          belowBarData: BarAreaData(
            show: true,
            cutOffY: 1.8,
            applyCutOffY: true,
            gradient: LinearGradient(
              colors: gradientColors
                  .map((color) => color.withOpacity(0.1))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}
