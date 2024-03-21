import 'package:flutter/material.dart';

import 'package:fandom_clone/ui/widgets/topbar.dart';
import 'package:fandom_clone/ui/widgets/theme_controller.dart';

class ArticlePage extends StatefulWidget {
  final ThemeController themeController;
  final String title;

  const ArticlePage({this.title = "Category Name", required this.themeController, super.key});
  @override
  State<ArticlePage> createState() => _ArticlePage();
}

class _ArticlePage extends State<ArticlePage> {
  final Map<String, dynamic> pageData = {
    "infobox": {
      "image": "assets/img/user.png",
      "caption": "Caption",
      "fields": {
        "Label 1": "Content 1",
        "Label 2": "Content 2",
        "Label 3": "Content 3",
        "Label 4": "Content 4",
      },
    },
    "description": "description",
    "sections": {
      "Header 1": "Content 1",
      "Header 2": "Content 2",
      "Header 3": "Content 3",
      "Header 4": "Content 4",
    },
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          const TopNavigationBar(),
          PageHeader(widget: widget, context: context),
          Infobox(pageData: pageData, context: context),
        ],
      ),
    );
  }
}

class PageHeader extends StatelessWidget {
  const PageHeader({
    super.key,
    required this.widget,
    required this.context,
  });

  final ArticlePage widget;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
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
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Theme.of(context).colorScheme.onSecondary),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  visualDensity: VisualDensity.compact,
                  splashRadius: 20,
                  onPressed: () {},
                  icon: const Icon(
                    Icons.more_vert,
                    size: 18,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Infobox extends StatelessWidget {
  const Infobox({
    super.key,
    required this.pageData,
    required this.context,
  });

  final Map<String, dynamic> pageData;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(4)),
                image: DecorationImage(
                  colorFilter: const ColorFilter.linearToSrgbGamma(),
                  fit: BoxFit.cover,
                  image: AssetImage(pageData['infobox']['image']),
                ),
              ),
              height: 300,
              width: MediaQuery.of(context).size.width,
            ),
            Container(
              constraints: const BoxConstraints(minHeight: 40),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: const BorderRadius.all(Radius.circular(4)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                      child: Text(pageData['infobox']['caption']),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: const BorderRadius.all(Radius.circular(4)),
                border: Border.all(color: Theme.of(context).colorScheme.secondary),
              ),
              child: Container(
                constraints: const BoxConstraints(minHeight: 40),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(color: Theme.of(context).colorScheme.secondary),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Text(
                        "INFORMATION",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: const BorderRadius.all(Radius.circular(4)),
                border: Border.all(color: Theme.of(context).colorScheme.secondary),
              ),
              child: Column(
                children: [
                  for (final entry in pageData['infobox']['fields'].entries)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text(
                              entry.key.toUpperCase(),
                              style: const TextStyle(
                                letterSpacing: -0.2,
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Text(
                              entry.value,
                              style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w200,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
            const Text("Header"),
          ],
        ),
      ),
    );
  }
}
