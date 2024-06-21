import 'package:flutter/material.dart';
import 'package:fandom_clone/model/page_data.dart';

class Infobox extends StatelessWidget {
  const Infobox({
    super.key,
    required this.pageData,
  });

  final PageData pageData;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(4)),
                image: DecorationImage(
                  colorFilter: const ColorFilter.linearToSrgbGamma(),
                  fit: BoxFit.cover,
                  image: pageData.infobox.image != null
                      ? NetworkImage(pageData.infobox.image!)
                      : const AssetImage('assets/img/user.png') as ImageProvider,
                ),
              ),
              height: 300,
              width: MediaQuery.of(context).size.width,
            ),
            Container(
              constraints: const BoxConstraints(minHeight: 40),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: const BorderRadius.all(Radius.circular(4)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (pageData.description != null)
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                        child: Text(pageData.description!),
                      ),
                    ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: const BorderRadius.all(Radius.circular(4)),
                border: Border.all(color: Theme.of(context).colorScheme.secondary),
              ),
              child: Container(
                constraints: const BoxConstraints(minHeight: 40),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(color: Theme.of(context).colorScheme.secondary),
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
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: const BorderRadius.all(Radius.circular(4)),
                border: Border.all(color: Theme.of(context).colorScheme.secondary),
              ),
              child: Column(
                children: [
                  for (final entry in pageData.infobox.fields)
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
      ),
    );
  }
}
