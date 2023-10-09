import 'package:flutter/material.dart';

import 'package:fandom_clone/ui/widgets/topbar.dart';
import 'package:fandom_clone/ui/widgets/theme_controller.dart';

class CategoryPage extends StatefulWidget {
  final ThemeController themeController;

  const CategoryPage({required this.themeController, super.key});

  @override
  State<CategoryPage> createState() => _CategoryPage();
}

class _CategoryPage extends State<CategoryPage> {
  Widget _body() {
    return const Column();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          TopBar(themeController: widget.themeController),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Container(
                  color: index.isOdd ? Colors.white : Colors.black12,
                  height: 100.0,
                  child: Center(
                    child: Text('$index', textScaleFactor: 5),
                  ),
                );
              },
              childCount: 20,
            ),
          ),
        ],
      ),
    );
  }
}
