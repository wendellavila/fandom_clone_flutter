import 'package:flutter/material.dart';

import 'package:fandom_clone/ui/widgets/topbar.dart';
import 'package:fandom_clone/ui/widgets/theme_controller.dart';

class ArticlePage extends StatefulWidget {
  final ThemeController themeController;
  final String title;

  const ArticlePage(
      {this.title = "Category Name", required this.themeController, super.key});
  @override
  State<ArticlePage> createState() => _ArticlePage();
}

class _ArticlePage extends State<ArticlePage> {
  Widget _pageHeader() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Text(
              widget.title,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                    onPressed: () {},
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 2),
                          child: Icon(
                            Icons.edit_outlined,
                            size: 14,
                            color: Theme.of(context).colorScheme.onSecondary,
                          ),
                        ),
                        Text(
                          "EDIT",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: Theme.of(context).colorScheme.onSecondary),
                        ),
                      ],
                    )),
                IconButton(
                    visualDensity: VisualDensity.compact,
                    splashRadius: 20,
                    onPressed: () {},
                    icon: const Icon(
                      Icons.more_vert,
                      size: 18,
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _infobox() {
    return SliverToBoxAdapter(
        child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [Container()],
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          TopBar(themeController: widget.themeController),
          _pageHeader(),
          _infobox()
        ],
      ),
    );
  }
}
