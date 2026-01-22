import 'package:flutter/material.dart';
import 'package:onthi_gplx_pro/core/theme/app_colors.dart';

class QuestionCategory extends StatelessWidget {
  final bool expanded;
  final int current;
  final int total;
  final double itemPadding;
  final double itemHeight;
  final int columnNums;
  final ValueChanged<int>? onSelectedItem;
  const QuestionCategory({
    super.key,
    this.expanded = true,
    required this.current,
    required this.total,
    this.itemPadding = 6,
    this.itemHeight = 40,
    this.columnNums = 6,
    this.onSelectedItem,
  });

  @override
  Widget build(BuildContext context) {
    final int rowNums = (total / columnNums).ceil();
    final double totalHeight =
        (itemHeight * rowNums) + (itemPadding) * (rowNums - 1) + 16;
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
                    crossAxisCount: columnNums,
                    childAspectRatio: 1,
                    mainAxisSpacing: itemPadding,
                    crossAxisSpacing: itemPadding,
                  ),
                  itemCount: total,
                  itemBuilder: (context, index) => Material(
                    shape: RoundedRectangleBorder(
                      borderRadius: .circular(current == index ? 8 : 4),
                      side: BorderSide(
                        width: 2,
                        color: current == index
                            ? AppColors.primaryColor
                            : Colors.transparent,
                      ),
                    ),
                    color: AppColors.backgroundColor,
                    child: InkWell(
                      borderRadius: .circular(current == index ? 8 : 4),
                      onTap: () {
                        onSelectedItem ?? onSelectedItem!(index);
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
