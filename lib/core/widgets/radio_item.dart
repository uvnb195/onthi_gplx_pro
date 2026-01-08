import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:onthi_gplx_pro/core/theme/app_colors.dart';

class RadioItem extends StatefulWidget {
  const RadioItem({super.key});

  @override
  State<RadioItem> createState() => _RadioItemState();
}

class _RadioItemState extends State<RadioItem> {
  bool _selected = false;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: _selected
          ? AppColors.primarySwatch.shade900.withAlpha(50)
          : AppColors.neutralColor,
      borderRadius: .circular(8),
      elevation: 4,
      child: InkWell(
        onTap: () {
          setState(() {
            _selected = !_selected;
          });
        },
        borderRadius: .circular(8),
        splashColor: AppColors.primaryColor.withAlpha(50),
        highlightColor: AppColors.infoColor.withAlpha(20),
        child: AnimatedContainer(
          decoration: BoxDecoration(
            borderRadius: .circular(8),
            border: .all(
              color: _selected
                  ? AppColors.primarySwatch.shade800.withAlpha(200)
                  : AppColors.textSecondaryColor,
              width: 2,
            ),
          ),
          duration: const Duration(milliseconds: 300),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: .start,
                  mainAxisSize: .min,
                  children: [
                    Text(
                      "Hạng A1",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Xe máy dưới 175cc",
                      style: TextStyle(fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
                Spacer(),
                AnimatedSwitcher(
                  switchInCurve: Curves.bounceOut,
                  switchOutCurve: Curves.linear,
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder: (child, animation) =>
                      ScaleTransition(scale: animation, child: child),
                  child: _selected == true
                      ? Icon(
                          key: ValueKey('selected'),
                          BootstrapIcons.check_circle_fill,
                          color: _selected ? AppColors.primaryColor : null,
                        )
                      : Icon(
                          key: ValueKey('unselected'),
                          BootstrapIcons.circle,
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
