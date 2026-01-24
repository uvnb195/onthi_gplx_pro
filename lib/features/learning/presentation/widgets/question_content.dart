import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:onthi_gplx_pro/core/theme/app_colors.dart';
import 'package:onthi_gplx_pro/core/widgets/index.dart';
import 'package:onthi_gplx_pro/features/learning/presentation/widgets/styled_radio_item.dart';

class OptionObject {
  final int id;
  final String content;
  final bool isCorrect;

  const OptionObject({
    required this.id,
    required this.content,
    required this.isCorrect,
  });
}

class QuestionArgs {
  final int id;
  final String? imagePath;
  final String description, explanation;
  final bool isCritical;
  final List<OptionObject> options;

  const QuestionArgs({
    required this.id,
    this.imagePath,
    required this.description,
    required this.explanation,
    required this.options,
    required this.isCritical,
  });
}

class QuestionContent extends StatefulWidget {
  final int total;
  final QuestionArgs content;
  final VoidCallback? onSelectedAnswer;
  const QuestionContent({
    super.key,
    required this.total,
    required this.content,
    this.onSelectedAnswer,
  });

  @override
  State<QuestionContent> createState() => _QuestionContentState();
}

class _QuestionContentState extends State<QuestionContent> {
  int? selectedId;
  late final ScrollController _controller;

  @override
  void initState() {
    _controller = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    return CustomScrollView(
      controller: _controller,
      physics: const AlwaysScrollableScrollPhysics(
        parent: BouncingScrollPhysics(),
      ),
      slivers: [
        SliverToBoxAdapter(child: SizedBox(height: 16)),
        SliverToBoxAdapter(
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.neutralColor,
              borderRadius: .circular(16),
              border: .all(color: AppColors.primaryColor.withAlpha(50)),
            ),
            width: double.maxFinite,
            padding: const .all(16),
            child: Column(
              mainAxisSize: .min,
              crossAxisAlignment: .start,
              children: [
                _buildHeader(),
                SizedBox(height: 8),
                _buildQuestion(),
                SizedBox(height: 24),
                _buildOptions(screenWidth),
                SizedBox(height: 24),
                _buildExplanation(),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(child: SizedBox(height: 16)),
      ],
    );
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
                text: 'Câu ${widget.content.id}',
                style: TextStyle(
                  fontSize: 18,
                  color: AppColors.textColor,
                  fontWeight: .w500,
                ),
                children: [
                  TextSpan(
                    text: ' / ${widget.total}',
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
      child: Column(
        crossAxisAlignment: .center,
        children: [
          // Q U E S T I O N - C O N T E N T
          SizedBox(
            width: double.maxFinite,
            child: Text(
              widget.content.description,
              style: TextStyle(
                fontSize: 18,
                fontWeight: .bold,
                letterSpacing: 0.8,
              ),
              textAlign: .center,
            ),
          ),
          if (widget.content.imagePath != null) ...[
            SizedBox(height: 8),
            Container(
              clipBehavior: .antiAlias,
              decoration: BoxDecoration(borderRadius: .circular(8)),
              height: 200,
              width: double.maxFinite,
              child: Image.asset('assets/images/dummy.jpg', fit: .contain),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildOptionItem(int index) {
    Color getResultColor(bool isCorrect) {
      return isCorrect ? AppColors.accentColor : AppColors.primaryColor;
    }

    return StyledSlideEntrance(
      duration: const Duration(milliseconds: 500),
      child: StyledRadioItem(
        themeColor:
            selectedId != null &&
                (selectedId == index || widget.content.options[index].isCorrect)
            ? getResultColor(widget.content.options[index].isCorrect)
            : null,
        index: index,
        content: widget.content.options[index].content,
        onTap: selectedId != null
            ? null
            : () {
                setState(() => selectedId = index);
                _scrollToBottom();
              },
      ),
    );
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_controller.hasClients) {
        _controller.animateTo(
          _controller.position.maxScrollExtent,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeOut,
        );
      }
    });
  }

  double _calculateOptionMaxHeight(double itemWidth) {
    final double padding = 12 * 4;
    final double leadingWith = 40;
    double maxHeight = 0;

    for (var option in widget.content.options) {
      final double textWidth = itemWidth - (padding + leadingWith);

      final textPainter = TextPainter(
        text: TextSpan(
          text: option.content,
          style: const TextStyle(fontSize: 14, height: 1.2, letterSpacing: 0.8),
        ),
        textDirection: TextDirection.ltr,
        maxLines: 10,
      )..layout(maxWidth: textWidth);

      double currentHeight = textPainter.size.height + padding;
      if (currentHeight > maxHeight) maxHeight = currentHeight;
    }

    return maxHeight < 55 ? 55 : maxHeight;
  }

  Widget _buildOptions(double screenWidth) {
    final bool isLargeScreen = screenWidth > 600;
    double contentPadding = 32;
    double crossAxisPadding = 16;
    double itemWidth = isLargeScreen
        ? (screenWidth - contentPadding - crossAxisPadding) / 2
        : (screenWidth - contentPadding);
    double itemHeight = _calculateOptionMaxHeight(itemWidth);

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.content.options.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: isLargeScreen ? 2 : 1,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: itemWidth / itemHeight,
      ),
      itemBuilder: (context, index) {
        return _buildOptionItem(index);
      },
    );
  }

  Widget _buildExplanation() {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 100),
      switchInCurve: Curves.easeIn,
      switchOutCurve: Curves.bounceIn,
      transitionBuilder: (child, animation) {
        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(scale: animation, child: child),
        );
      },
      child: selectedId != null
          ? KeyedSubtree(
              key: const ValueKey('explanation_visible'),
              child: Container(
                padding: const .only(top: 8),
                child: RichText(
                  text: TextSpan(
                    text: 'Giải thích:',
                    style: TextStyle(fontSize: 14, fontWeight: .w400),
                    children: [
                      TextSpan(
                        text: '  ${widget.content.explanation}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: .w500,
                          wordSpacing: 1.2,
                          height: 1.2,
                          decoration: .none,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          : const SizedBox.shrink(key: ValueKey('explanation_hidden')),
    );
  }
}
