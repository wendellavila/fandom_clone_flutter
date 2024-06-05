import 'package:fandom_clone/ui/screens/article/article.dart';
import 'package:fandom_clone/ui/screens/category/category.dart';
import 'package:flutter/material.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({
    super.key,
    required this.categoryNames,
    required this.categoriesByInitial,
    required this.parentWidget,
    required this.setCategoryExpandedCallback,
  });

  final List<String> categoryNames;
  final List<Map> categoriesByInitial;
  final CategoryPage parentWidget;
  final Function({
    required int index,
    required bool isExpanded,
  }) setCategoryExpandedCallback;

  @override
  Widget build(BuildContext context) {
    return SliverMainAxisGroup(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              "All items (${categoryNames.length})",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, panelIndex) {
              return ExpansionPanelList(
                expandedHeaderPadding: EdgeInsets.zero,
                expandIconColor: Theme.of(context).colorScheme.onSecondary,
                expansionCallback: (_, isExpanded) {
                  setCategoryExpandedCallback(index: panelIndex, isExpanded: isExpanded);
                },
                children: [
                  ExpansionPanel(
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    isExpanded: categoriesByInitial[panelIndex]['isExpanded'],
                    headerBuilder: (context, isExpanded) {
                      return ListTile(
                        style: ListTileStyle.list,
                        title: Text(categoriesByInitial[panelIndex]['title']),
                      );
                    },
                    body: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (final pageName in categoriesByInitial[panelIndex]['pages'])
                            Align(
                              alignment: Alignment.topLeft,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.filter_none_outlined,
                                      size: 18,
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    TextButton(
                                      style: TextButton.styleFrom(
                                        padding: EdgeInsets.zero,
                                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                        alignment: Alignment.centerLeft,
                                        minimumSize: Size.zero,
                                      ),
                                      onPressed: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ArticlePage(title: pageName),
                                        ),
                                      ),
                                      child: Text(
                                        pageName,
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Theme.of(context).colorScheme.onSecondary,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
            childCount: categoriesByInitial.length,
          ),
        ),
      ],
    );
  }
}
