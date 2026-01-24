import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:onthi_gplx_pro/core/theme/app_colors.dart';
import 'package:onthi_gplx_pro/core/widgets/index.dart';
import 'package:video_player/video_player.dart';

class VideoQuestionContent extends StatefulWidget {
  final int total;
  final VoidCallback? onTap;
  const VideoQuestionContent({super.key, required this.total, this.onTap});

  @override
  State<VideoQuestionContent> createState() => _VideoQuestionContentState();
}

class _VideoQuestionContentState extends State<VideoQuestionContent> {
  int? selectedId;
  late final ScrollController _scrollController;

  late final VideoPlayerController _videoPlayerController;

  @override
  void initState() {
    _scrollController = ScrollController();

    _videoPlayerController = VideoPlayerController.asset('assets/videos/1.webm')
      ..initialize().then((_) {
        if (mounted) setState(() {});
      })
      ..setLooping(true);
    // ..play();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _videoPlayerController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(
        parent: BouncingScrollPhysics(),
      ),
      child: SizedBox(
        height: double.maxFinite,
        child: Column(
          mainAxisAlignment: .start,
          children: [
            _buildHeader(),
            _buildQuestion(),
            SizedBox(height: 16),
            StyledButton(
              title: 'Bắt đầu',
              suffixIcon: Icon(BootstrapIcons.play_circle_fill, size: 28),
            ),
          ],
        ),
      ),
    );

    // CustomScrollView(
    //   controller: _scrollController,
    //   physics: const AlwaysScrollableScrollPhysics(
    //     parent: BouncingScrollPhysics(),
    //   ),
    //   slivers: [
    //     SliverToBoxAdapter(child: SizedBox(height: 16)),
    //     SliverToBoxAdapter(
    //       child: Container(
    //         decoration: BoxDecoration(
    //           color: AppColors.neutralColor,
    //           borderRadius: .circular(16),
    //           border: .all(color: AppColors.primaryColor.withAlpha(50)),
    //         ),
    //         width: double.maxFinite,
    //         child: Column(
    //           mainAxisSize: .min,
    //           crossAxisAlignment: .start,
    //           children: [
    //             Padding(
    //               padding: const EdgeInsets.symmetric(horizontal: 16),
    //               child: _buildHeader(),
    //             ),
    //             SizedBox(height: 8),
    //             Padding(
    //               padding: const EdgeInsets.symmetric(horizontal: 16),
    //               child: _buildQuestion(),
    //             ),
    //             SizedBox(height: 24),
    //             _buildVideoSection(screenWidth),
    //             SizedBox(height: 24),
    //             Padding(
    //               padding: const EdgeInsets.all(8.0),
    //               child: StyledButton(width: double.maxFinite, title: 'Dừng'),
    //             ),
    //           ],
    //         ),
    //       ),
    //     ),
    //     SliverToBoxAdapter(child: SizedBox(height: 16)),
    //   ],
    // );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisSize: .min,
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            color: AppColors.backgroundColor,
            borderRadius: .circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
            child: RichText(
              text: TextSpan(
                text: 'Câu 1',
                style: TextStyle(
                  fontSize: 18,
                  color: AppColors.textColor,
                  fontWeight: .w500,
                ),
                children: [
                  TextSpan(
                    text: ' / 20',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.textSecondaryColor,
                      fontWeight: .w300,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(child: SizedBox.shrink()),
        IconButton(
          onPressed: () {},
          icon: Icon(BootstrapIcons.bookmark, size: 20),
        ),
      ],
    );
  }

  Widget _buildQuestion() {
    return StyledSlideEntrance(
      from: .TOP,
      duration: const Duration(milliseconds: 500),
      child:
          // Q U E S T I O N - C O N T E N T
          SizedBox(
            width: double.maxFinite,
            child: Text(
              'Tình huống: Người đi bộ sang đường bị khấu sau xe tải',
              style: TextStyle(
                fontSize: 18,
                fontWeight: .bold,
                letterSpacing: 0.8,
              ),
              textAlign: .center,
            ),
          ),
    );
  }

  Widget _buildVideoSection(double screenWidth) {
    return Padding(
      padding: screenWidth > 600
          ? EdgeInsets.symmetric(horizontal: screenWidth * 0.1)
          : .zero,
      child: AspectRatio(
        aspectRatio: _videoPlayerController.value.aspectRatio,
        child: _videoPlayerController.value.isInitialized
            ? Stack(
                children: [
                  VideoPlayer(_videoPlayerController),

                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: _buildIndicator(),
                  ),
                ],
              )
            : Center(
                child: CircularProgressIndicator(color: AppColors.primaryColor),
              ),
      ),
    );
  }

  Widget _buildIndicator() {
    return ValueListenableBuilder(
      valueListenable: _videoPlayerController,
      builder: (context, value, child) {
        final total = value.duration.inMilliseconds.toDouble();
        final current = value.position.inMilliseconds.toDouble();
        final progress = (total > 0) ? (current / total) : 0.0;

        return LinearProgressIndicator(
          value: progress,
          minHeight: 10,
          color: AppColors.primaryColor.withAlpha(100),
        );
      },
    );
  }
}
