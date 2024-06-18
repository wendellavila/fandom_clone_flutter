import 'package:fandom_clone/ui/screens/article/article_screen.dart';
import 'package:flutter/material.dart';
import 'package:fandom_clone/model/page_info.dart';

import 'package:fandom_clone/model/namespace.dart';

class TrendingPages extends StatelessWidget {
  const TrendingPages({
    this.pages = const [],
    required this.wikiName,
    required this.wikiPrefix,
    super.key,
  });

  final List<PageInfo> pages;
  final String wikiName;
  final String wikiPrefix;

  @override
  Widget build(BuildContext context) {
    return SliverMainAxisGroup(
      slivers: [
        const SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Row(
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
          ),
        ),
        SliverGrid.count(
          crossAxisCount: 2,
          children: pages
              .map(
                (page) => Padding(
                  padding: const EdgeInsets.all(10),
                  child: InkWell(
                    onTap: () {
                      if (page.namespace == Namespace.main) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ArticlePage(
                              pagename: page.pagename,
                              wikiName: wikiName,
                              wikiPrefix: wikiPrefix,
                            ),
                          ),
                        );
                      }
                    },
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
                                colors: [
                                  Colors.transparent,
                                  Color.fromARGB(120, 0, 0, 0),
                                ],
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
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(5),
                              child: Text(
                                page.toString(),
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
