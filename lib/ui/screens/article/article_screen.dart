import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:fandom_clone/ui/screens/article/sections.dart';
import 'package:fandom_clone/ui/widgets/page_footer.dart';
import 'package:fandom_clone/ui/widgets/wiki_footer.dart';
import 'package:fandom_clone/ui/widgets/topbar.dart';

import 'package:fandom_clone/model/page_data.dart';
import 'package:fandom_clone/model/page_info.dart';
import 'package:fandom_clone/model/section_data.dart';
import 'package:fandom_clone/model/wiki_info.dart';

import 'infobox.dart';
import 'page_header.dart';

class ArticleScreen extends StatefulWidget {
  final PageInfo pageInfo;
  final WikiInfo wikiInfo;

  const ArticleScreen({
    required this.pageInfo,
    required this.wikiInfo,
    super.key,
  });
  @override
  State<ArticleScreen> createState() => _ArticleScreen();
}

class _ArticleScreen extends State<ArticleScreen> {
  PageData? pageData;
  List<SectionData> sections = [];

  @override
  void initState() {
    super.initState();
    _loadContent();
  }

  void _loadContent() async {
    try {
      final url = Uri.https(widget.wikiInfo.url, "/api.php", {
        "action": "parse",
        "format": "json",
        "origin": "*",
        "page": widget.pageInfo.toString(),
      });
      final response = await http.get(url);
      if (response.statusCode < 400) {
        pageData = PageData.fromJson(response.body);
        sections = pageData != null
            ? pageData!.sections
                .map(
                  (section) => SectionData(
                    title: section.title,
                    content: section.content,
                    isExpanded: true,
                  ),
                )
                .toList()
            : [];
      }
    } catch (e) {
      debugPrint("$e");
    }
    setState(() {});
  }

  void _setSectionExpanded({required int index, required bool isExpanded}) {
    setState(() {
      sections[index].isExpanded = isExpanded;
      sections[index].isExpanded = isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          TopNavigationBar(
            wikiInfo: widget.wikiInfo,
          ),
          PageHeader(pagename: widget.pageInfo.pagename),
          if (pageData != null && pageData!.infobox != null)
            Infobox(
              pageData: pageData,
              wikiInfo: widget.wikiInfo,
            ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            sliver: SectionList(
              sections: sections,
              setSectionExpandedCallback: _setSectionExpanded,
            ),
          ),
          PageFooter(
            title: widget.pageInfo.pagename,
            categories: pageData != null ? pageData!.categories : [],
            wikiInfo: widget.wikiInfo,
          ),
          WikiFooter(wikiInfo: widget.wikiInfo)
        ],
      ),
    );
  }
}
