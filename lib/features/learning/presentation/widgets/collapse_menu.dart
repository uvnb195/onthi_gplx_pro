import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:onthi_gplx_pro/core/theme/app_colors.dart';
import 'package:onthi_gplx_pro/core/widgets/menu_item.dart';
import 'package:onthi_gplx_pro/core/widgets/styled_scale_entrance.dart';

class CollapseMenu extends StatefulWidget {
  final IconData iconData;
  final String title;
  final String? subTitle;
  final double? percentage;
  final Color themeColor;
  final VoidCallback? onTap;
  const CollapseMenu({
    super.key,
    required this.iconData,
    required this.title,
    this.subTitle,
    this.percentage,
    this.themeColor = AppColors.primaryColor,
    this.onTap,
  });

  @override
  State<CollapseMenu> createState() => _CollapseMenuState();
}

class _CollapseMenuState extends State<CollapseMenu> {
  bool collapsed = true;
  final List<Map<String, dynamic>> items = [
    {
      'title': 'Câu hỏi đánh dấu',
      'subTitle': 'Học ngẫu nhiên những câu hỏi bạn đã lưu',
      'total': 23,
      'iconData': BootstrapIcons.bookmarks,
      'themeColor': Colors.deepOrange,
    },
    {
      'title': 'Câu điểm liệt',
      'subTitle':
          'Những tình huống gây mất an toàn giao thông nghiêm trọng (Sai 1 câu là đi 1 sải)',
      'total': 60,
      'iconData': BootstrapIcons.shield_lock,
      'themeColor': Colors.deepOrangeAccent,
    },
    {
      'title': 'Khái Niệm và Quy Tắc',
      'subTitle':
          'Định nghĩa cơ bản, quy tắc đi đường, tốc độ và khoảng cách an toàn.',
      'total': 60,
      'iconData': BootstrapIcons.journal_text,
      'themeColor': Colors.orange,
    },
    {
      'title': 'Văn hóa & Đạo đức',
      'subTitle':
          'Trách nhiệm của người lái xe, văn hóa ứng xử và kỹ năng sơ cứu.',
      'total': 60,
      'iconData': BootstrapIcons.people,
      'themeColor': Colors.amber,
    },
    {
      'title': 'Kỹ thuật Lái xe',
      'subTitle':
          'Cách điều khiển xe trên dốc, đường trơn, đường hầm và xử lý sự cố.',
      'total': 60,
      'iconData': BootstrapIcons.speedometer2,
      'themeColor': Colors.green,
    },
    {
      'title': 'Hệ thống Biển báo',
      'subTitle':
          'Biển báo cấm, biển nguy hiểm, biển hiệu lệnh và biển chỉ dẫn.',
      'total': 60,
      'iconData': BootstrapIcons.sign_stop,
      'themeColor': AppColors.infoColor,
    },
    {
      'title': 'Cấu Tạo và Sửa Chữa',
      'subTitle':
          'Tìm hiểu về động cơ, phanh, lốp và các bộ phận cơ bản của xe ô tô.',
      'total': 60,
      'iconData': BootstrapIcons.tools,
      'themeColor': Colors.deepPurpleAccent,
    },
    {
      'title': 'Giải thế Sa hình',
      'subTitle':
          'Quy tắc nhường đường tại ngã tư và các tình huống giao thông thực tế.',
      'total': 60,
      'iconData': BootstrapIcons.stoplights,
      'themeColor': Colors.purpleAccent,
    },
  ];
  @override
  Widget build(BuildContext context) {
    return StyledScaleEntrance(
      delayed: const Duration(milliseconds: 100),
      child: Material(
        elevation: 4,
        borderRadius: BorderRadius.circular(12),
        clipBehavior: .antiAlias,
        child: Ink(
          decoration: BoxDecoration(
            border: .all(color: widget.themeColor.withAlpha(30)),
            borderRadius: .circular(12),
            gradient: LinearGradient(
              colors: [
                Color.lerp(widget.themeColor, Colors.black, 0.9)!,
                AppColors.neutralColor,
              ],
              begin: .bottomLeft,
              end: .centerRight,
            ),
          ),
          child: InkWell(
            splashColor: widget.themeColor.withAlpha(30),
            borderRadius: .circular(12),
            onTap: () {
              setState(() {
                collapsed = !collapsed;
              });
            },
            child: Padding(
              padding: const .all(16),
              child: Column(
                children: [
                  // H E A D E R
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      children: [
                        // I C O N
                        Container(
                          decoration: BoxDecoration(
                            color: widget.themeColor.withAlpha(50),
                            borderRadius: .circular(8),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Icon(
                              widget.iconData,
                              color: widget.themeColor,
                              size: 24,
                            ),
                          ),
                        ),
                        SizedBox(width: 16),

                        // T E X T
                        Expanded(
                          child: Column(
                            crossAxisAlignment: .start,
                            children: [
                              Text(
                                widget.title,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              if (widget.subTitle != null)
                                Text(
                                  widget.subTitle!,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: AppColors.textSecondaryColor,
                                  ),
                                ),
                            ],
                          ),
                        ),

                        // C O L L A P S E - I C O N
                        SizedBox(width: 8),
                        SizedBox(
                          width: 40,
                          height: 40,
                          child: Center(
                            child: AnimatedSwitcher(
                              duration: const Duration(milliseconds: 300),
                              transitionBuilder:
                                  (Widget child, Animation<double> animation) {
                                    return ScaleTransition(
                                      scale: animation,
                                      child: child,
                                    );
                                  },
                              child: collapsed
                                  ? Icon(
                                      BootstrapIcons.chevron_down,
                                      size: 18,
                                      key: ValueKey('icon1'),
                                    )
                                  : Icon(
                                      BootstrapIcons.x_lg,
                                      size: 18,
                                      key: ValueKey('icon2'),
                                    ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // L I S T - I T E M
                  if (!collapsed) SizedBox(height: 16),
                  AnimatedSize(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOut,
                    child: collapsed
                        ? SizedBox.shrink()
                        : Column(
                            children: List.generate(items.length, (index) {
                              return AnimationConfiguration.staggeredList(
                                position: index,
                                child: SlideAnimation(
                                  duration: const Duration(milliseconds: 500),
                                  horizontalOffset: -100,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      bottom: (index == items.length - 1)
                                          ? 0
                                          : 12.0,
                                    ),
                                    child: MenuItem(
                                      themeColor: items[index]['themeColor'],
                                      onTap: () {},
                                      title: items[index]['title'],
                                      subTitle:
                                          '${items[index]['total']} câu hỏi',
                                      iconData: items[index]['iconData'],
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
