import 'dart:convert';
import 'package:fandom_clone/model/namespace.dart';
import 'package:fandom_clone/model/page_info.dart';
import 'package:fandom_clone/ui/widgets/page_footer.dart';
import 'package:http/http.dart' as http;

import 'package:fandom_clone/ui/widgets/trending_pages.dart';
import 'package:flutter/material.dart';
import 'package:fandom_clone/model/wiki_info.dart';

import 'package:fandom_clone/ui/screens/wiki_home.dart/wiki_stats.dart';
import 'package:fandom_clone/ui/widgets/topbar.dart';
import 'package:fandom_clone/ui/widgets/wiki_footer.dart';

class WikiHomeScreen extends StatefulWidget {
  WikiHomeScreen({required this.wikiInfo, super.key});

  final WikiInfo wikiInfo;
  final PageInfo pageInfo = PageInfo(pagename: 'Main Page');

  @override
  State<WikiHomeScreen> createState() => _WikiHomeScreenState();
}

class _WikiHomeScreenState extends State<WikiHomeScreen> {
  List<PageInfo>? _pages;
  List<PageInfo> _categories = [];

  @override
  void initState() {
    super.initState();
    _loadTrendingPages();
    _loadCategories();
  }

  void _loadCategories() async {
    List<PageInfo> categories = [];

    try {
      final url =
          Uri.https("${widget.wikiInfo.prefix}.fandom.com", "/api.php", {
        "action": "parse",
        "format": "json",
        "page": widget.pageInfo.pagename,
        "origin": "*",
      });
      final response = await http.get(url);
      if (response.statusCode < 400) {
        final jsonMap = jsonDecode(response.body) as Map;
        final jsonCategories = jsonMap['parse']['categories'] as List<dynamic>;
        for (final category in jsonCategories) {
          final title = category['*'] as String;
          categories.add(PageInfo(
            pagename: title,
            namespace: Namespace.category,
          ));
        }
      }
    } catch (e) {
      debugPrint("$e");
    }
    setState(() {
      _categories = categories;
    });
  }

  void _loadTrendingPages() async {
    List<PageInfo> pages = [];

    try {
      final url =
          Uri.https("${widget.wikiInfo.prefix}.fandom.com", "/api.php", {
        "action": "query",
        "format": "json",
        "origin": "*",
        "list": "random",
        "rnnamespace": "0",
        "rnlimit": "6"
      });
      final response = await http.get(url);
      if (response.statusCode < 400) {
        final jsonMap = jsonDecode(response.body) as Map;
        final jsonPages = jsonMap['query']['random'] as List<dynamic>;
        for (final page in jsonPages) {
          final title = page['title'];
          pages.add(PageInfo(pagename: title));
        }
      }
    } catch (e) {
      debugPrint("$e");
    }
    setState(() {
      _pages = pages;
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
          WikiStats(wikiInfo: widget.wikiInfo),
          SliverPadding(
            padding: const EdgeInsets.only(bottom: 40),
            sliver: TrendingPages(
              wikiInfo: widget.wikiInfo,
              pages: _pages,
            ),
          ),
          PageFooter(
            title: widget.pageInfo.pagename,
            categories: _categories,
            wikiInfo: widget.wikiInfo,
          ),
          WikiFooter(
            wikiInfo: widget.wikiInfo,
          ),
        ],
      ),
    );
  }
}
