import 'package:flutter/material.dart';
import 'package:onthi_gplx_pro/core/theme/app_colors.dart';

class QuestionCategory extends StatelessWidget {
  final bool expanded;
  final int currentIndex;
  const QuestionCategory({
    super.key,
    this.expanded = true,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    final int itemCount = 20;
    final double itemHeight = 40;
    final double itemPadding = 6;
    final int columnNum = 6;
    final int rowNum = (itemCount / columnNum).ceil();
    final double totalHeight =
        (itemHeight * rowNum) + (itemPadding) * (rowNum - 1) + 16;
    return AnimatedSize(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      child: !expanded
          ? SizedBox.shrink()
          : Container(
              padding: const .only(top: 8, left: 8, right: 8, bottom: 8),
              decoration: BoxDecoration(
                color: AppColors.neutralColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
              ),
              width: double.maxFinite,
              height: totalHeight,
              child: Center(
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisExtent: itemHeight,
                    crossAxisCount: columnNum,
                    childAspectRatio: 1,
                    mainAxisSpacing: itemPadding,
                    crossAxisSpacing: itemPadding,
                  ),
                  itemCount: itemCount,
                  itemBuilder: (context, index) => Material(
                    shape: RoundedRectangleBorder(
                      borderRadius: .circular(currentIndex == index ? 8 : 4),
                      side: BorderSide(
                        width: 2,
                        color: currentIndex == index
                            ? AppColors.primaryColor
                            : Colors.transparent,
                      ),
                    ),
                    color: AppColors.backgroundColor,
                    child: InkWell(
                      borderRadius: .circular(currentIndex == index ? 8 : 4),
                      onTap: () {
                        print('Tap on ${index + 1}');
                      },
                      child: Center(child: Text('${index + 1}')),
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
