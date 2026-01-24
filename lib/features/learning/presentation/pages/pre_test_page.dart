import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:onthi_gplx_pro/core/theme/app_colors.dart';
import 'package:onthi_gplx_pro/features/learning/presentation/widgets/styled_question_page_bottom.dart';
import 'package:onthi_gplx_pro/features/learning/presentation/widgets/styled_toggle_button.dart';
import 'package:onthi_gplx_pro/features/progress/presentation/widgets/info_card.dart';

class PreTestPage extends StatelessWidget {
  final String title;
  final IconData iconData;
  final Color themeColor;
  final String? description;
  final List<Map<String, dynamic>> stats;
  final int categoryId; // 0 which mean do a test
  const PreTestPage({
    super.key,
    required this.title,
    required this.iconData,
    required this.themeColor,
    this.description,
    this.stats = const [],
    this.categoryId = 0,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyActions: false,
        shape: Border(
          bottom: BorderSide(
            color: AppColors.textSecondaryColor.withAlpha(50),
            width: 1,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics(),
          ),
          child: Column(
            children: [
              _buildHeader(),
              SizedBox(height: 16),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: _buildMode(screenWidth),
              ),
              SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: _buildExplanation(),
              ),

              SizedBox(height: 40),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: StyledQuestionPageBottom(
            nextText: 'Bắt đầu',
            prevText: '',
            showDone: false,
            showPrev: false,
            onNext: () {},
            onPrev: () {},
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      mainAxisSize: .min,
      children: [
        SizedBox(height: 24),
        Container(
          decoration: BoxDecoration(
            color: themeColor,
            borderRadius: .circular(12),
          ),
          padding: .all(16),
          child: Icon(iconData, size: 40),
        ),
        SizedBox(height: 16),
        Text(
          title,
          style: TextStyle(fontSize: 28, fontWeight: .w700, letterSpacing: 1.2),
        ),
        if (description != null)
          Text(
            description!,
            style: TextStyle(
              fontSize: 16,
              fontWeight: .w400,
              color: AppColors.textSecondaryColor,
            ),
          ),
        if (stats.isNotEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: List.generate(
                stats.length,
                (index) => Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 8,
                    ),
                    child: InfoCard(
                      backgroundColor: Color.lerp(
                        themeColor,
                        Colors.black,
                        0.8,
                      )!,
                      iconData: stats[index]['iconData'],
                      title: stats[index]['title'],
                      description: stats[index]['description'],
                      descriptionStyle: const TextStyle(
                        color: AppColors.textSecondaryColor,
                        fontSize: 12,
                        fontWeight: .w400,
                      ),
                      themeColor: themeColor,
                    ),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildMode(double screenWidth) {
    return StyledToggleButton(
      themeColor: themeColor,
      size: screenWidth > 600 ? Size(400, 50) : Size(double.maxFinite, 50),
    );
  }

  Widget _buildExplanation() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.neutralColor,
        border: .all(color: AppColors.primaryColor.withAlpha(30)),
        borderRadius: .circular(12),
      ),
      padding: .all(16),
      child: Column(
        mainAxisAlignment: .start,
        crossAxisAlignment: .start,
        mainAxisSize: .min,
        children: [
          Row(
            children: [
              Icon(BootstrapIcons.exclamation_circle_fill, size: 18),
              SizedBox(width: 8),
              Text(
                'Quy tắc:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: .w500,
                  color: AppColors.textColor,
                ),
              ),
            ],
          ),
          SizedBox(height: 4),
          _buildExplanationItem(
            title: 'Số lượng',
            description:
                '10 tình huống, lấy ngẫu nhiên từ 6 chương chuẩn bộ GTVT',
          ),
          _buildExplanationItem(
            title: 'Thang điểm',
            description:
                'Mỗi tình huống có điểm tối đa là 5 điểm và tối thiểu là 0 điểm.',
          ),

          _buildExplanationItem(
            title: 'Điều kiện đạt',
            description:
                'Cần đạt tối thiểu 35/50 điểm để vượt qua phần thi này',
          ),
          _buildExplanationItem(
            title: 'Tính điểm',
            description: 'Điểm số phụ thuộc vào thời điểm thí sinh nhấn phím:',
          ),
          _buildExplanationItem(
            title: '5 điểm',
            description:
                'Nhấn ngay khi phát hiện tình huống nguy hiểm bắt đầu xuất hiện.',
            level: 1,
          ),
          _buildExplanationItem(
            title: 'Giảm dần (4-1 điểm)',
            description:
                'Số điểm sẽ giảm dần theo thời gian phản ứng của thí sinh.',
            level: 1,
          ),
          _buildExplanationItem(
            title: '0 điểm',
            description:
                'Mất điểm khi nhấn quá sớm (chưa có dấu hiệu nguy hiểm) hoặc quá muộn (tai nạn xảy ra hoặc tình huống đã kết thúc)',
            level: 1,
          ),
        ],
      ),
    );
  }

  Widget _buildExplanationItem({
    required String title,
    required String description,
    int level = 0,
  }) {
    String getHeaderChar() {
      return switch (level) {
        0 => '•',
        int() => '◦',
      };
    }

    return SizedBox(
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: level == 0 ? 0 : 16),
              child: RichText(
                text: TextSpan(
                  text: '${getHeaderChar()} $title: ',

                  style: TextStyle(fontWeight: .w500, fontSize: 16),
                  children: [
                    TextSpan(
                      text: description,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: .w400,
                        wordSpacing: 1,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
