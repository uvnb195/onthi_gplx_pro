import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:onthi_gplx_pro/core/theme/app_colors.dart';
import 'package:onthi_gplx_pro/features/main_layout/presentation/widgets/home_appbar_delegate.dart';
import 'package:onthi_gplx_pro/features/main_layout/presentation/widgets/index.dart';
import 'package:onthi_gplx_pro/features/main_layout/presentation/widgets/section_wrapper.dart';
import 'package:onthi_gplx_pro/features/main_layout/presentation/widgets/todo_section.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  final double expandedHeight = 120;
  final double collapsedHeight = kToolbarHeight + 8;

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
      body: SafeArea(
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
                ),
              ),
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  children: [
                    SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: TodoSection(),
                    ),
                    SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: SectionWrapper(
                        title: 'Hello',
                        showNavigate: true,
                        child: Row(
                          children: [
                            AvatarWrapper(
                              imagePath: 'assets/images/app_logo.png',
                              size: 48,
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 500,
                      width: .maxFinite,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 500,
                      width: .maxFinite,
                      child: DecoratedBox(
                        decoration: BoxDecoration(color: AppColors.infoColor),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
