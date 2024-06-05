import 'package:flutter/material.dart';

class Infobox extends StatelessWidget {
  const Infobox({
    super.key,
    required this.pageData,
    required this.context,
  });

  final Map<String, dynamic> pageData;
  final BuildContext context;

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
                  image: AssetImage(pageData['infobox']['image']),
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
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                      child: Text(pageData['infobox']['caption']),
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
                  for (final entry in pageData['infobox']['fields'].entries)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text(
                              entry.key.toUpperCase(),
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
                              entry.value,
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
            const Text("Header"),
          ],
        ),
      ),
    );
  }
}
