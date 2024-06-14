import 'package:fandom_clone/ui/screens/category/category_list.dart';
import 'package:fandom_clone/ui/widgets/page_footer.dart';
import 'package:fandom_clone/ui/widgets/wiki_footer.dart';
import 'package:flutter/material.dart';

import 'package:fandom_clone/ui/widgets/topbar.dart';

import 'package:fandom_clone/model/namespace.dart';
import 'page_header.dart';
import 'trending_pages.dart';
import 'package:fandom_clone/model/page_metadata.dart';

class CategorySubsection {
  final String title;
  final String wikiName;
  bool isExpanded;
  final List<PageMetadata> pages;

  CategorySubsection({
    required this.title,
    required this.wikiName,
    this.isExpanded = false,
    required this.pages,
  });
}

class CategoryPage extends StatefulWidget {
  final String title;
  final String wikiName;

  const CategoryPage({required this.title, required this.wikiName, super.key});

  @override
  State<CategoryPage> createState() => _CategoryPage();
}

class _CategoryPage extends State<CategoryPage> {
  final List<PageMetadata> _pages = [
    PageMetadata(pagename: "More", namespace: Namespace.category),
    PageMetadata(pagename: "A Test"),
    PageMetadata(pagename: "A2"),
    PageMetadata(pagename: "B Test"),
    PageMetadata(pagename: "b 123"),
    PageMetadata(pagename: "°def"),
    PageMetadata(pagename: "*ijk"),
  ];
  late List<CategorySubsection> _pagesByInitial;

  @override
  void initState() {
    super.initState();
    _pagesByInitial = _groupPagesByInitialMinusNamespace(pages: _pages);
  }

  String _stripNamespace({required String pagename}) {
    final namespaceRegex = RegExp(r'^[^:]+:');
    return pagename.replaceFirst(namespaceRegex, '');
  }

  List<CategorySubsection> _groupPagesByInitialMinusNamespace({required List<PageMetadata> pages}) {
    final List<CategorySubsection> pagesByInitial = [];

    final List<String> alphabet = List.generate(
      26,
      (index) => String.fromCharCode(index + 65),
    );

    List<PageMetadata> pagesStartingWithSymbol = pages.where((PageMetadata page) => !alphabet.contains(page.pagename[0].toUpperCase())).toList();

    if (pagesStartingWithSymbol.isNotEmpty) {
      pagesByInitial.add(
        CategorySubsection(
          title: '#',
          wikiName: widget.wikiName,
          isExpanded: true,
          pages: pagesStartingWithSymbol,
        ),
      );
    }

    for (String letter in alphabet) {
      List<PageMetadata> pagesStartingWithLetter =
          pages.where((PageMetadata page) => _stripNamespace(pagename: page.pagename)[0].toUpperCase() == letter).toList();
      if (pagesStartingWithLetter.isNotEmpty) {
        pagesByInitial.add(CategorySubsection(
          title: letter,
          wikiName: widget.wikiName,
          isExpanded: true,
          pages: pagesStartingWithLetter,
        ));
      }
    }
    return pagesByInitial;
  }

  List<PageMetadata> _getTopPages({required List<PageMetadata> pages}) {
    pages = pages
        .where((page) => page.namespace == Namespace.main)
        .map((page) => PageMetadata(
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
          const TopNavigationBar(),
          PageHeader(context: context, title: widget.title),
          TrendingPages(
            pages: _getTopPages(pages: _pages),
            wikiName: widget.wikiName,
          ),
          CategoryList(
            subsections: _pagesByInitial,
            wikiName: widget.wikiName,
            setCategoryExpandedCallback: _setCategoryExpanded,
          ),
          PageFooter(
            title: widget.title,
            wikiName: widget.wikiName,
            categories: const [],
          ),
          WikiFooter(
            wikiName: widget.wikiName,
          ),
        ],
      ),
    );
  }
}
