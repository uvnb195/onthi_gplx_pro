import 'package:flutter/material.dart';
import 'package:onthi_gplx_pro/core/theme/app_colors.dart';
import 'package:onthi_gplx_pro/features/home/presentation/widgets/avatar_wrapper.dart';
import 'package:onthi_gplx_pro/features/home/presentation/widgets/streak_animation.dart';

class HomeAppBarDelegate extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final double collapsedHeight;

  HomeAppBarDelegate({
    required this.expandedHeight,
    this.collapsedHeight = kToolbarHeight + 8,
  });

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    double progress = (shrinkOffset) / expandedHeight;

    // collapse section
    Widget buildAppBar(BuildContext context) {
      return SizedBox(
        width: .maxFinite,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: .start,
              mainAxisSize: .max,
              children: [
                AvatarWrapper(
                  imagePath: 'assets/images/app_logo.png',
                  size: progress * 48,
                ),

                SizedBox(width: progress == 1 ? 8 : 0),

                //
                Expanded(
                  child: Column(
                    crossAxisAlignment: .start,
                    mainAxisAlignment: .center,
                    children: [
                      SizedBox(
                        width: .maxFinite,
                        height: progress * 24,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            "Quân",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      StreakAnimation(),
                    ],
                  ),
                ),
                Spacer(),
                IconButton(
                  splashColor: AppColors.primarySwatch.shade900,
                  highlightColor: AppColors.primaryColor.withAlpha(20),
                  style: IconButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 2,
                    backgroundColor: AppColors.neutralColor.withAlpha(100),
                  ),
                  onPressed: () {},
                  icon: Badge(
                    backgroundColor: AppColors.primarySwatch.shade800,
                    child: Icon(
                      Icons.notifications,
                      color: AppColors.infoColor.withAlpha(100),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    // main content
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(color: AppColors.backgroundColor),
        Center(
          child: Column(
            mainAxisSize: .max,
            mainAxisAlignment: .start,
            crossAxisAlignment: .start,
            children: [
              buildAppBar(context),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Opacity(
                    opacity: (1 - progress * 1.5).clamp(0.0, 1.0),
                    child: Transform.translate(
                      offset: Offset(-progress * (expandedHeight / 2), 0),
                      child: RichText(
                        text: TextSpan(
                          text: "Xin chào, Quân! 👋",
                          children: [
                            TextSpan(
                              text: "\nTiếp tục chinh phục mục tiêu của bạn.",
                              style: TextStyle(fontSize: 14, fontWeight: .w300),
                            ),
                          ],
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Divider(),
            ],
          ),
        ),
      ],
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => collapsedHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
