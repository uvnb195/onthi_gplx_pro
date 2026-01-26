import 'package:flutter/material.dart';

class StyledHomeAppBar extends StatelessWidget {
  final String? title;
  final Widget? leading;
  final List<Widget>? actions;
  const StyledHomeAppBar({super.key, this.title, this.leading, this.actions});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: .maxFinite,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: .spaceBetween,
            mainAxisSize: .max,
            children: [
              if (leading != null) leading!,
              if (title != null) ...[Spacer(), Text(title!), Spacer()],
              if (actions != null)
                Row(mainAxisAlignment: .end, children: actions!),
            ],
          ),
        ),
      ),
    );
  }
}
