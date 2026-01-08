import 'package:flutter/material.dart';
import 'package:onthi_gplx_pro/core/theme/app_colors.dart';
import 'package:onthi_gplx_pro/core/widgets/radio_item.dart';

class FinishStep extends StatefulWidget {
  final bool isVisible;
  const FinishStep({super.key, this.isVisible = false});

  @override
  State<FinishStep> createState() => _FinishStepState();
}

class _FinishStepState extends State<FinishStep> {
  late final ScrollController _scrollController;
  late final double _maxHeight;
  final double _minHeight = 120;
  double _headerHeight = 0;

  void _onScroll() {
    double offset = _scrollController.offset;
    double newHeight = _maxHeight - offset;
    setState(() {
      if (newHeight < _minHeight) {
        _headerHeight = _minHeight;
      } else if (newHeight > _maxHeight) {
        _headerHeight = _maxHeight;
      } else {
        _headerHeight = newHeight;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _maxHeight = MediaQuery.sizeOf(context).height / 4;
    if (_headerHeight == 0) {
      _headerHeight = _maxHeight;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildHeader(context),
        Expanded(
          child: Container(
            decoration: const BoxDecoration(),
            child: ListView.separated(
              controller: _scrollController,
              physics: const AlwaysScrollableScrollPhysics(
                parent: BouncingScrollPhysics(),
              ),
              itemCount: 10,
              itemBuilder: (context, index) => RadioItem(),
              separatorBuilder: (BuildContext context, int index) =>
                  SizedBox(height: 16),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildContent() {
    return Column(children: List.generate(10, (index) => RadioItem()).toList());
  }

  Widget _buildHeader(BuildContext context) {
    return SizedBox(
      height: _headerHeight,
      width: double.maxFinite,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            "Mục tiêu của bạn 🎯",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
          ),
          SizedBox(height: 8),
          Text(
            "Bạn muốn thi hạng bằng lái nào?",
            style: TextStyle(fontSize: 14, color: AppColors.textSecondaryColor),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
