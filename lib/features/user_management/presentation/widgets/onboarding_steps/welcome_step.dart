import 'dart:io';

import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:onthi_gplx_pro/core/theme/app_colors.dart';
import 'package:onthi_gplx_pro/core/widgets/animated_staggered_listing.dart';
import 'package:onthi_gplx_pro/core/widgets/styled_animated_sized.dart';
import 'package:onthi_gplx_pro/core/widgets/styled_button.dart';
import 'package:onthi_gplx_pro/core/widgets/styled_scale_entrance.dart';
import 'package:onthi_gplx_pro/core/widgets/styled_slide_entrance.dart';
import 'package:onthi_gplx_pro/core/widgets/styled_text_field.dart';
import 'package:onthi_gplx_pro/features/user_management/presentation/bloc/user/user_bloc.dart';

class WelcomeStep extends StatefulWidget {
  final bool isVisible;
  const WelcomeStep({super.key, this.isVisible = false});

  @override
  State<WelcomeStep> createState() => _WelcomeStepState();
}

class _WelcomeStepState extends State<WelcomeStep>
    with SingleTickerProviderStateMixin {
  final int indexCount = 3;
  int currentIndex = 0;
  bool isShowNameField = false;
  final String imagePath = 'assets/images/app_logo.png';
  File? _selectedImage;

  bool showImageButton = false;

  final List<int> animationTimings = [
    2000, //show image
    2500, //show welcome text
    1000, //show name field & select avatar button
  ];
  void _onOpenImagePicker() async {
    try {
      print("Picking... image");
      final ImagePicker picker = ImagePicker();
      final XFile? imagePicked = await picker.pickImage(
        source: ImageSource.gallery,
      );
      if (imagePicked != null) {
        setState(() {
          _selectedImage = File(imagePicked.path);
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Không thể chọn ảnh!"),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  void _onClearSelectedImage() {
    setState(() {
      _selectedImage = null;
    });
  }

  @override
  void initState() {
    super.initState();

    context.read<UserBloc>().add(Loading(true));
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: AlwaysScrollableScrollPhysics(parent: ClampingScrollPhysics()),
      slivers: [
        SliverFillRemaining(
          child: Column(
            mainAxisAlignment: .spaceEvenly,
            children: [
              _buildWelcomeText(context),
              _buildImageSelection(context),
              _buildNameField(context),
              SizedBox(height: 40),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildNameField(BuildContext context) {
    return BlocBuilder<UserBloc, UserFormSubmissionState>(
      buildWhen: (previous, current) => current.name != previous.name,
      builder: (context, state) {
        return StyledSlideEntrance(
          onEnd: () {
            context.read<UserBloc>().add(Loading(false));
          },
          from: .TOP,
          delayed: Duration(
            milliseconds: animationTimings[0] + animationTimings[1],
          ),
          duration: Duration(milliseconds: animationTimings[2]),
          child: StyledTextField(
            customLabel: "Tên của bạn là gì?",
            hintText: "Tên của bạn",
            errorText: state.nameError,
            onChanged: (v) => context.read<UserBloc>().add(NameChanged(v)),
          ),
        );
      },
    );
  }

  Widget _buildImageSelection(BuildContext context) {
    return Column(
      children: [
        // A V A T A R
        StyledScaleEntrance(
          from: 4,
          duration: Duration(milliseconds: animationTimings[0]),
          child: AnimatedContainer(
            clipBehavior: Clip.antiAlias,
            padding: EdgeInsets.all(4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: showImageButton
                    ? AppColors.primarySwatch.shade900
                    : Colors.transparent,
                width: 2,
              ), //thêm animation border
            ),
            duration: Duration(milliseconds: 1000),
            child: _selectedImage == null
                ? SizedBox(
                    width: 80,
                    height: 80,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(imagePath, fit: .contain),
                    ),
                  )
                : ClipOval(
                    child: Image.file(
                      _selectedImage!,
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
          ),
        ),
        SizedBox(height: 8),

        // B U T T O N S
        StyledAnimatedSized(
          sizeDuration: Duration(milliseconds: animationTimings[0]),
          scaleDuration: Duration(milliseconds: 500),
          isVisible: showImageButton,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              StyledButton(
                title: "Chọn ảnh đại diện",
                style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16),
                backgroundColor: AppColors.infoColor,
                height: 40,
                prefixIcon: Icon(BootstrapIcons.person_bounding_box),
                onPressed: _onOpenImagePicker,
              ),
              StyledAnimatedSized(
                isVisible: _selectedImage != null,
                child: Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: StyledButton(
                    width: 40,
                    height: 40,
                    backgroundColor: AppColors.primarySwatch.shade800,
                    prefixIcon: const Icon(BootstrapIcons.x_lg, size: 16),
                    onPressed: _onClearSelectedImage,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildWelcomeText(BuildContext context) {
    return AnimatedStaggeredListing(
      delayed: Duration(milliseconds: animationTimings[0]),
      itemDuration: Duration(milliseconds: animationTimings[1] - 500),

      onEnd: () => setState(() {
        showImageButton = true;
      }),
      interval: Duration(milliseconds: 500),
      children: [
        Text(
          "Chào mừng bạn! 👋",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
        ),
        Text(
          "Hãy bắt đầu hành trình chinh phục bằng lái xe của bạn.",
          style: TextStyle(fontSize: 14, color: AppColors.textSecondaryColor),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
