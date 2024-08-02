import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nilelon/resources/color_manager.dart';

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
        // drawVerticalLine: true,
        // getDrawingHorizontalLine: (value) {
        //   return const FlLine(
        //     color: ColorManager.primaryB,
        //     strokeWidth: 1,
        //   );
        // },
        // getDrawingVerticalLine: (value) {
        //   return const FlLine(
        //     color: ColorManager.primaryB,
        //     strokeWidth: 1,
        //   );
        // },
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
          spots: const [
            FlSpot(0, 2),
            FlSpot(2, 2),
            FlSpot(4.2, 6),
            FlSpot(6.8, 3.1),
            FlSpot(8, 4),
            FlSpot(9, 3),
            FlSpot(11, 5),
          ],
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
