import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:onthi_gplx_pro/core/theme/app_colors.dart';
import 'package:onthi_gplx_pro/core/widgets/index.dart';
import 'package:onthi_gplx_pro/features/learning/presentation/widgets/video_question_content.dart';
import 'package:video_player/video_player.dart';

class VideoQuestionsPage extends StatefulWidget {
  final bool isLargeScreen;
  const VideoQuestionsPage({super.key, this.isLargeScreen = false});

  @override
  State<VideoQuestionsPage> createState() => _VideoQuestionsPageState();
}

class _VideoQuestionsPageState extends State<VideoQuestionsPage> {
  final ValueNotifier<int> _currentIndexNotifier = ValueNotifier(0);
  final ValueNotifier<bool> _showNavigationBar = ValueNotifier(false);
  late VideoPlayerController _videoPlayerController1;
  late VideoPlayerController _videoPlayerController2;
  late final PageController _pageController;

  bool isLearning = false;

  @override
  void initState() {
    super.initState();
    _videoPlayerController1 =
        VideoPlayerController.asset('assets/videos/1.webm')
          ..initialize().then((_) {
            if (mounted) setState(() {});
          });

    _pageController = PageController();
    if (!widget.isLargeScreen) {
      SystemChrome.setPreferredOrientations([.landscapeLeft, .landscapeRight]);
      SystemChrome.setEnabledSystemUIMode(
        .manual,
        overlays: [SystemUiOverlay.bottom],
      );

      SystemChrome.setSystemUIChangeCallback((bool isVisible) async {
        if (isVisible) {
          _showNavigationBar.value = true;

          await Future.delayed(Duration(seconds: 3), () {
            SystemChrome.setEnabledSystemUIMode(
              .manual,
              overlays: [SystemUiOverlay.bottom],
            );

            _showNavigationBar.value = false;
          });
        }
      });
    }
  }

  @override
  void dispose() {
    _videoPlayerController1.dispose();
    _currentIndexNotifier.dispose();
    _pageController.dispose();
    super.dispose();

    if (!widget.isLargeScreen) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
      SystemChrome.setEnabledSystemUIMode(.edgeToEdge);
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.isLargeScreen
        ? _buildLargeScreenUI(context)
        : _buildMobileUI(context);
  }

  Widget _buildLargeScreenUI(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Thi mô phỏng'),
        centerTitle: true,
        shape: Border(
          bottom: BorderSide(
            color: AppColors.textSecondaryColor.withAlpha(50),
            width: 1,
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: .only(top: 8),
          width: double.maxFinite,
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: SizedBox(
                  width: double.maxFinite,
                  child: VideoQuestionContent(),
                ),
              ),
              Expanded(child: _buildContent(context)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMobileUI(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Row(
            children: [
              Expanded(
                flex: 3,
                child: _videoPlayerController1.value.isInitialized
                    ? AspectRatio(
                        aspectRatio: _videoPlayerController1.value.aspectRatio,
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: SizedBox(
                            width: _videoPlayerController1.value.size.width,
                            height: _videoPlayerController1.value.size.height,
                            child: VideoPlayer(_videoPlayerController1),
                          ),
                        ),
                      )
                    : Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primaryColor,
                        ),
                      ),
              ),
              Expanded(child: _buildContent(context)),
            ],
          ),

          // A P P - B A R
          Positioned(
            child: ValueListenableBuilder(
              valueListenable: _showNavigationBar,
              builder: (context, visible, child) {
                final statusBarHeight = MediaQuery.of(context).padding.top;
                return visible
                    ? Container(
                        padding: .only(top: statusBarHeight),
                        decoration: BoxDecoration(
                          color: AppColors.neutralColor.withAlpha(150),
                        ),
                        width: double.maxFinite,
                        height: 60 + statusBarHeight,
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: Icon(BootstrapIcons.box_arrow_left),
                            ),
                            Text(
                              'Thi mô phỏng',
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      )
                    : SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    return AnimatedSwitcher(
      switchInCurve: Curves.easeOut,
      switchOutCurve: Curves.easeIn,
      duration: const Duration(milliseconds: 500),
      transitionBuilder: (child, animation) {
        final isLearning = child.key == ValueKey('learning');
        final beginOffset = widget.isLargeScreen
            ? Offset(0, 1)
            : Offset(0, isLearning ? 1 : -1);

        final offset = Tween<Offset>(
          begin: beginOffset,
          end: .zero,
        ).animate(animation);

        return SlideTransition(position: offset, child: child);
      },
      child: isLearning == true
          ? Container(
              margin: .only(
                top: widget.isLargeScreen ? 16 : 8,
                bottom: widget.isLargeScreen ? 0 : 8,
              ),
              key: ValueKey('learning'),
              decoration: BoxDecoration(
                color: AppColors.neutralColor,
                borderRadius: .circular(16),
              ),
              padding: .symmetric(
                horizontal: widget.isLargeScreen ? 32 : 16,
                vertical: 16,
              ),
              child: widget.isLargeScreen
                  ? Wrap(
                      children: List.generate(
                        10,
                        (index) => _buildQuestionItem(
                          index,
                          itemWidth: (screenWidth - screenWidth * 0.2) / 5,
                        ),
                      ),
                    )
                  : Column(
                      mainAxisAlignment: .spaceEvenly,
                      children: List.generate(
                        10,
                        (index) => _buildQuestionItem(index),
                      ),
                    ),
            )
          : Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.backgroundColor, Colors.black],
                  begin: Alignment.topCenter,
                  end: Alignment(0, 1),
                ),
              ),
              key: ValueKey('start'),
              child: Center(
                child: StyledButton(
                  title: 'Bắt đầu',
                  suffixIcon: Icon(BootstrapIcons.play_circle_fill),
                  onPressed: () {
                    setState(() {
                      print('hello');
                      isLearning = true;
                    });
                  },
                ),
              ),
            ),
    );
  }

  Widget _buildQuestionItem(
    int index, {
    bool isAnswered = false,
    double itemWidth = double.maxFinite,
  }) {
    return Container(
      width: itemWidth,
      padding: .symmetric(vertical: 4),
      decoration: BoxDecoration(
        border: .fromLTRB(
          bottom: BorderSide(
            width: 1,
            color: AppColors.textSecondaryColor.withAlpha(50),
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: .center,
        children: [
          Expanded(
            child: Text(
              'Câu ${index + 1}:',
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
          ),
          if (isAnswered) ...[
            SizedBox(width: 16),
            Icon(
              BootstrapIcons.flag_fill,
              size: 16,
              color: AppColors.secondaryColor,
            ),
          ],
        ],
      ),
    );
  }
}
