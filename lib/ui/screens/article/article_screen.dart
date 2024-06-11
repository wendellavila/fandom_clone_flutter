import 'package:flutter/material.dart';

import 'package:fandom_clone/ui/widgets/topbar.dart';

import 'infobox.dart';
import 'page_header.dart';

class ArticlePage extends StatefulWidget {
  final String title;
  final String wikiName;

  const ArticlePage({required this.title, required this.wikiName, super.key});
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
