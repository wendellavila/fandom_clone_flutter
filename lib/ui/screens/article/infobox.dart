import 'package:flutter/material.dart';

import 'package:fandom_clone/model/wiki_info.dart';
import 'package:fandom_clone/model/page_data.dart';

class Infobox extends StatelessWidget {
  const Infobox({
    super.key,
    required this.pageData,
    required this.wikiInfo,
  });

  final PageData? pageData;
  final WikiInfo wikiInfo;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          if (pageData != null && pageData!.infobox != null && pageData!.infobox!.image != null)
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(4),
                    ),
                    image: DecorationImage(
                      colorFilter: const ColorFilter.linearToSrgbGamma(),
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        pageData != null && pageData!.infobox != null && pageData!.infobox!.image != null ? pageData!.infobox!.image! : wikiInfo.logo,
                      ),
                    ),
                  ),
                  height: 400,
                  width: MediaQuery.of(context).size.width > 500 ? 500 : MediaQuery.of(context).size.width,
                ),
              ),
            ),
          if (pageData != null && pageData!.infobox != null && pageData!.infobox!.caption != null)
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: const BorderRadius.all(
                  Radius.circular(4),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (pageData != null && pageData!.description != null)
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 16,
                        ),
                        child: Text(pageData!.infobox!.caption!),
                      ),
                    ),
                ],
              ),
            ),
          if (pageData != null && pageData!.infobox != null && pageData!.infobox!.fields.isNotEmpty)
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: const BorderRadius.all(Radius.circular(4)),
                border: Border.all(
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Text(
                        "INFORMATION",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ),
            ),
          if (pageData != null && pageData!.infobox != null && pageData!.infobox!.fields.isNotEmpty)
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: const BorderRadius.all(Radius.circular(4)),
                border: Border.all(
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              child: Column(
                children: [
                  if (pageData != null && pageData!.infobox != null)
                    for (final entry in pageData!.infobox!.fields)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Text(
                                entry.title,
                                style: const TextStyle(
                                  letterSpacing: -0.2,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Text(
                                entry.content,
                                style: const TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w200,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
