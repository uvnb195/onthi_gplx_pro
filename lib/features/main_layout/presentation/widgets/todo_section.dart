import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:onthi_gplx_pro/core/theme/app_colors.dart';

class TodoSection extends StatelessWidget {
  const TodoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.neutralColor,
      borderRadius: .circular(20),
      clipBehavior: .antiAlias,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: .circular(24),
          border: .all(color: AppColors.primarySwatch.shade700.withAlpha(50)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // T I T L E
              Row(
                crossAxisAlignment: .center,
                children: [
                  Text(
                    'Mục tiêu hôm nay',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: .w700,
                      letterSpacing: 1,
                    ),
                  ),
                  Spacer(),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: AppColors.primarySwatch.shade700.withAlpha(50),
                      borderRadius: .circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        '1/3',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: .bold,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              // I T E M S
              _TodoItem(isDone: true),
              _TodoItem(),
              _TodoItem(),
            ],
          ),
        ),
      ),
    );
  }
}

class _TodoItem extends StatelessWidget {
  final bool isDone;
  const _TodoItem({super.key, this.isDone = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, left: 4),
      child: Row(
        children: [
          Icon(
            isDone ? BootstrapIcons.check_circle : BootstrapIcons.circle,
            color: isDone
                ? AppColors.primaryColor
                : AppColors.textColor.withAlpha(50),
            size: 20,
          ),
          SizedBox(width: 8),
          Text(
            "Hoàn thành 3 bài học",
            style: TextStyle(
              fontSize: 16,
              decoration: isDone ? .lineThrough : null,
              decorationColor: AppColors.textDisableColor,
              color: isDone ? AppColors.textDisableColor : null,
            ),
            maxLines: 1,
            overflow: .ellipsis,
          ),
        ],
      ),
    );
  }
}
