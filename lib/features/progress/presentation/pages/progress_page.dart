import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:onthi_gplx_pro/core/theme/app_colors.dart';
import 'package:onthi_gplx_pro/core/widgets/index.dart';
import 'package:onthi_gplx_pro/core/widgets/menu_item.dart';
import 'package:onthi_gplx_pro/core/widgets/page_header.dart';
import 'package:onthi_gplx_pro/features/progress/presentation/widgets/info_card.dart';
import 'package:onthi_gplx_pro/features/progress/presentation/widgets/styled_line_chart.dart';
import 'package:onthi_gplx_pro/features/progress/presentation/widgets/styled_timeline.dart';

class ProgressPage extends StatelessWidget {
  const ProgressPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> stats = [
      {
        'iconData': BootstrapIcons.collection,
        'title': '530',
        'description': 'Câu đã làm',
        'themeColor': AppColors.infoColor,
      },
      {
        'iconData': BootstrapIcons.clock_history,
        'title': '12.5h',
        'description': 'Giờ học',
        'themeColor': AppColors.primaryColor,
      },
      {
        'iconData': BootstrapIcons.graph_up,
        'title': '85%',
        'description': 'Tỉ lệ đúng',
        'themeColor': AppColors.accentColor,
      },
    ];

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          physics: AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics(),
          ),
          slivers: [
            SliverAppBar(
              pinned: true,
              titleSpacing: 0,
              title: PageHeader(
                content: Text('Tiến độ học tập'),
                // actions: [
                //   StyledIconButton(
                //     iconData: BootstrapIcons.gear,
                //     onTap: () {},
                //     isBadgeLabelVisible: false,
                //   ),
                // ],
              ),
            ),

            SliverPadding(
              padding: const .symmetric(horizontal: 8, vertical: 16),
              sliver: SliverToBoxAdapter(
                child: Row(
                  mainAxisSize: .max,
                  mainAxisAlignment: .center,
                  children: List.generate(
                    stats.length,
                    (index) => Expanded(
                      child: Padding(
                        padding: .symmetric(horizontal: 8),
                        child: StyledScaleEntrance(
                          from: 1.5,
                          child: InfoCard(
                            iconData: stats[index]['iconData'],
                            title: stats[index]['title'],
                            description: stats[index]['description'],
                            themeColor: stats[index]['themeColor'],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: .symmetric(horizontal: 16),
              sliver: SliverToBoxAdapter(
                child: StyledScaleEntrance(child: StyledLineChart()),
              ),
            ),

            SliverPadding(
              padding: .only(top: 24, bottom: 8),
              sliver: SliverToBoxAdapter(
                child: SectionHeader(
                  icon: Icon(
                    BootstrapIcons.exclamation_diamond,
                    color: AppColors.primarySwatch.shade700,
                  ),
                  title: 'Cần cải thiện',
                ),
              ),
            ),
            SliverPadding(
              padding: .symmetric(horizontal: 16),
              sliver: SliverToBoxAdapter(
                child: Column(
                  children: List.generate(
                    4,
                    (index) => Padding(
                      padding: .symmetric(
                        horizontal: 8,
                      ).add(const .only(bottom: 8)),
                      child: AnimationConfiguration.staggeredList(
                        position: index,
                        child: SlideAnimation(
                          child: MenuItem(
                            onTap: () {},
                            themeColor: AppColors.primarySwatch.shade700,
                            backgroundColor: Color.lerp(
                              AppColors.neutralColor,
                              Colors.white24,
                              0.3,
                            ),
                            title: 'dafaskfjasld',
                            subTitleWidget: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: '45% chính xác',
                                    style: TextStyle(
                                      color: AppColors.primaryColor,
                                      fontWeight: .w500,
                                    ),
                                  ),
                                  TextSpan(
                                    text: '  •  5 câu sai',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: .w300,
                                      color: AppColors.textSecondaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: const .symmetric(vertical: 24, horizontal: 16),
              sliver: SliverToBoxAdapter(child: StyledTimeline()),
            ),
          ],
        ),
      ),
    );
  }
}
