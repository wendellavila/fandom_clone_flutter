import 'package:flutter/material.dart';

import 'package:fandom_clone/model/wiki_info.dart';

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
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: SizedBox(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: Image.network(
                    wikiInfo.logo,
                  ),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.symmetric(
                  horizontal: BorderSide(
                    color: Theme.of(context).colorScheme.primaryContainer,
                  ),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  StatsItem(
                    quantity: wikiInfo.statistics.articleCount,
                    label: 'PAGES',
                  ),
                  StatsItem(
                    quantity: wikiInfo.statistics.imageCount,
                    label: 'PHOTOS',
                  ),
                  StatsItem(
                    quantity: wikiInfo.statistics.editCount,
                    label: 'EDITS',
                  ),
                  StatsItem(
                    quantity: wikiInfo.statistics.activeUserCount,
                    label: 'USERS',
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class StatsItem extends StatelessWidget {
  const StatsItem({
    required this.quantity,
    required this.label,
    super.key,
  });

  final int quantity;
  final String label;

  String _thousandsToK(int number) {
    int thousands = number ~/ 1000;
    return thousands > 0 ? "${thousands}K" : "$number";
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 12,
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 11,
              ),
            ),
          ),
          Text(
            _thousandsToK(
              quantity,
            ),
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}
