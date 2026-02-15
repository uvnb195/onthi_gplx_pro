import 'package:flutter/material.dart';
import 'package:onthi_gplx_pro/core/theme/app_colors.dart';
import 'package:onthi_gplx_pro/core/widgets/index.dart';
import 'package:onthi_gplx_pro/features/home/presentation/widgets/streak_animation.dart';
import 'package:onthi_gplx_pro/features/user_management/domain/entities/user_entity.dart';

class HomeAppBarDelegate extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final double collapsedHeight;
  final UserEntity user;

  HomeAppBarDelegate({
    required this.expandedHeight,
    this.collapsedHeight = kToolbarHeight + 16,
    required this.user,
  });

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    double progress = (shrinkOffset) / expandedHeight;

    // collapsible section
    Widget buildAppBar(BuildContext context) {
      return Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
        ).copyWith(top: (collapsedHeight - 48) / 2),
        width: .maxFinite,
        child: Align(
          child: Row(
            mainAxisAlignment: .start,
            crossAxisAlignment: .center,
            mainAxisSize: .max,
            children: [
              AvatarWrapper(
                imagePath:
                    user.avatarPath?.value ?? 'assets/images/app_logo.png',
                size: progress * 48,
              ),

              SizedBox(width: progress == 1 ? 8 : 0),

              //
              Expanded(
                child: Column(
                  crossAxisAlignment: .start,
                  mainAxisAlignment: .center,
                  mainAxisSize: .max,
                  children: [
                    SizedBox(
                      width: .maxFinite,
                      height: progress * 24,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          user.name.value,
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
              StyledIconButton(iconData: Icons.notifications, onTap: () {}),
            ],
          ),
        ),
      );
    }

    // main content
    return Container(
      decoration: BoxDecoration(
        border: .fromLTRB(
          bottom: BorderSide(
            width: 1,
            color: AppColors.textDisableColor.withAlpha(100),
          ),
        ),
      ),
      child: Stack(
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
                        child: StyledSlideEntrance(
                          from: .RIGHT,
                          child: RichText(
                            text: TextSpan(
                              text: "Xin chào, ${user.name.value}! 👋",
                              children: [
                                TextSpan(
                                  text:
                                      "\nTiếp tục chinh phục mục tiêu của bạn.",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: .w300,
                                  ),
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
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => collapsedHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
