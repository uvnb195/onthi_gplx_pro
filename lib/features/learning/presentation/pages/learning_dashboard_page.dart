import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:onthi_gplx_pro/core/router/route_names.dart';
import 'package:onthi_gplx_pro/core/theme/app_colors.dart';
import 'package:onthi_gplx_pro/core/widgets/index.dart';
import 'package:onthi_gplx_pro/features/learning/presentation/widgets/collapse_menu.dart';

class LearningDashBoardPage extends StatelessWidget {
  const LearningDashBoardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 0),
      body: SafeArea(
        child: CustomScrollView(
          physics: AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics(),
          ),
          slivers: [
            SliverAppBar(
              pinned: true,
              titleSpacing: 0,
              title: PageHeader(content: Text('Học tập')),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
              ).copyWith(top: 16),
              sliver: SliverToBoxAdapter(
                child: StyledScaleEntrance(
                  duration: const Duration(milliseconds: 300),
                  child: HorizontalLargeCard(
                    themeColor: AppColors.accentVariantColor,
                    iconData: BootstrapIcons.clipboard_check,
                    title: 'Thi thử',
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        RouteNames.learning,
                        arguments: {'title': 'Đề thi #1', 'isStudy': true},
                      );
                    },
                    subTitle:
                        'Thi thử bộ đề ngẫu nhiên từ 600 câu hỏi. Cấu trúc chuẩn bộ GTVT.',
                    percentage: 0.8,
                  ),
                ),
              ),
            ),

            SliverPadding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
              ).copyWith(top: 16),
              sliver: SliverToBoxAdapter(
                child: CollapseMenu(
                  iconData: BootstrapIcons.list_check,
                  title: 'Học theo chủ đề',
                  subTitle: '600 câu • 7 chủ đề',
                ),
              ),
            ),

            // H I S T O R Y
            SliverPadding(
              padding: const EdgeInsets.only(top: 24),
              sliver: SliverToBoxAdapter(
                child: SectionHeader(
                  title: 'Lịch sử học tập',
                  subTitle: 'Xem tất cả',
                  onSubtitlePress: () {},
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ).copyWith(top: 24, bottom: 16),
              sliver: SliverToBoxAdapter(
                child: Column(
                  children: List.generate(4, (index) {
                    BorderRadius getBorderRadius() {
                      if (index == 0) {
                        return BorderRadius.only(
                          topLeft: .circular(12),
                          topRight: .circular(12),
                        );
                      } else if (index == 4 - 1) {
                        return BorderRadius.only(
                          bottomLeft: .circular(12),
                          bottomRight: .circular(12),
                        );
                      } else {
                        return BorderRadius.zero;
                      }
                    }

                    if (index % 2 == 0) {
                      return AnimationConfiguration.staggeredList(
                        position: index,
                        child: SlideAnimation(
                          verticalOffset: 50,
                          child: MenuItem(
                            title: 'Đề thi #15',
                            subTitle: 'Hôm qua, 14:25',
                            rightText: '17/30',
                            rightTextStyle: TextStyle(
                              fontSize: 16,
                              fontWeight: .bold,
                            ),
                            borderRadius: getBorderRadius(),
                            iconData: BootstrapIcons.exclamation_diamond,
                            showBottomBorder: index == 4 - 1,
                            themeColor: AppColors.primaryColor,
                            backgroundColor: AppColors.neutralColor,
                          ),
                        ),
                      );
                    }

                    return AnimationConfiguration.staggeredList(
                      position: index,
                      child: SlideAnimation(
                        verticalOffset: 50,
                        child: MenuItem(
                          title: 'Đề thi #15',
                          subTitle: 'Hôm qua, 14:25',
                          rightText: '28/30',
                          rightTextStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: .bold,
                          ),
                          borderRadius: getBorderRadius(),
                          iconData: BootstrapIcons.check_circle,
                          showBottomBorder: index == 4 - 1,
                          themeColor: AppColors.accentColor,
                          backgroundColor: AppColors.neutralColor,
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
