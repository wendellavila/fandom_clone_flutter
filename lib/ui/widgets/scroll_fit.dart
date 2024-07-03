import 'package:flutter/material.dart';

class ScrollOrFit extends StatelessWidget {
  final Widget topContent;
  final Widget scrollableContent;
  final Widget bottomContent;

  const ScrollOrFit({
    required this.topContent,
    required this.scrollableContent,
    required this.bottomContent,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        topContent,
        SliverFillRemaining(
          hasScrollBody: false,
          child: Column(
            children: [
              Expanded(child: scrollableContent),
              bottomContent,
            ],
          ),
        ),
      ],
    );
  }
}
