import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:onthi_gplx_pro/core/theme/app_colors.dart';
import 'package:onthi_gplx_pro/features/learning/presentation/widgets/styled_radio_item.dart';

class QuestionContent extends StatelessWidget {
  const QuestionContent({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> options = [
      'Xe ô tô; máy kéo; xe mô tô hai bánh; xe mô tô ba bánh; xe gắn máy; xe cơ giới dùng cho người khuyết tật và xe máy chuyên dùng; xe đạp, xe đạp máy, xe đạp điện. ',
      'Xe ô tô; rơ moóc được kéo bởi xe ô tô; sơ mi rơ moóc được kéo bởi ô tô đầu kéo; xe chở người bốn bánh có gắn động cơ; xe chở hàng bốn bánh có gắn động cơ; xe mô tô, xe gắn máy và các loại xe tương tự.',
    ];

    return Container(
      decoration: BoxDecoration(
        color: AppColors.neutralColor,
        borderRadius: .circular(16),
        border: .all(color: AppColors.primaryColor.withAlpha(50)),
      ),
      width: double.maxFinite,
      padding: const .all(16),
      child: Column(
        mainAxisSize: .min,
        children: [
          _buildHeader(),
          SizedBox(height: 8),
          _buildQuestion(),
          SizedBox(height: 8),
          _buildOptions(options),
          SizedBox(height: 8),
          _buildExplanation(),
        ],
      ),
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
                text: 'Câu 1',
                style: TextStyle(
                  fontSize: 18,
                  color: AppColors.textColor,
                  fontWeight: .w500,
                ),
                children: [
                  TextSpan(
                    text: ' / 40',
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
    return Column(
      children: [
        // Q U E S T I O N - C O N T E N T
        Text(
          'Trong nhóm các phương tiện giao thông đường bộ dưới đây, nhóm phương tiện nào là xe cơ giới? ',
          style: TextStyle(fontSize: 18, fontWeight: .bold, letterSpacing: 0.8),
        ),
        SizedBox(height: 8),
        Container(
          clipBehavior: .antiAlias,
          decoration: BoxDecoration(borderRadius: .circular(8)),
          height: 200,
          child: Image.asset('assets/images/dummy.jpg', fit: .contain),
        ),
      ],
    );
  }

  Widget _buildOptions(List<String> options) {
    return Column(
      children: List.generate(
        options.length,
        (index) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: StyledRadioItem(
            isCorrect: false,
            index: index,
            content: options[index],
            onTap: () {},
          ),
        ),
      ),
    );
  }

  Widget _buildExplanation() {
    return Container(
      child: RichText(
        text: TextSpan(
          text: 'Giải thích:',
          style: TextStyle(
            fontSize: 16,
            fontWeight: .w600,
            decoration: .underline,
          ),
          children: [
            TextSpan(
              text:
                  '   Trên đường bộ ngoài khu vực đông dân cư, đường đôi hoặc đường một chiều có từ hai làn xe cơ giới trở lên (trừ đường cao tốc), xe ô tô chở người trên 28 chỗ không kể chỗ người lái xe (trừ xe buýt); ô tô tải có trọng tải trên 3,5 tấn (trừ ô tô xi téc) được tham gia giao thông với tốc độ khai thác tối đa cho phép là 80 km/h, đảm bảo an toàn trên đường ngoài khu vực đông dân cư.',
              style: TextStyle(
                fontSize: 14,
                fontWeight: .w400,
                wordSpacing: 1.2,
                height: 1.2,
                decoration: .none,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
