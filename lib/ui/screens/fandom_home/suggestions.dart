import 'package:fandom_clone/model/namespace.dart';
import 'package:fandom_clone/model/page_info.dart';
import 'package:fandom_clone/ui/screens/category/category_screen.dart';
import 'package:flutter/material.dart';
import 'package:fandom_clone/model/wiki_info.dart';
import 'package:fandom_clone/config/theme_data.dart';

class Suggestions extends StatelessWidget {
  const Suggestions({required this.suggestions, super.key});

  final List<WikiInfo> suggestions;

  @override
  Widget build(BuildContext context) {
    return suggestions.isEmpty
        ? Padding(
            padding: const EdgeInsets.only(top: 10),
            child: SizedBox(
              height: 20,
              width: 20,
              child: Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.fandomYellow,
                  strokeWidth: 2,
                ),
              ),
            ),
          )
        : Wrap(
            children: [
              for (var suggestion in suggestions)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: OutlinedButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CategoryPage(
                          pageInfo: PageInfo(
                            pagename: "Category:Browse",
                            namespace: Namespace.category,
                          ),
                          wikiInfo: suggestion,
                        ),
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(
                        width: 1.0,
                        color: Theme.of(context).colorScheme.fandomYellow,
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    child: Text(
                      suggestion.name,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.fandomYellow,
                      ),
                    ),
                  ),
                ),
            ],
          );
  }
}
