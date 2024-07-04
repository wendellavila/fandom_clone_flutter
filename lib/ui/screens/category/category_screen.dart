import 'dart:math';
import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'package:fandom_clone/model/wiki_info.dart';
import 'package:fandom_clone/model/page_info.dart';
import 'package:fandom_clone/model/namespace.dart';
import 'package:fandom_clone/model/category_subsection.dart';

import 'package:fandom_clone/ui/screens/category/category_list.dart';
import 'package:fandom_clone/ui/widgets/page_footer.dart';
import 'package:fandom_clone/ui/widgets/wiki_footer.dart';
import 'package:fandom_clone/ui/widgets/topbar.dart';
import 'package:fandom_clone/ui/widgets/trending_pages.dart';
import 'package:fandom_clone/ui/widgets/scroll_fit.dart';
import 'package:fandom_clone/ui/widgets/page_header.dart';

class CategoryScreen extends StatefulWidget {
  final PageInfo pageInfo;
  final WikiInfo wikiInfo;

  const CategoryScreen({
    required this.pageInfo,
    required this.wikiInfo,
    super.key,
  });

  @override
  State<CategoryScreen> createState() => _CategoryScreen();
}

class _CategoryScreen extends State<CategoryScreen> {
  List<PageInfo> _pages = [];
  List<CategorySubsection> _pagesByInitial = [];

  @override
  void initState() {
    super.initState();
    _loadMembers();
  }

  void _loadMembers() async {
    List<PageInfo> pages = [];
    try {
      final url = Uri.https(widget.wikiInfo.url, "/api.php", {
        "action": "query",
        "format": "json",
        "origin": "*",
        "list": "categorymembers",
        "cmprop": "title",
        "cmtitle": widget.pageInfo.toString(),
        "cmnamespace": "0|14",
        "cmlimit": "500"
      });
      final response = await http.get(url);
      if (response.statusCode < 400) {
        final jsonMap = jsonDecode(response.body) as Map;
        final jsonPages = jsonMap['query']['categorymembers'] as List<dynamic>;
        for (final page in jsonPages) {
          final pagename = page['title'] as String;
          final namespace = Namespace.fromCode(page['ns'] as int);

          final pageInfo = PageInfo(
            pagename: pagename,
            namespace: namespace,
          );
          pages.add(pageInfo);
        }
      }
    } catch (e) {
      debugPrint("$e");
    }
    setState(() {
      _pagesByInitial = _groupPagesByInitialMinusNamespace(pages: pages);
      _pages = pages;
    });
  }

  String _stripNamespace({required String pagename}) {
    final namespaceRegex = RegExp(r'^[^:]+:');
    return pagename.replaceFirst(namespaceRegex, '');
  }

  List<CategorySubsection> _groupPagesByInitialMinusNamespace({required List<PageInfo> pages}) {
    final List<CategorySubsection> pagesByInitial = [];

    final List<String> alphabet = List.generate(
      26,
      (index) => String.fromCharCode(index + 65),
    );

    List<PageInfo> pagesStartingWithSymbol = pages
        .where(
          (PageInfo page) => !alphabet.contains(
            page.pagename[0].toUpperCase(),
          ),
        )
        .toList();

    if (pagesStartingWithSymbol.isNotEmpty) {
      pagesByInitial.add(
        CategorySubsection(
          title: '#',
          wikiInfo: widget.wikiInfo,
          isExpanded: true,
          pages: pagesStartingWithSymbol,
        ),
      );
    }

    for (String letter in alphabet) {
      List<PageInfo> pagesStartingWithLetter = pages
          .where(
            (PageInfo page) =>
                _stripNamespace(
                  pagename: page.pagename,
                )[0]
                    .toUpperCase() ==
                letter,
          )
          .toList();
      if (pagesStartingWithLetter.isNotEmpty) {
        pagesByInitial.add(CategorySubsection(
          title: letter,
          wikiInfo: widget.wikiInfo,
          isExpanded: true,
          pages: pagesStartingWithLetter,
        ));
      }
    }
    return pagesByInitial;
  }

  List<PageInfo> _getRandomSublist({required List<PageInfo> pages, required int length}) {
    pages.shuffle();
    pages = pages.sublist(0, min(length, pages.length));
    pages.sort();
    return pages;
  }

  void _setCategoryExpanded({required int index, required bool isExpanded}) {
    setState(() {
      _pagesByInitial[index].isExpanded = isExpanded;
    });
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
            PageHeader(
              pageInfo: widget.pageInfo,
            ),
            TrendingPages(
              pages: _getRandomSublist(
                  pages: _pages
                      .where(
                        (page) => page.namespace == Namespace.main,
                      )
                      .toList(),
                  length: 6),
              wikiInfo: widget.wikiInfo,
            ),
            CategoryList(
              subsections: _pagesByInitial,
              wikiInfo: widget.wikiInfo,
              setCategoryExpandedCallback: _setCategoryExpanded,
            ),
          ],
        ),
        bottomContent: Column(
          children: [
            PageFooter(
              title: widget.pageInfo.pagename,
              wikiInfo: widget.wikiInfo,
              categories: const [],
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
