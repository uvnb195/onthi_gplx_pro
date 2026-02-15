import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:onthi_gplx_pro/core/di/injection.dart';
import 'package:onthi_gplx_pro/core/extension/exam_type.dart';
import 'package:onthi_gplx_pro/core/router/route_names.dart';
import 'package:onthi_gplx_pro/core/theme/app_colors.dart';
import 'package:onthi_gplx_pro/core/widgets/index.dart';
import 'package:onthi_gplx_pro/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:onthi_gplx_pro/features/learning/presentation/bloc/learning_bloc.dart';
import 'package:onthi_gplx_pro/features/learning/presentation/widgets/collapse_menu.dart';

class LearningDashBoardPage extends StatelessWidget {
  const LearningDashBoardPage({super.key});

  void _navigateToLearningInfoPage(
    BuildContext context, {
    required String title,
    required IconData iconData,
    required Color themeColor,
    String? description,
    required ExamType examType,
  }) {
    final authBloc = context.read<AuthBloc>();
    final licenseId = switch (authBloc.state) {
      Authenticated(user: var u) => u.license.id,
      _ => null,
    };
    if (licenseId == null) return;

    final learningBloc = context.read<LearningBloc>();

    learningBloc.add(
      LoadExamQuestions(licenseId: licenseId, examType: examType.index),
    );

    if (learningBloc.state.loading) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => Center(
          child: CircularProgressIndicator(color: AppColors.primaryColor),
        ),
      );
    }

    final totalQuestions = learningBloc.state.questions.length;

    Navigator.pushNamed(
      context,
      RouteNames.learningInfo,
      arguments: {
        'title': title,
        'iconData': iconData,
        'themeColor': themeColor,
        'description': description,
        'isLearning': false,
        'stats': [
          {
            'iconData': BootstrapIcons.file_earmark_text,
            'title': '40',
            'description': 'Câu hỏi',
          },
          {
            'iconData': BootstrapIcons.alarm,
            'title': '24',
            'description': 'phút',
          },
          {
            'iconData': BootstrapIcons.clipboard_check,
            'title': '36/40',
            'description': 'tối thiểu',
          },
        ],
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 0),
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, authState) {
          if (authState is! Authenticated) {
            return SizedBox.shrink();
          }
          return BlocBuilder<LearningBloc, LearningState>(
            builder: (context, state) {
              final List<Color> colors = AppColors.rainbowColors;
              List<Color> getRotateRainbowColors(int startIndex) {
                if (startIndex == -1 || startIndex >= colors.length) {
                  return colors;
                }
                return colors.sublist(startIndex)
                  ..addAll(colors.sublist(0, startIndex));
              }

              final theoryIconDatas = authState.user.license.id <= 2
                  ? [
                      BootstrapIcons.bookmarks,
                      BootstrapIcons.shield_lock,
                      BootstrapIcons.journal_text,
                      BootstrapIcons.people,
                      BootstrapIcons.speedometer2,
                      BootstrapIcons.sign_stop,
                      BootstrapIcons.stoplights,
                    ]
                  : [
                      BootstrapIcons.bookmarks,
                      BootstrapIcons.shield_lock,
                      BootstrapIcons.journal_text,
                      BootstrapIcons.people,
                      BootstrapIcons.speedometer2,
                      BootstrapIcons.sign_stop,
                      BootstrapIcons.tools,
                      BootstrapIcons.stoplights,
                    ];

              final theoryDropdownItemColors = getRotateRainbowColors(0);
              final videoDropdownItemColors = getRotateRainbowColors(4);
              final List<CollapseMenuItem> theoryDropdownItems = state
                  .categories
                  .asMap()
                  .entries
                  .map(
                    (e) => CollapseMenuItem(
                      title: e.value.label,
                      iconData: theoryIconDatas[e.key],
                      themeColor: e.key < colors.length
                          ? theoryDropdownItemColors[e.key]
                          : theoryDropdownItemColors[colors.length - 1],
                    ),
                  )
                  .toList();
              final List<CollapseMenuItem> videoDropdownItems = state.categories
                  .asMap()
                  .entries
                  .map(
                    (e) => CollapseMenuItem(
                      title: e.value.label,
                      iconData: theoryIconDatas[e.key],
                      themeColor: e.key < colors.length
                          ? videoDropdownItemColors[e.key]
                          : videoDropdownItemColors[colors.length - 1],
                    ),
                  )
                  .toList();

              if (state.loading) {
                return Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primaryColor,
                  ),
                );
              }
              return LayoutBuilder(
                builder: (context, constraints) {
                  if (constraints.maxWidth < 600) {
                    return _buildMobileLayout(
                      context,
                      theoryCategories: theoryDropdownItems,
                      videoCategories: [],
                    );
                  } else {
                    return _buildLargeLayout(
                      context,
                      theoryCategories: theoryDropdownItems,
                      videoCategories: videoDropdownItems,
                    );
                  }
                },
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildMobileLayout(
    BuildContext context, {
    required List<CollapseMenuItem> theoryCategories,
    required List<CollapseMenuItem> videoCategories,
  }) {
    final List<Color> colors = AppColors.rainbowColors;
    final learningBloc = sl<LearningBloc>();

    return SafeArea(
      child: CustomScrollView(
        physics: AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
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
                  title: 'Thi lý thuyết',
                  subTitle:
                      'Thi thử bộ đề ngẫu nhiên từ 600 câu hỏi. Cấu trúc chuẩn bộ GTVT.',
                  percentage: 0.8,
                  onTap: () {
                    _navigateToLearningInfoPage(
                      context,
                      title: 'Thi lý thuyết',
                      iconData: BootstrapIcons.clipboard_check,
                      themeColor: AppColors.accentVariantColor,
                      examType: ExamType.theory,
                    );
                  },
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
                items: theoryCategories,
                iconData: BootstrapIcons.list_check,
                title: 'Học lý thuyết',
                subTitle: '600 câu • 7 chủ đề',
              ),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
            ).copyWith(top: 16),
            sliver: SliverToBoxAdapter(
              child: StyledScaleEntrance(
                duration: const Duration(milliseconds: 300),
                child: HorizontalLargeCard(
                  themeColor: AppColors.secondaryColor,
                  iconData: BootstrapIcons.tv,
                  title: 'Thi mô phỏng',
                  subTitle:
                      'Thi thử bộ đề ngẫu nhiên từ 120 câu hỏi mô phỏng. Cấu trúc chuẩn bộ GTVT.',
                  percentage: 0.8,
                  onTap: () {
                    _navigateToLearningInfoPage(
                      context,
                      title: 'Thi mô phỏng',
                      iconData: BootstrapIcons.tv,
                      themeColor: AppColors.secondaryColor,
                      description: 'Thi mô phỏng chuẩn bộ GTVT',
                      examType: ExamType.simulation,
                    );
                  },
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
                items: videoCategories,
                themeColor: colors[4],
                iconData: BootstrapIcons.list_check,
                title: 'Học mô phỏng',
                subTitle: '120 câu • 6 chủ đề',
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
    );
  }

  Widget _buildLargeLayout(
    BuildContext context, {
    required List<CollapseMenuItem> theoryCategories,
    required List<CollapseMenuItem> videoCategories,
  }) {
    final List<Color> colors = AppColors.rainbowColors;

    Widget getGridItem(int index) {
      switch (index) {
        case 0:
          return StyledScaleEntrance(
            duration: const Duration(milliseconds: 300),
            child: HorizontalLargeCard(
              themeColor: AppColors.accentVariantColor,
              iconData: BootstrapIcons.clipboard_check,
              title: 'Thi lý thuyết',
              subTitle:
                  'Thi thử bộ đề ngẫu nhiên từ 600 câu hỏi. Cấu trúc chuẩn bộ GTVT.',
              percentage: 0.8,
              onTap: () {
                Navigator.pushNamed(
                  context,
                  RouteNames.learningInfo,
                  arguments: {
                    'themeColor': AppColors.accentVariantColor,
                    'title': 'Thi lý thuyết',

                    'iconData': BootstrapIcons.clipboard_check,
                    'description': 'Thi lý thuyết chuẩn bộ GTVT',
                    'categoryId': 1,
                    'stats': [
                      {
                        'iconData': BootstrapIcons.file_earmark_text,
                        'title': '30',
                        'description': 'Câu hỏi',
                      },
                      {
                        'iconData': BootstrapIcons.clock_history,
                        'title': '19',
                        'description': 'phút',
                      },
                      {
                        'iconData': BootstrapIcons.bullseye,
                        'title': '21',
                        'description': 'Điểm tối thiểu',
                      },
                    ],
                  },
                );
              },
            ),
          );
        default:
          return StyledScaleEntrance(
            duration: const Duration(milliseconds: 300),
            child: HorizontalLargeCard(
              themeColor: AppColors.secondaryColor,
              iconData: BootstrapIcons.tv,
              title: 'Thi mô phỏng',
              subTitle:
                  'Thi thử bộ đề ngẫu nhiên từ 120 câu hỏi mô phỏng. Cấu trúc chuẩn bộ GTVT.',
              percentage: 0.8,
              onTap: () {
                Navigator.pushNamed(
                  context,
                  RouteNames.learningInfo,
                  arguments: {
                    'themeColor': AppColors.secondaryColor,
                    'title': 'Thi mô phỏng',
                    'description': 'Thi mô phỏng chuẩn bộ GTVT',
                    'categoryId': 1,
                    'iconData': BootstrapIcons.tv,
                    'stats': [
                      {
                        'iconData': BootstrapIcons.file_earmark_text,
                        'title': '30',
                        'description': 'Câu hỏi',
                      },
                      {
                        'iconData': BootstrapIcons.clock_history,
                        'title': '19',
                        'description': 'phút',
                      },
                      {
                        'iconData': BootstrapIcons.bullseye,
                        'title': '21',
                        'description': 'Điểm tối thiểu',
                      },
                    ],
                  },
                );
              },
            ),
          );
      }
    }

    return SafeArea(
      child: CustomScrollView(
        physics: AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
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
            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate(
                (_, index) => getGridItem(index),
                childCount: 2,
              ),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisExtent: 180,
                crossAxisSpacing: 16,
              ),
            ),
          ),

          SliverToBoxAdapter(child: SizedBox(height: 16)),

          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverToBoxAdapter(
              child: Row(
                crossAxisAlignment: .start,
                children: [
                  Expanded(
                    child: CollapseMenu(
                      items: theoryCategories,
                      iconData: BootstrapIcons.list_check,
                      title: 'Học lý thuyết',
                      subTitle: '600 câu • 7 chủ đề',
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: CollapseMenu(
                      items: videoCategories,
                      themeColor: AppColors.accentColor,
                      iconData: BootstrapIcons.list_check,
                      title: 'Học mô phỏng',
                      subTitle: '120 tình huống • 6 chủ đề',
                    ),
                  ),
                ],
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
    );
  }
}

final List<Map<String, dynamic>> theoryItems = [
  {
    'title': 'Câu hỏi đánh dấu',
    'subTitle': 'Học ngẫu nhiên những câu hỏi bạn đã lưu',
    'total': 23,
    'iconData': BootstrapIcons.bookmarks,
    'themeColor': Colors.deepOrange,
  },
  {
    'title': 'Câu điểm liệt',
    'subTitle':
        'Những tình huống gây mất an toàn giao thông nghiêm trọng (Sai 1 câu là đi 1 sải)',
    'total': 60,
    'iconData': BootstrapIcons.shield_lock,
    'themeColor': Colors.deepOrangeAccent,
  },
  {
    'title': 'Khái Niệm và Quy Tắc',
    'subTitle':
        'Định nghĩa cơ bản, quy tắc đi đường, tốc độ và khoảng cách an toàn.',
    'total': 60,
    'iconData': BootstrapIcons.journal_text,
    'themeColor': Colors.orange,
  },
  {
    'title': 'Văn hóa & Đạo đức',
    'subTitle':
        'Trách nhiệm của người lái xe, văn hóa ứng xử và kỹ năng sơ cứu.',
    'total': 60,
    'iconData': BootstrapIcons.people,
    'themeColor': Colors.amber,
  },
  {
    'title': 'Kỹ thuật Lái xe',
    'subTitle':
        'Cách điều khiển xe trên dốc, đường trơn, đường hầm và xử lý sự cố.',
    'total': 60,
    'iconData': BootstrapIcons.speedometer2,
    'themeColor': Colors.green,
  },
  {
    'title': 'Hệ thống Biển báo',
    'subTitle': 'Biển báo cấm, biển nguy hiểm, biển hiệu lệnh và biển chỉ dẫn.',
    'total': 60,
    'iconData': BootstrapIcons.sign_stop,
    'themeColor': AppColors.infoColor,
  },
  {
    'title': 'Cấu Tạo và Sửa Chữa',
    'subTitle':
        'Tìm hiểu về động cơ, phanh, lốp và các bộ phận cơ bản của xe ô tô.',
    'total': 60,
    'iconData': BootstrapIcons.tools,
    'themeColor': Colors.deepPurpleAccent,
  },
  {
    'title': 'Giải thế Sa hình',
    'subTitle':
        'Quy tắc nhường đường tại ngã tư và các tình huống giao thông thực tế.',
    'total': 60,
    'iconData': BootstrapIcons.stoplights,
    'themeColor': Colors.purpleAccent,
  },
];

final List<Map<String, dynamic>> simulationExamItems = [
  {
    'title': 'Câu hỏi đánh dấu',
    'total': 23,
    'iconData': BootstrapIcons.bookmarks,
    'themeColor': Colors.green,
  },
  {
    'title': 'Giao thông trong đô thị',
    'subTitle':
        'Những tình huống gây mất an toàn giao thông nghiêm trọng (Sai 1 câu là đi 1 sải)',
    'total': 60,
    'iconData': BootstrapIcons.$1_square,
    'themeColor': AppColors.infoColor,
  },
  {
    'title': "Giao thông ngoài đô thị",
    'subTitle':
        'Định nghĩa cơ bản, quy tắc đi đường, tốc độ và khoảng cách an toàn.',
    'total': 60,
    'iconData': BootstrapIcons.$2_square,
    'themeColor': Colors.deepPurpleAccent,
  },
  {
    'title': "Giao thông trên cao tốc",
    'subTitle':
        'Trách nhiệm của người lái xe, văn hóa ứng xử và kỹ năng sơ cứu.',
    'total': 60,
    'iconData': BootstrapIcons.$3_square,
    'themeColor': Colors.purpleAccent,
  },
  {
    'title': "Giao thông trên đường núi",
    'subTitle':
        'Cách điều khiển xe trên dốc, đường trơn, đường hầm và xử lý sự cố.',
    'total': 60,
    'iconData': BootstrapIcons.$4_square,
    'themeColor': Colors.deepOrange,
  },
  {
    'title': "Giao thông trên đường quốc lộ",
    'subTitle': 'Biển báo cấm, biển nguy hiểm, biển hiệu lệnh và biển chỉ dẫn.',
    'total': 60,
    'iconData': BootstrapIcons.$5_square,
    'themeColor': Colors.deepOrangeAccent,
  },
  {
    'title': "Tai nạn giao thông thực tế",
    'subTitle':
        'Tìm hiểu về động cơ, phanh, lốp và các bộ phận cơ bản của xe ô tô.',
    'total': 60,
    'iconData': BootstrapIcons.$6_square,
    'themeColor': Colors.orange,
  },
];
