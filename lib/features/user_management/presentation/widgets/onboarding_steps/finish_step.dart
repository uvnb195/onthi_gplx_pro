import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onthi_gplx_pro/core/theme/app_colors.dart';
import 'package:onthi_gplx_pro/core/widgets/radio_item.dart';
import 'package:onthi_gplx_pro/features/user_management/presentation/bloc/bloc/license_bloc.dart';
import 'package:onthi_gplx_pro/features/user_management/presentation/bloc/user/user_bloc.dart';

class FinishStep extends StatefulWidget {
  final bool isVisible;
  const FinishStep({super.key, this.isVisible = false});

  @override
  State<FinishStep> createState() => _FinishStepState();
}

class _FinishStepState extends State<FinishStep> {
  late final ScrollController _scrollController;
  final ValueNotifier<double> _headerHeightNotifier = ValueNotifier(0);
  late final double _maxHeight;
  final double _minHeight = 120;

  void _onScroll() {
    double offset = _scrollController.offset;
    _headerHeightNotifier.value = (_maxHeight - offset).clamp(
      _minHeight,
      _maxHeight,
    );
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
    _headerHeightNotifier.value = _maxHeight;
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
        BlocBuilder<LicenseBloc, LicenseState>(
          builder: (context, state) {
            return switch (state) {
              LicenseInitial() || LicenseLoading() => Expanded(
                child: Center(child: CircularProgressIndicator()),
              ),
              LicenseLoadFail() => Expanded(
                child: Center(
                  child: Text("Đã xảy ra lỗi, vui lòng thử lại sau..."),
                ),
              ),
              LicenseLoaded() => Expanded(
                child: Container(
                  decoration: const BoxDecoration(),
                  child: ListView.builder(
                    itemExtent: 100 + 16,
                    cacheExtent: 80,
                    controller: _scrollController,
                    physics: const AlwaysScrollableScrollPhysics(
                      parent: BouncingScrollPhysics(),
                    ),
                    itemCount: state.licenses.length,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: RadioItem(
                        themeColor: AppColors.primaryColor,
                        selected:
                            state.selectedLicense?.id ==
                            state.licenses[index].id,
                        title:
                            "Hạng ${state.licenses[index].code.toUpperCase()}",
                        description: state.licenses[index].description,
                        onTap: () {
                          context.read<LicenseBloc>().add(
                            SelectLicense(state.licenses[index]),
                          );
                          context.read<UserBloc>().add(
                            LicenseChanged(state.licenses[index]),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            };
          },
        ),
      ],
    );
  }

  Widget _buildHeader(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _headerHeightNotifier,
      builder: (BuildContext context, value, Widget? child) {
        return SizedBox(
          height: _headerHeightNotifier.value,
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
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.textSecondaryColor,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }
}
