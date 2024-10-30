import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nilelon/core/resources/color_manager.dart';
import 'package:nilelon/features/store_flow/analytics/domain/model/analytics_response_model.dart';
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
      titlesData: const FlTitlesData(
        show: false,
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
            // reservedSize: 30,
            // interval: 1,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
            // interval: 1,
            // reservedSize: 42,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: false,
        // border: Border.all(color: AppStyles.primaryB),
      ),
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: AnalyticsCubit.get(context).chart.isEmpty ||
                  AnalyticsCubit.get(context).chart.every((e) => e == 0)
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
              : AnalyticsCubit.get(context)
                  .chart
                  .map((e) => FlSpot(e.toDouble(), e.toDouble()))
                  .toList(),

          isCurved: true,
          gradient: LinearGradient(
            colors: gradientColors,
          ),
          color: ColorManager.primaryO, //AppStyles.primaryB6,
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
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
