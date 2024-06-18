import 'package:fandom_clone/model/page_data.dart';
import 'package:fandom_clone/model/section_data.dart';
import 'package:fandom_clone/ui/screens/article/sections.dart';
import 'package:fandom_clone/ui/widgets/page_footer.dart';
import 'package:fandom_clone/ui/widgets/wiki_footer.dart';
import 'package:flutter/material.dart';

import 'package:fandom_clone/ui/widgets/topbar.dart';

import 'infobox.dart';
import 'page_header.dart';

class ArticlePage extends StatefulWidget {
  final String pagename;
  final String wikiName;
  final String wikiPrefix;
  late final List<SectionData> sections;

  final PageData pageData = const PageData(
    infobox: InfoboxData(
      image: "assets/img/user.png",
      fields: [
        TitleContentPair(title: "Label 1", content: "Content 1"),
      ],
    ),
    description: "Description",
    sections: [
      TitleContentPair(title: "Header 1", content: "Content 1"),
    ],
  );

  ArticlePage({
    required this.pagename,
    required this.wikiName,
    required this.wikiPrefix,
    super.key,
  }) {
    sections = pageData.sections
        .map((section) => SectionData(
              title: section.title,
              content: section.content,
            ))
        .toList();
  }
  @override
  State<ArticlePage> createState() => _ArticlePage();
}

class _ArticlePage extends State<ArticlePage> {
  void _setSectionExpanded({required int index, required bool isExpanded}) {
    setState(() {
      widget.sections[index].isExpanded = isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          const TopNavigationBar(),
          PageHeader(pagename: widget.pagename),
          Infobox(pageData: widget.pageData),
          SliverPadding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            sliver: SectionList(
              sections: widget.sections,
              setSectionExpandedCallback: _setSectionExpanded,
            ),
          ),
          PageFooter(
            title: widget.pagename,
            wikiName: widget.wikiName,
            wikiPrefix: widget.wikiPrefix,
          ),
          WikiFooter(wikiName: widget.wikiName)
        ],
      ),
    );
  }
}
