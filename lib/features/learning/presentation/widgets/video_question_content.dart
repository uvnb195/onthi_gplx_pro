import 'package:flutter/material.dart';
import 'package:onthi_gplx_pro/core/theme/app_colors.dart';
import 'package:video_player/video_player.dart';

class VideoQuestionContent extends StatefulWidget {
  final ValueChanged<Map<String, dynamic>>? onSetFlag;
  const VideoQuestionContent({super.key, this.onSetFlag});

  @override
  State<VideoQuestionContent> createState() => _VideoQuestionContentState();
}

class _VideoQuestionContentState extends State<VideoQuestionContent> {
  int? selectedId;

  List<String> videoPlaylist = [
    'assets/videos/1.webm',
    'assets/videos/2.webm',
    'assets/videos/3.webm',
    'assets/videos/4.webm',
  ];

  VideoPlayerController? _videoPlayerController1;
  VideoPlayerController? _videoPlayerController2;

  bool _useController1 = true;
  int _currentIndex = 0;

  void _prepareNextVideo() {
    final int nextIndex = _currentIndex + 1;

    if (nextIndex >= videoPlaylist.length) return;
    if (_useController1) {
      _videoPlayerController2?.dispose();
      _videoPlayerController2 =
          VideoPlayerController.asset(videoPlaylist[nextIndex])
            ..initialize().then((_) {
              if (mounted) setState(() {});
            });
    } else {
      _videoPlayerController1?.dispose();
      _videoPlayerController1 =
          VideoPlayerController.asset(videoPlaylist[nextIndex])
            ..initialize().then((_) {
              if (mounted) setState(() {});
            });
    }
  }

  void _videoListener() {
    final activeController = _useController1
        ? _videoPlayerController1
        : _videoPlayerController2;
    if (activeController == null || !mounted) return;

    if (activeController.value.position >= activeController.value.duration) {
      _playNextVideo();
    }
  }

  void _playNextVideo() {
    final int nextIndex = _currentIndex + 1;
    if (nextIndex > videoPlaylist.length - 1) return;

    final oldController = _useController1
        ? _videoPlayerController1
        : _videoPlayerController2;
    final newActive = _useController1
        ? _videoPlayerController2
        : _videoPlayerController1;

    oldController?.removeListener(_videoListener);

    if (newActive != null && newActive.value.isInitialized) {
      setState(() {
        _currentIndex = nextIndex;
        _useController1 = !_useController1;
      });
      newActive.addListener(_videoListener);
      newActive.play();
      _prepareNextVideo();
    } else {
      newActive?.initialize().then((_) {
        if (!mounted) return;
        setState(() {
          _currentIndex = nextIndex;
          _useController1 = !_useController1;
        });
        newActive.addListener(_videoListener);
        newActive.play();
        _prepareNextVideo();
      });
    }
  }

  @override
  void initState() {
    _videoPlayerController1 =
        VideoPlayerController.asset(videoPlaylist[_currentIndex])
          ..initialize().then((_) {
            if (mounted) setState(() {});
            _videoPlayerController1?.addListener(_videoListener);
          });
    _prepareNextVideo();
    super.initState();
  }

  @override
  void dispose() {
    _videoPlayerController1?.removeListener(_videoListener);
    _videoPlayerController1?.dispose();
    _videoPlayerController2?.removeListener(_videoListener);
    _videoPlayerController2?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: () {
        final activeController = _useController1
            ? _videoPlayerController1
            : _videoPlayerController2;

        activeController?.play();
      },
      child: _buildVideoDisplay(),
    );
  }

  Widget _buildVideoDisplay() {
    final activeController = _useController1
        ? _videoPlayerController1
        : _videoPlayerController2;

    if (activeController != null && activeController.value.isInitialized) {
      return AspectRatio(
        aspectRatio: activeController.value.aspectRatio,
        child: FittedBox(
          fit: BoxFit.contain,
          child: SizedBox(
            width: activeController.value.size.width,
            height: activeController.value.size.height,
            child: VideoPlayer(activeController),
          ),
        ),
      );
    } else {
      return Center(
        child: CircularProgressIndicator(color: AppColors.primaryColor),
      );
    }
  }
}
