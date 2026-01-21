import 'package:flutter/material.dart';
import 'package:onthi_gplx_pro/core/theme/app_colors.dart';
import 'package:onthi_gplx_pro/core/widgets/section_header.dart';

class StyledTimeline extends StatelessWidget {
  const StyledTimeline({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> timelineItems = [
      {'title': 'Bắt đầu học', 'subTitle': '20/01/2026'},
      {'title': 'Hoàn thành 100 câu đầu tiên', 'subTitle': '24/01/2026'},
      {'title': 'Đạt chuỗi 7 ngày liên lục', 'subTitle': '27/01/2026'},
      {'title': 'Nhận bằng lái', 'subTitle': 'Mục tiêu'},
    ];

    Widget timelineItemWidget({
      required int index,
      required String text,
      required String subText,
      double size = 80,
    }) {
      return Stack(
        children: [
          // L I N E
          Positioned(
            left: 4,
            child: SizedBox(
              height: size,
              width: 1,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: AppColors.secondaryColor.withAlpha(150),
                ),
              ),
            ),
          ),

          // D O T
          Positioned(
            top: 8,
            child: SizedBox(
              height: 18,
              width: 18,
              child: Center(
                child: Container(
                  clipBehavior: .antiAlias,
                  decoration: BoxDecoration(
                    border: .all(
                      width: index >= timelineItems.length - 2 ? 3 : 0,
                      color: index == timelineItems.length - 1
                          ? AppColors.primaryColor.withAlpha(100)
                          : index == timelineItems.length - 2
                          ? AppColors.secondaryColor
                          : AppColors.primaryColor,
                    ),
                    color: index == timelineItems.length - 1
                        ? AppColors.textDisableColor
                        : index == timelineItems.length - 2
                        ? AppColors.accentColor
                        : AppColors.primaryColor,
                    shape: .circle,
                  ),
                ),
              ),
            ),
          ),

          Padding(
            padding: const .symmetric(horizontal: 24),
            child: SizedBox(
              height: size,
              width: double.maxFinite,
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  SizedBox(height: 4),
                  Text(
                    text,
                    maxLines: 1,
                    overflow: .ellipsis,
                    style: TextStyle(fontSize: 18, fontWeight: .bold),
                  ),
                  Text(
                    subText,
                    style: TextStyle(color: AppColors.textSecondaryColor),
                    maxLines: 2,
                    overflow: .ellipsis,
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    }

    return Container(
      child: Column(
        children: [
          SectionHeader(title: 'Lộ trình', padding: .zero),
          SizedBox(height: 16),
          ...List.generate(
            timelineItems.length,
            (index) => timelineItemWidget(
              index: index,
              text: timelineItems[index]['title']!,
              subText: timelineItems[index]['subTitle']!,
            ),
          ),
        ],
      ),
    );
  }
}
