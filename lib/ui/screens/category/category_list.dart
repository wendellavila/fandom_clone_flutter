import 'package:flutter/material.dart';

import 'package:fandom_clone/model/namespace.dart';
import 'package:fandom_clone/model/category_subsection.dart';
import 'package:fandom_clone/model/wiki_info.dart';
import 'package:fandom_clone/model/page_info.dart';

import 'package:fandom_clone/ui/screens/article/article_screen.dart';
import 'package:fandom_clone/ui/screens/category/category_screen.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({
    super.key,
    required this.subsections,
    required this.wikiInfo,
  });

  final List<CategorySubsection> subsections;
  final WikiInfo wikiInfo;

  int get pagecount => subsections.fold(0, (value, element) => value + element.pages.length);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Text(
            "All items ($pagecount)",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Theme(
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
            child: Column(
              children: [
                for (int panelIndex = 0; panelIndex < subsections.length; panelIndex++)
                  ExpansionTile(
                    title: Text(
                      subsections[panelIndex].title,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    initiallyExpanded: true,
                    children: subsections[panelIndex]
                        .pages
                        .map(
                          (page) => CategoryListContentItem(
                            wikiInfo: wikiInfo,
                            pageInfo: page,
                          ),
                        )
                        .toList(),
                  )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class CategoryListContentItem extends StatelessWidget {
  const CategoryListContentItem({
    super.key,
    required this.wikiInfo,
    required this.pageInfo,
  });

  final WikiInfo wikiInfo;
  final PageInfo pageInfo;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
        child: TextButton(
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(
              horizontal: 4,
              vertical: 10,
            ),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            alignment: Alignment.centerLeft,
            minimumSize: Size.zero,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.zero),
            ),
          ),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => pageInfo.namespace == Namespace.category
                  ? CategoryScreen(
                      pageInfo: pageInfo,
                      wikiInfo: wikiInfo,
                    )
                  : ArticleScreen(
                      pageInfo: pageInfo,
                      wikiInfo: wikiInfo,
                    ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 4,
              horizontal: 2,
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.filter_none_outlined,
                  size: 18,
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: Text(
                    pageInfo.toString(),
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.onSecondary,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
