import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:onthi_gplx_pro/core/theme/app_colors.dart';

class StyledLineChart extends StatelessWidget {
  const StyledLineChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: .all(color: AppColors.primaryColor.withAlpha(50)),
        borderRadius: .circular(12),
        color: AppColors.neutralColor.withAlpha(100),
      ),
      child: Padding(
        padding: .all(12),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: .spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'Hoạt động tuần này',
                    style: TextStyle(fontSize: 18, fontWeight: .w700),
                    maxLines: 1,
                    overflow: .ellipsis,
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: .centerRight,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: AppColors.accentColor.withAlpha(30),
                        borderRadius: .circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8.0,
                          vertical: 2,
                        ),
                        child: Text(
                          '+12% so với tuần trước',
                          style: TextStyle(color: AppColors.accentColor),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0, right: 8),
              child: SizedBox(
                width: .maxFinite,
                height: 250,
                child: LineChart(
                  LineChartData(
                    lineBarsData: [
                      LineChartBarData(
                        spots: [
                          FlSpot(0, 0),
                          FlSpot(1, 10),
                          FlSpot(2, 24),
                          FlSpot(3, 6),
                          FlSpot(4, 5),
                          FlSpot(5, 0),
                          FlSpot(6, 400),
                        ],
                        isCurved: true,
                        curveSmoothness: 0.36,
                        gradient: LinearGradient(
                          colors: [
                            AppColors.primaryColor,
                            AppColors.accentColor,
                          ],
                        ),
                        belowBarData: BarAreaData(
                          show: true,
                          gradient: LinearGradient(
                            colors: [
                              AppColors.primaryColor.withAlpha(50),
                              AppColors.accentColor.withAlpha(50),
                            ],
                          ),
                        ),
                        dotData: FlDotData(show: false),
                        showingIndicators: [1],
                      ),
                    ],
                    titlesData: FlTitlesData(
                      topTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      rightTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          reservedSize: 34,
                          showTitles: true,
                        ),
                      ),
                      bottomTitles: AxisTitles(
                        drawBelowEverything: false,
                        sideTitles: SideTitles(
                          reservedSize: 24,
                          showTitles: true,
                          getTitlesWidget: (value, meta) {
                            String getDay() {
                              return switch (value) {
                                0 => 'T2',
                                1 => 'T3',
                                2 => 'T4',
                                3 => 'T5',
                                4 => 'T6',
                                5 => 'T7',
                                6 => 'CN',
                                double() => '',
                              };
                            }

                            return SideTitleWidget(
                              meta: meta,

                              child: Text(getDay()),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
