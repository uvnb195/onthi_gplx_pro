import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:onthi_gplx_pro/core/widgets/index.dart';
import 'package:onthi_gplx_pro/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:onthi_gplx_pro/features/home/presentation/widgets/achievement_small_card.dart';
import 'package:onthi_gplx_pro/features/home/presentation/widgets/home_appbar_delegate.dart';
import 'package:onthi_gplx_pro/features/home/presentation/widgets/section_wrapper.dart';
import 'package:onthi_gplx_pro/features/home/presentation/widgets/todo_section.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  final double expandedHeight = 120;
  final double collapsedHeight = kToolbarHeight + 16;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    if (notification is UserScrollNotification &&
        notification.direction == ScrollDirection.idle) {
      final double offset = _scrollController.offset;
      final double snapThreshold = expandedHeight / 2;

      if (offset > 0 && offset < expandedHeight) {
        double targetOffset = offset < snapThreshold ? 0 : expandedHeight;

        Future.microtask(() {
          _scrollController.animateTo(
            targetOffset,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOutCubic,
          );
        });
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is! Authenticated) {
            return Center(
              child: Text('Có lỗi xảy ra.\nVui lòng khởi động lại ứng dụng!'),
            );
          }
          return SafeArea(
            child: NotificationListener<ScrollNotification>(
              onNotification: (notification) =>
                  _handleScrollNotification(notification),
              child: CustomScrollView(
                controller: _scrollController,
                physics: AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics(),
                ),
                slivers: [
                  SliverPersistentHeader(
                    pinned: true,
                    delegate: HomeAppBarDelegate(
                      expandedHeight: expandedHeight,
                      collapsedHeight: collapsedHeight,
                      user: state.user,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 24,
                        left: 8,
                        right: 8,
                      ),
                      child: StyledScaleEntrance(child: TodoSection()),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: SectionWrapper(
                      title: 'Thành tích',
                      showNavigate: true,
                      child: SingleChildScrollView(
                        padding: const .symmetric(horizontal: 16),
                        scrollDirection: .horizontal,
                        physics: AlwaysScrollableScrollPhysics(
                          parent: ClampingScrollPhysics(),
                        ),
                        child: Row(
                          mainAxisSize: .min,
                          children: List.generate(
                            6,
                            (index) => AnimationConfiguration.staggeredList(
                              position: index,
                              child: FadeInAnimation(
                                child: SlideAnimation(
                                  horizontalOffset: 100,
                                  delay: const Duration(milliseconds: 100),
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 12.0),
                                    child: AchievementSmallCard(level: index),
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
                    padding: const .only(top: 24, bottom: 12),
                    sliver: SliverToBoxAdapter(
                      child: SectionHeader(title: 'Học tập'),
                    ),
                  ),

                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    sliver: SliverLayoutBuilder(
                      builder: (context, constraints) {
                        return SliverGrid(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount:
                                    constraints.crossAxisExtent > 600 ? 2 : 1,
                                mainAxisSpacing: 12,
                                crossAxisSpacing: 12,
                                childAspectRatio: 2.4,
                              ),
                          delegate: SliverChildBuilderDelegate((
                            context,
                            index,
                          ) {
                            if (index > 2) {
                              return StyledScaleEntrance(
                                child: HorizontalLargeCard(
                                  title: 'Biển báo giao thông',
                                  subTitle: 'Tiếp tục học',
                                  iconData: BootstrapIcons.journal_bookmark,
                                  percentage: 0.8,

                                  isDisabled: true,
                                ),
                              );
                            } else {
                              return StyledScaleEntrance(
                                child: HorizontalLargeCard(
                                  title: 'Biển báo giao thông',
                                  subTitle: 'Tiếp tục học',
                                  iconData: BootstrapIcons.journal_bookmark,
                                  percentage: 0.8,
                                ),
                              );
                            }
                          }, childCount: 5),
                        );
                      },
                    ),
                  ),
                  SliverPadding(padding: const .only(bottom: 16)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
