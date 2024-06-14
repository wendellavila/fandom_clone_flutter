import 'package:flutter/material.dart';
import 'package:fandom_clone/model/page_metadata.dart';

import 'package:fandom_clone/ui/screens/article/article_screen.dart';
import 'package:fandom_clone/ui/screens/category/category_screen.dart';
import 'package:fandom_clone/model/namespace.dart';

class TriangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(size.width, 0.0);
    path.lineTo(0.0, size.height);
    path.lineTo(size.width, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(TriangleClipper oldClipper) => false;
}

class PageFooter extends StatelessWidget {
  const PageFooter({this.categories = const [], required this.title, required this.wikiName, super.key});

  final List<PageMetadata> categories;
  final String title;
  final String wikiName;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          ClipPath(
            clipper: TriangleClipper(),
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceBright,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Theme.of(context).colorScheme.surfaceBright,
                  Theme.of(context).colorScheme.surface,
                ],
              ),
            ),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Text(
                    'MORE INFORMATION',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Top Contributors',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      CircleAvatar(
                        backgroundColor: Theme.of(context).colorScheme.secondary,
                        radius: 9,
                        child: const CircleAvatar(
                          backgroundImage: AssetImage('img/user.png'),
                          radius: 8,
                        ),
                      ),
                    ],
                  ),
                ),
                ExpansionTile(
                  tilePadding: const EdgeInsets.only(
                    left: 16,
                    right: 12,
                    top: 4,
                    bottom: 4,
                  ),
                  dense: true,
                  minTileHeight: 0,
                  backgroundColor: Colors.transparent,
                  title: Text(
                    'Comments (0)',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  children: [
                    SizedBox(
                      height: 200,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 12),
                            child: Text(
                              'No Comments Yet',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                          Text(
                            'Be the first to comment on $title!',
                            style: const TextStyle(fontSize: 12),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                ExpansionTile(
                  tilePadding: const EdgeInsets.only(
                    left: 16,
                    right: 12,
                    top: 4,
                    bottom: 4,
                  ),
                  dense: true,
                  minTileHeight: 0,
                  backgroundColor: Colors.transparent,
                  title: Text(
                    'Categories',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  children: [
                    Wrap(
                      runAlignment: WrapAlignment.start,
                      children: categories
                          .map((page) => TextButton(
                                child: Text(
                                  page.toString(),
                                  style: TextStyle(
                                    color: Theme.of(context).colorScheme.tertiary,
                                  ),
                                ),
                                onPressed: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => page.namespace == Namespace.category
                                        ? CategoryPage(
                                            title: page.pagename,
                                            wikiName: wikiName,
                                          )
                                        : ArticlePage(
                                            title: page.pagename,
                                            wikiName: wikiName,
                                          ),
                                  ),
                                ),
                              ))
                          .toList(),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16, top: 12, bottom: 14),
                  child: Row(
                    children: [
                      const Text(
                        'Community content is available under ',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        'CC-BY-SA',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.tertiary,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Text(
                        ' unless otherwise noted.',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
