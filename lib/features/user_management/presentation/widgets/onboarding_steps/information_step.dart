import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onthi_gplx_pro/core/extension/gender_type.dart';
import 'package:onthi_gplx_pro/core/theme/app_colors.dart';
import 'package:onthi_gplx_pro/core/widgets/styled_dropdown.dart';
import 'package:onthi_gplx_pro/core/widgets/styled_text_field.dart';
import 'package:onthi_gplx_pro/features/user_management/domain/value_objects/gender.dart';
import 'package:onthi_gplx_pro/features/user_management/presentation/bloc/user/user_bloc.dart';

class InformationStep extends StatefulWidget {
  final bool isVisible;
  const InformationStep({super.key, this.isVisible = false});

  @override
  State<InformationStep> createState() => _InformationStepState();
}

class _InformationStepState extends State<InformationStep>
    with SingleTickerProviderStateMixin {
  bool isShowImageButton = false;
  bool _hasAnimated = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didUpdateWidget(covariant InformationStep oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.isVisible && !_hasAnimated) {
      _startStepAnimation();
    }
  }

  void _startStepAnimation() {
    setState(() {
      _hasAnimated = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: AlwaysScrollableScrollPhysics(parent: ClampingScrollPhysics()),
      slivers: [
        SliverFillRemaining(
          child: Column(
            mainAxisAlignment: .spaceEvenly,
            mainAxisSize: .max,
            children: [_buildHeader(), _buildForm()],
          ),
        ),
      ],
    );
  }

  Widget _buildForm() {
    return BlocBuilder<UserBloc, UserFormSubmissionState>(
      buildWhen: (previous, current) =>
          previous.age != current.age ||
          previous.gender != current.gender ||
          previous.phone != current.phone,
      builder: (context, state) {
        final userBloc = context.read<UserBloc>();
        return Column(
          children: [
            Row(
              mainAxisSize: .min,
              crossAxisAlignment: .start,
              children: [
                Expanded(
                  child: StyledTextField(
                    errorText: state.ageError,
                    customLabel: "Tuổi của bạn",
                    hintText: "Vd: 18",
                    keyboardType: .numberWithOptions(),
                    onChanged: (value) => userBloc.add(AgeChanged(value)),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: StyledDropdown(
                    errorText: state.genderError,
                    options: GenderType.values
                        .map((e) => e.displayName)
                        .toList(),
                    customLabel: 'Giới tính',
                    onChanged: (value) {
                      userBloc.add(
                        GenderChanged(GenderTypeExt.fromString(value)),
                      );
                    },
                  ),
                ),
              ],
            ),
            StyledTextField(
              onChanged: (value) => userBloc.add(PhoneChanged(value)),
              customLabel: "Số điện thoại",
              hintText: "Vd: 0123456789",
              errorText: state.phoneError,
              keyboardType: .phone,
              prefix: Icon(BootstrapIcons.telephone, size: 20),
            ),
          ],
        );
      },
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Text(
          "Thông tin cá nhân 📜",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
        ),
        SizedBox(height: 8),
        Text(
          "Hoàn thiện hồ sơ để trải nghiệm tốt hơn.",
          style: TextStyle(fontSize: 14, color: AppColors.textSecondaryColor),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
