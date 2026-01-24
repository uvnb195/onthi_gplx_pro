import 'package:flutter/material.dart';
import 'package:onthi_gplx_pro/core/theme/app_colors.dart';

class QuestionCategory extends StatelessWidget {
  final int current;
  final int total;
  final double itemPadding;
  final double itemHeight;
  final int columnNums;
  final ValueChanged<int>? onSelectedItem;
  final ValueChanged<Size>? onReady;
  const QuestionCategory({
    super.key,
    required this.current,
    required this.total,
    this.itemPadding = 6,
    this.itemHeight = 40,
    this.columnNums = 6,
    this.onSelectedItem,
    this.onReady,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    final int rowNums = (total / columnNums).ceil();
    final bool isTooManyItem =
        (itemHeight * rowNums) + (itemPadding) * (rowNums - 1) + 18 >
        screenHeight - kToolbarHeight - kBottomNavigationBarHeight;
    final double finalHeight = isTooManyItem
        ? 500
        : (itemHeight * rowNums) + (itemPadding) * (rowNums - 1) + 18;

    final ScrollPhysics physics = isTooManyItem
        ? const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics())
        : const NeverScrollableScrollPhysics();

    final GlobalKey widgetKey = GlobalKey();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widgetKey.currentContext != null) {
        final RenderBox renderBox =
            widgetKey.currentContext!.findRenderObject() as RenderBox;
        final size = renderBox.size;
        if (onReady != null) {
          onReady!(size);
        }
      }
    });

    return Container(
      key: widgetKey,
      padding: const .all(8),
      decoration: BoxDecoration(
        color: AppColors.neutralColor,
        borderRadius: .circular(12),
        border: .all(color: AppColors.infoColor.withAlpha(100)),
      ),
      width: double.maxFinite,
      height: finalHeight,
      child: GridView.builder(
        padding: .zero,
        physics: physics,
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
              if (onSelectedItem != null && index != current) {
                onSelectedItem!(index);
              }
            },
            child: Center(child: Text('${index + 1}')),
          ),
        ),
      ),
    );
  }
}
