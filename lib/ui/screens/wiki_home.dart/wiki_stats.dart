import 'package:flutter/material.dart';

import 'package:fandom_clone/model/wiki_info.dart';
import 'package:flutter/widgets.dart';

class WikiStats extends StatelessWidget {
  const WikiStats({required this.wikiInfo, super.key});

  final WikiInfo wikiInfo;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(
          top: 24,
          bottom: 40,
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                bottom: 12,
              ),
              child: Text(
                wikiInfo.name,
                style: const TextStyle(
                  fontSize: 28,
                ),
              ),
            ),
            SizedBox(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Image.network(
                  wikiInfo.logo,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
