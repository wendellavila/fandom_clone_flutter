import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'package:fandom_clone/model/page_data.dart';
import 'package:fandom_clone/model/page_info.dart';
import 'package:fandom_clone/model/wiki_info.dart';
import 'package:fandom_clone/model/title_content_pair.dart';

import 'package:fandom_clone/ui/widgets/scroll_fit.dart';
import 'package:fandom_clone/ui/screens/article/sections.dart';
import 'package:fandom_clone/ui/widgets/page_footer.dart';
import 'package:fandom_clone/ui/widgets/wiki_footer.dart';
import 'package:fandom_clone/ui/widgets/topbar.dart';
import 'package:fandom_clone/ui/widgets/page_header.dart';
import 'infobox.dart';

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
  List<TitleContentPair>? sections;

  @override
  void initState() {
    super.initState();
    _loadContent();
  }

  void _loadContent() async {
    try {
      final htmlUrl = Uri.https(widget.wikiInfo.url, "/api.php", {
        "action": "parse",
        "format": "json",
        "origin": "*",
        "page": widget.pageInfo.toString(),
      });
      final wikitextUrl = Uri.https(widget.wikiInfo.url, "/api.php", {
        "action": "query",
        "prop": "revisions",
        "rvprop": "content",
        "titles": widget.pageInfo.toString(),
        "rvslots": "main",
        "format": "json",
        "origin": "*",
      });
      final htmlResponse = await http.get(htmlUrl);
      final wikitextResponse = await http.get(wikitextUrl);
      if (htmlResponse.statusCode < 400) {
        pageData = PageData.parse(
          pagename: widget.pageInfo.toString(),
          htmlResponse: htmlResponse.body,
          wikitextResponse: wikitextResponse.body,
        );
        sections = pageData != null
            ? pageData!.sections
                .map(
                  (section) => TitleContentPair(
                    title: section.title,
                    content: section.content,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScrollOrFit(
        topContent: TopNavigationBar(
          wikiInfo: widget.wikiInfo,
        ),
        scrollableContent: Column(
          children: [
            PageHeader(pageInfo: widget.pageInfo),
            if (pageData != null && pageData!.infobox != null)
              Infobox(
                pageData: pageData,
                wikiInfo: widget.wikiInfo,
              ),
            if (pageData != null)
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 22,
                ),
                child: Text(pageData!.description ?? ''),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: SectionList(
                sections: sections,
              ),
            ),
          ],
        ),
        bottomContent: Column(
          children: [
            PageFooter(
              title: widget.pageInfo.pagename,
              wikiInfo: widget.wikiInfo,
              categories: pageData != null ? pageData!.categories : [],
            ),
            WikiFooter(
              wikiInfo: widget.wikiInfo,
            ),
          ],
        ),
      ),
    );
  }
}
