import 'package:fandom_clone/ui/screens/article/article_screen.dart';
import 'package:fandom_clone/ui/screens/category/category_screen.dart';
import 'package:flutter/material.dart';

import '../../model/namespace.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({
    super.key,
    required this.subsections,
    required this.parentWidget,
    required this.setCategoryExpandedCallback,
  });

  final List<CategorySubsection> subsections;
  final CategoryPage parentWidget;
  final Function({
    required int index,
    required bool isExpanded,
  }) setCategoryExpandedCallback;

  int get pagecount => subsections.length;

  @override
  Widget build(BuildContext context) {
    return SliverMainAxisGroup(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              "All items ($pagecount)",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.only(bottom: 10),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, panelIndex) {
                return ExpansionPanelList(
                  elevation: 0,
                  expandedHeaderPadding: EdgeInsets.zero,
                  expandIconColor: Theme.of(context).colorScheme.onSecondary,
                  expansionCallback: (_, isExpanded) {
                    setCategoryExpandedCallback(index: panelIndex, isExpanded: isExpanded);
                  },
                  children: [
                    ExpansionPanel(
                      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                      isExpanded: subsections[panelIndex].isExpanded,
                      canTapOnHeader: true,
                      headerBuilder: (context, isExpanded) {
                        return ListTile(
                          style: ListTileStyle.list,
                          title: Text(subsections[panelIndex].title),
                        );
                      },
                      body: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: subsections[panelIndex]
                              .pages
                              .map(
                                (page) => Align(
                                  alignment: Alignment.topLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 8),
                                    child: TextButton(
                                      style: TextButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 10),
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
                                          builder: (context) => page.namespace == Namespace.category
                                              ? CategoryPage(title: page.pagename)
                                              : ArticlePage(title: page.pagename),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 2),
                                        child: Row(
                                          children: [
                                            const Icon(
                                              Icons.filter_none_outlined,
                                              size: 18,
                                            ),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            Text(
                                              page.toString(),
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Theme.of(context).colorScheme.onSecondary,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ),
                  ],
                );
              },
              childCount: subsections.length,
            ),
          ),
        ),
      ],
    );
  }
}
