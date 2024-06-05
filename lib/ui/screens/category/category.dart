import 'package:flutter/material.dart';

import 'package:fandom_clone/ui/widgets/topbar.dart';

import 'category_list.dart';
import 'page_header.dart';
import 'trending_pages.dart';

class CategoryPage extends StatefulWidget {
  final String title;

  const CategoryPage({this.title = "Category Name", super.key});

  @override
  State<CategoryPage> createState() => _CategoryPage();
}

class _CategoryPage extends State<CategoryPage> {
  final List<String> _categoryNames = ["A Test", "A2", "B Test", "b 123", "#def", "*ijk"];
  late List<Map> _categoriesByInitial;

  @override
  void initState() {
    super.initState();
    _categoriesByInitial = _getCategoriesByInitial(_categoryNames);
  }

  List<Map> _getCategoriesByInitial(List<String> categoryList) {
    final List<Map> categoriesByInitial = [];

    final List<String> alphabet = List.generate(26, (index) => String.fromCharCode(index + 65));

    List categoriesStartingWithSymbol = categoryList.where((String element) => !alphabet.contains(element[0].toUpperCase())).toList();

    if (categoriesStartingWithSymbol.isNotEmpty) {
      categoriesByInitial.add({'title': '#', 'isExpanded': true, 'pages': categoriesStartingWithSymbol});
    }

    for (String letter in alphabet) {
      List categoriesStartingWithLetter = categoryList.where((String element) => element[0].toUpperCase() == letter).toList();
      if (categoriesStartingWithLetter.isNotEmpty) {
        categoriesByInitial.add({'title': letter, 'isExpanded': true, 'pages': categoriesStartingWithLetter});
      }
    }
    return categoriesByInitial;
  }

  void setCategoryExpanded({required int index, required bool isExpanded}) {
    setState(() {
      _categoriesByInitial[index]['isExpanded'] = isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          const TopNavigationBar(),
          PageHeader(context: context, parentWidget: widget),
          const TrendingPages(),
          CategoryList(
            categoryNames: _categoryNames,
            categoriesByInitial: _categoriesByInitial,
            parentWidget: widget,
            setCategoryExpandedCallback: setCategoryExpanded,
          ),
        ],
      ),
    );
  }
}
