import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:onthi_gplx_pro/core/di/injection.dart';
import 'package:onthi_gplx_pro/core/theme/app_colors.dart';
import 'package:onthi_gplx_pro/core/widgets/index.dart';
import 'package:onthi_gplx_pro/features/auth/presentation/bloc/auth_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(
          parent: BouncingScrollPhysics(),
        ),
        slivers: [
          SliverAppBar(
            primary: false,
            titleSpacing: 0,
            title: _buildHeader(context),
            automaticallyImplyActions: false,
            automaticallyImplyLeading: false,
            toolbarHeight: 180,
            actionsPadding: .zero,
          ),
          SliverPadding(
            padding: const .symmetric(vertical: 40, horizontal: 16),
            sliver: SliverToBoxAdapter(child: _buildContent()),
          ),
          SliverToBoxAdapter(
            child: StyledScaleEntrance(
              delayed: const Duration(milliseconds: 300),
              child: Center(
                child: Text(
                  'Phiên bản: v2.0.1',
                  style: TextStyle(color: AppColors.textDisableColor),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return SizedBox(
      height: 180,
      width: double.maxFinite,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.neutralColor,
          border: .fromLTRB(
            bottom: BorderSide(color: AppColors.primaryColor.withAlpha(100)),
          ),
          borderRadius: .only(
            bottomLeft: .circular(24),
            bottomRight: .circular(24),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 24, bottom: 24),
          child: Column(
            mainAxisAlignment: .start,
            children: [
              AvatarWrapper(imagePath: 'assets/images/app_logo.png', size: 68),
              SizedBox(height: 8),
              Text('Quân', style: TextStyle(fontSize: 24, fontWeight: .w600)),
              Text(
                'Tham gia từ 24/03/2024',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: .w400,
                  color: AppColors.textSecondaryColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent() {
    return Column(
      children: [
        AnimationConfiguration.staggeredList(
          position: 0,
          child: SlideAnimation(
            child: MenuItem(
              backgroundColor: Color.lerp(
                AppColors.neutralColor,
                Colors.white10,
                0.3,
              ),
              iconData: BootstrapIcons.emoji_heart_eyes,
              title: 'Loại bỏ quảng cáo',
              titleUseThemeColor: true,
              subTitle: 'Loại bỏ quảng cáo phiền phức',
              themeColor: AppColors.accentColor,
              onTap: () {},
            ),
          ),
        ),
        SizedBox(height: 24),
        AnimationConfiguration.staggeredList(
          position: 1,
          child: SlideAnimation(
            child: MenuItem(
              backgroundColor: Color.lerp(
                AppColors.neutralColor,
                Colors.white10,
                0.3,
              ),
              iconData: BootstrapIcons.bell,
              title: 'Thông báo',
              subTitle: 'Nhắc bạn học mỗi ngày',
              titleUseThemeColor: true,
              rightText: '09:00 p.m',
              themeColor: AppColors.secondaryColor,
              onTap: () {},
            ),
          ),
        ),
        SizedBox(height: 24),

        AnimationConfiguration.staggeredList(
          position: 2,
          child: SlideAnimation(
            child: MenuItem(
              borderRadius: .only(
                topLeft: .circular(12),
                topRight: .circular(12),
              ),
              backgroundColor: Color.lerp(
                AppColors.neutralColor,
                Colors.white10,
                0.3,
              ),
              showBottomBorder: false,
              iconData: BootstrapIcons.trash,
              title: 'Thay đổi Hạng GPLX',
              titleUseThemeColor: true,
              rightText: 'Hạng A1',
              subTitle: 'Xoá toàn bộ dữ liệu học tập',
              themeColor: AppColors.primaryColor,
              onTap: () {
                sl<AuthBloc>().add(AuthLoggedOut());
              },
            ),
          ),
        ),
        AnimationConfiguration.staggeredList(
          position: 3,
          child: SlideAnimation(
            child: MenuItem(
              borderRadius: .zero,
              backgroundColor: Color.lerp(
                AppColors.neutralColor,
                Colors.white10,
                0.3,
              ),
              showBottomBorder: false,
              iconData: BootstrapIcons.hand_thumbs_up,
              title: 'Đánh giá ứng dụng',
              subTitle: 'Dành tặng chúng tôi sự khích lệ',
              titleUseThemeColor: true,
              themeColor: AppColors.accentVariantColor,
              onTap: () {},
            ),
          ),
        ),
        AnimationConfiguration.staggeredList(
          position: 4,
          child: SlideAnimation(
            child: MenuItem(
              borderRadius: BorderRadius.only(
                bottomLeft: .circular(12),
                bottomRight: .circular(12),
              ),
              backgroundColor: Color.lerp(
                AppColors.neutralColor,
                Colors.white10,
                0.3,
              ),
              iconData: BootstrapIcons.share,
              title: 'Chia sẻ ứng dụng',
              subTitle: 'Giới thiệu cho bạn bè',
              themeColor: AppColors.infoColor,
              onTap: () {},
            ),
          ),
        ),
      ],
    );
  }
}
