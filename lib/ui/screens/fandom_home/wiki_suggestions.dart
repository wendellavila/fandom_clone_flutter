import 'package:fandom_clone/ui/screens/wiki_home.dart/wiki_home_screen.dart';
import 'package:fandom_clone/ui/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:fandom_clone/model/wiki_info.dart';
import 'package:fandom_clone/config/theme_data.dart';

class WikiSuggestions extends StatelessWidget {
  const WikiSuggestions({required this.suggestions, super.key});

  final List<WikiInfo> suggestions;

  @override
  Widget build(BuildContext context) {
    return suggestions.isEmpty
        ? Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Loading(
              color: Theme.of(context).colorScheme.fandomYellow,
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
                        builder: (context) => WikiHomeScreen(
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
