import 'package:flutter/material.dart';

import 'package:fandom_clone/ui/widgets/topbar.dart';
import 'package:fandom_clone/ui/screens/article_page.dart';

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

class TrendingPages extends StatelessWidget {
  const TrendingPages({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverGrid.count(
      crossAxisCount: 2,
      children: List.generate(6, (index) {
        return Padding(
          padding: const EdgeInsets.all(10),
          child: InkWell(
            onTap: () {},
            child: Stack(
              alignment: Alignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(2),
                  child: ShaderMask(
                    shaderCallback: (rect) {
                      return const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, Color.fromARGB(120, 0, 0, 0)],
                      ).createShader(
                        Rect.fromLTRB(0, 0, rect.width, rect.height),
                      );
                    },
                    blendMode: BlendMode.multiply,
                    child: Container(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          colorFilter: ColorFilter.linearToSrgbGamma(),
                          fit: BoxFit.cover,
                          image: AssetImage("assets/img/user.png"),
                        ),
                      ),
                    ),
                  ),
                ),
                const Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: Text(
                        "Artist Name",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}

class PageHeader extends StatelessWidget {
  const PageHeader({
    super.key,
    required this.parentWidget,
    required this.context,
  });

  final CategoryPage parentWidget;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                parentWidget.title,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 5),
              child: Text(
                "Category Page",
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
            ),
            TextButton(
                onPressed: () {},
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 2),
                      child: Icon(
                        Icons.edit_outlined,
                        size: 14,
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                    ),
                    Text(
                      "EDIT",
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Theme.of(context).colorScheme.tertiary),
                    ),
                  ],
                )),
            const Row(
              children: [
                Flexible(
                    child: Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec rhoncus tempus cursus. Vivamus ultricies mi a dapibus accumsan. Cras in placerat ante. Ut lectus mauris, vehicula vehicula dui in, semper malesuada est. Quisque vel vulputate quam.",
                  textAlign: TextAlign.start,
                )),
              ],
            ),
            const Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Text(
                    "Trending pages",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
