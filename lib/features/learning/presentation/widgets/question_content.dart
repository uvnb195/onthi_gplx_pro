import 'dart:math';

import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onthi_gplx_pro/core/theme/app_colors.dart';
import 'package:onthi_gplx_pro/core/widgets/index.dart';
import 'package:onthi_gplx_pro/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:onthi_gplx_pro/features/learning/domain/entities/index.dart';
import 'package:onthi_gplx_pro/features/learning/domain/usecases/update_question_status.dart';
import 'package:onthi_gplx_pro/features/learning/presentation/bloc/learning_bloc.dart';
import 'package:onthi_gplx_pro/features/learning/presentation/widgets/styled_radio_item.dart';

class QuestionContent extends StatefulWidget {
  final int total;
  final int? index;
  final QuestionEntity question;
  final int? selectedOptionId;
  final ValueChanged<Map<String, dynamic>>? onSelectedAnswer;
  const QuestionContent({
    super.key,
    required this.total,
    this.index,
    required this.question,
    this.selectedOptionId,
    this.onSelectedAnswer,
  });

  @override
  State<QuestionContent> createState() => _QuestionContentState();
}

class _QuestionContentState extends State<QuestionContent> {
  int? selectedId;
  bool noteEditing = false;
  String? newNote;
  late final ScrollController _controller;

  @override
  void initState() {
    _controller = ScrollController();
    selectedId = widget.selectedOptionId;
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _updateQuestionStatus({
    int? optionId,
    bool? isCorrect,
    String? note,
    bool? isSaving,
  }) {
    final authState = context.read<AuthBloc>().state;

    if (authState is Authenticated) {
      final uid = authState.user.id;

      context.read<LearningBloc>().add(
        UpdateQuestionStatus(
          UpdateQuestionStatusParams(
            userId: uid,
            questionId: widget.question.id,
            isSaved: isSaving,
            isCorrect: isCorrect,
            optionId: optionId,
            note: note,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final (isSaved, noted) = context.select((LearningBloc bloc) {
      try {
        final status = bloc.state.questions
            .firstWhere((q) => q.id == widget.question.id)
            .status;
        newNote = status?.note != null && status!.note!.isNotEmpty
            ? status.note
            : null;

        return (status?.isSaved ?? false, status?.note);
      } catch (_) {
        return (false, null);
      }
    });

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
                _buildHeader(
                  isSaved,
                  onSaveToggle: () {
                    _updateQuestionStatus(isSaving: !isSaved);
                    if (!isSaved) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Đã lưu câu hỏi này!',
                            style: TextStyle(color: AppColors.textColor),
                          ),
                          backgroundColor: Color.lerp(
                            AppColors.primarySwatch.shade900,
                            Colors.black,
                            0.2,
                          ),
                          behavior: .floating,
                          duration: Duration(seconds: 2),
                          showCloseIcon: true,
                          closeIconColor: AppColors.textColor,
                        ),
                      );
                    }
                  },
                ),
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

        if (noted != null || selectedId != null)
          SliverPadding(
            padding: .symmetric(vertical: 8),
            sliver: SliverToBoxAdapter(
              child: AnimatedSize(
                duration: const Duration(milliseconds: 300),
                child: (noted != null || selectedId != null)
                    ? StyledSlideEntrance(
                        from: .TOP,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),

                          // decoration: BoxDecoration(
                          //   color: AppColors.neutralColor,
                          //   borderRadius: .circular(8),
                          //   border: .all(
                          //     color: AppColors.secondaryColor.withAlpha(50),
                          //   ),
                          // ),
                          padding: .symmetric(vertical: 4, horizontal: 4),
                          child: _buildNote(noted),
                        ),
                      )
                    : SizedBox.shrink(),
              ),
            ),
          )
        else
          SliverToBoxAdapter(child: SizedBox(height: 16)),
      ],
    );
  }

  Widget _buildHeader(bool isSaved, {required Function() onSaveToggle}) {
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
                text: 'Câu ${widget.question.id}',
                style: TextStyle(
                  fontSize: 18,
                  color: AppColors.textColor,
                  fontWeight: .w500,
                ),
                children: [
                  if (widget.index != null) ...[
                    TextSpan(
                      text: '  (${widget.index}',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.textSecondaryColor,
                        fontWeight: .w300,
                        fontStyle: .italic,
                      ),
                    ),
                    TextSpan(
                      text: '/${widget.total})',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.textSecondaryColor,
                        fontWeight: .w300,
                        fontStyle: .italic,
                      ),
                    ),
                  ] else
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
          onPressed: onSaveToggle,
          icon: Icon(
            isSaved
                ? BootstrapIcons.bookmark_check_fill
                : BootstrapIcons.bookmark_plus,
            size: 20,
            color: isSaved
                ? AppColors.primaryColor.withAlpha(200)
                : AppColors.textSecondaryColor,
          ),
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
              widget.question.content,
              style: TextStyle(
                fontSize: 18,
                fontWeight: .bold,
                letterSpacing: 0.8,
              ),
              textAlign: .center,
            ),
          ),
          if (widget.question.imageId != null) ...[
            SizedBox(height: 8),
            Container(
              clipBehavior: .antiAlias,
              decoration: BoxDecoration(borderRadius: .circular(8)),
              height: 200,
              width: double.maxFinite,
              child: Image.asset(
                'assets/images/questions/${widget.question.imageId}',
                fit: .contain,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildOptionItem(int index) {
    Color getResultColor(bool isCorrect) {
      return isCorrect
          ? AppColors.accentColor
          : AppColors.primaryColor.withAlpha(50);
    }

    final int selectedIndex = widget.question.options.indexWhere(
      (opt) => opt.id == selectedId,
    );

    return StyledSlideEntrance(
      duration: const Duration(milliseconds: 500),
      child: StyledRadioItem(
        themeColor:
            selectedId != null &&
                (selectedIndex == index ||
                    widget.question.options[index].isCorrect)
            ? getResultColor(widget.question.options[index].isCorrect)
            : null,
        index: index,
        content: widget.question.options[index].content,
        onTap: selectedId != null
            ? null
            : () {
                final selectedOptionId = widget.question.options[index].id;
                final isCorrect = widget.question.options[index].isCorrect;

                _updateQuestionStatus(
                  optionId: selectedOptionId,
                  isCorrect: isCorrect,
                );
                setState(() => selectedId = widget.question.options[index].id);
                _scrollToBottom();

                if (widget.onSelectedAnswer != null) {
                  widget.onSelectedAnswer!({
                    'selectedOptionId': selectedOptionId,
                    'isCorrect': isCorrect,
                  });
                }
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
    final double leadingWith = 60;
    double maxHeight = 0;

    for (var option in widget.question.options) {
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
      itemCount: widget.question.options.length,
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
                        text: '  ${widget.question.explanation}',
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

  Widget _buildNote(String? noted) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      switchInCurve: Curves.easeOut,
      switchOutCurve: Curves.easeIn,
      transitionBuilder: (child, animation) {
        bool isEditing = child.key == ValueKey('edit');
        final offsetAnimation = Tween<Offset>(
          begin: Offset(0, isEditing ? 0.5 : -0.5),
          end: const Offset(0, 0.0),
        ).animate(animation);

        return SlideTransition(
          position: offsetAnimation,
          child: FadeTransition(
            opacity: animation,
            child: ScaleTransition(scale: animation, child: child),
          ),
        );
      },
      child: !noteEditing
          ? noted == null
                ? Row(
                    children: [
                      Expanded(child: SizedBox.shrink()),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            noteEditing = true;
                          });
                        },
                        color: AppColors.textColor,
                        icon: Row(
                          children: [
                            Icon(BootstrapIcons.pencil, size: 20),
                            SizedBox(width: 8),
                            Text(
                              "Thêm ghi chú",
                              style: TextStyle(fontSize: 16, fontWeight: .bold),
                            ),
                          ],
                        ),
                      ),

                      Expanded(child: SizedBox.shrink()),
                    ],
                  )
                : Row(
                    key: ValueKey('show'),
                    crossAxisAlignment: .center,
                    children: [
                      Icon(BootstrapIcons.chat_right_text),
                      SizedBox(width: 8),
                      Expanded(child: Text(noted)),
                      PopupMenuButton<String>(
                        elevation: 4,
                        color: Color.lerp(
                          AppColors.backgroundColor,
                          Colors.black,
                          0.4,
                        ),
                        padding: .all(4),
                        constraints: BoxConstraints(maxWidth: 120),
                        tooltip: "Chỉnh sửa ghi chú",
                        iconColor: AppColors.textColor,
                        onSelected: (value) {
                          switch (value) {
                            case 'edit':
                              setState(() {
                                noteEditing = true;
                              });
                              return;
                            default:
                              _updateQuestionStatus(note: '/ --delete');
                              return;
                          }
                        },
                        itemBuilder: (BuildContext context) => [
                          PopupMenuItem(
                            height: 40,
                            value: 'edit',
                            child: Row(
                              children: [
                                Icon(BootstrapIcons.pen, size: 20),
                                SizedBox(width: 8),
                                Text('Chỉnh sửa'),
                              ],
                            ),
                          ),
                          PopupMenuDivider(color: AppColors.neutralColor),
                          PopupMenuItem(
                            height: 40,
                            value: 'delete',
                            child: Row(
                              children: [
                                Icon(BootstrapIcons.trash3, size: 20),
                                SizedBox(width: 8),
                                Text('Xoá'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
          : Padding(
              key: ValueKey('edit'),
              padding: const EdgeInsets.only(left: 12.0, right: 4),
              child: Row(
                crossAxisAlignment: .end,
                children: [
                  Expanded(
                    child: StyledTextField(
                      initialValue: noted,
                      onChanged: (value) => newNote = value,
                      hintText: "Ghi chú...",
                      prefix: Icon(BootstrapIcons.quote),
                      maxLines: null,
                      keyboardType: .multiline,
                    ),
                  ),
                  SizedBox(width: 8),
                  Container(
                    height: 56,
                    width: 50,
                    padding: .symmetric(vertical: 4),
                    child: IconButton(
                      style: IconButton.styleFrom(
                        backgroundColor: AppColors.secondaryColor.withAlpha(20),
                      ),
                      color: AppColors.textColor,
                      onPressed: () {
                        if (newNote != noted) {
                          _updateQuestionStatus(note: newNote);
                        }
                        setState(() {
                          noteEditing = false;
                        });
                      },
                      icon: Icon(BootstrapIcons.check_lg, size: 28),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
