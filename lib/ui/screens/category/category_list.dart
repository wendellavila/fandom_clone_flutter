import 'package:flutter/material.dart';

import 'package:fandom_clone/model/namespace.dart';
import 'package:fandom_clone/model/category_subsection.dart';
import 'package:fandom_clone/model/wiki_info.dart';

import 'package:fandom_clone/ui/screens/article/article_screen.dart';
import 'package:fandom_clone/ui/screens/category/category_screen.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({
    super.key,
    required this.subsections,
    required this.wikiInfo,
    required this.setCategoryExpandedCallback,
  });

  final List<CategorySubsection> subsections;
  final WikiInfo wikiInfo;
  final Function({
    required int index,
    required bool isExpanded,
  }) setCategoryExpandedCallback;

  int get pagecount =>
      subsections.fold(0, (value, element) => value + element.pages.length);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        constraints: const BoxConstraints(minHeight: 500),
        child: Column(
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
                data: Theme.of(context)
                    .copyWith(dividerColor: Colors.transparent),
                child: ExpansionPanelList(
                  elevation: 0,
                  expandedHeaderPadding: EdgeInsets.zero,
                  materialGapSize: 0.0,
                  expandIconColor: Theme.of(context).colorScheme.onSecondary,
                  expansionCallback: (panelIndex, isExpanded) {
                    setCategoryExpandedCallback(
                      index: panelIndex,
                      isExpanded: isExpanded,
                    );
                  },
                  children: [
                    for (int panelIndex = 0;
                        panelIndex < subsections.length;
                        panelIndex++)
                      ExpansionPanel(
                        backgroundColor: Theme.of(context).colorScheme.surface,
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
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8),
                                      child: TextButton(
                                        style: TextButton.styleFrom(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 4,
                                            vertical: 10,
                                          ),
                                          tapTargetSize:
                                              MaterialTapTargetSize.shrinkWrap,
                                          alignment: Alignment.centerLeft,
                                          minimumSize: Size.zero,
                                          shape: const RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.all(Radius.zero),
                                          ),
                                        ),
                                        onPressed: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                page.namespace ==
                                                        Namespace.category
                                                    ? CategoryScreen(
                                                        pageInfo: page,
                                                        wikiInfo: wikiInfo,
                                                      )
                                                    : ArticleScreen(
                                                        pageInfo: page,
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
                                              Text(
                                                page.toString(),
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .onSecondary,
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
                      )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
