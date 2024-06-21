import 'package:fandom_clone/model/wiki_info.dart';
import 'package:fandom_clone/ui/screens/category/category_list.dart';
import 'package:fandom_clone/ui/widgets/page_footer.dart';
import 'package:fandom_clone/ui/widgets/wiki_footer.dart';
import 'package:flutter/material.dart';

import 'package:fandom_clone/ui/widgets/topbar.dart';

import 'package:fandom_clone/model/namespace.dart';
import 'page_header.dart';
import 'trending_pages.dart';
import 'package:fandom_clone/model/page_info.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CategorySubsection {
  final String title;
  final WikiInfo wikiInfo;
  bool isExpanded;
  final List<PageInfo> pages;

  CategorySubsection({
    required this.title,
    required this.wikiInfo,
    this.isExpanded = false,
    required this.pages,
  });
}

class CategoryPage extends StatefulWidget {
  final PageInfo pageInfo;
  final WikiInfo wikiInfo;

  const CategoryPage({
    required this.pageInfo,
    required this.wikiInfo,
    super.key,
  });

  @override
  State<CategoryPage> createState() => _CategoryPage();
}

class _CategoryPage extends State<CategoryPage> {
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
      final url = Uri.https("${widget.wikiInfo.prefix}.fandom.com", "/api.php", {
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

  List<PageInfo> _getTopPages({required List<PageInfo> pages}) {
    pages = pages
        .where((page) => page.namespace == Namespace.main)
        .map((page) => PageInfo(
              pagename: _stripNamespace(pagename: page.pagename),
              namespace: page.namespace,
            ))
        .toList();
    pages.sort();

    return pages.length > 6 ? pages.sublist(1, 7) : pages;
  }

  void _setCategoryExpanded({required int index, required bool isExpanded}) {
    setState(() {
      _pagesByInitial[index].isExpanded = isExpanded;
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
          PageHeader(context: context, title: widget.pageInfo.pagename),
          TrendingPages(
            pages: _getTopPages(pages: _pages),
            wikiInfo: widget.wikiInfo,
          ),
          CategoryList(
            subsections: _pagesByInitial,
            wikiInfo: widget.wikiInfo,
            setCategoryExpandedCallback: _setCategoryExpanded,
          ),
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
    );
  }
}
