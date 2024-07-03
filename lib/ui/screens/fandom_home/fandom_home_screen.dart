import 'package:fandom_clone/ui/widgets/scroll_fit.dart';
import 'package:flutter/material.dart';

import 'package:fandom_clone/config/theme_data.dart';

import 'package:fandom_clone/ui/screens/fandom_home/wiki_browser.dart';
import 'package:fandom_clone/ui/widgets/topbar.dart';
import 'package:fandom_clone/ui/widgets/wiki_footer.dart';

class FandomHomeScreen extends StatelessWidget {
  const FandomHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScrollOrFit(
        topContent: const TopNavigationBar(),
        scrollableContent: Theme(
          data: ThemeData(
            textSelectionTheme: const TextSelectionThemeData(
              cursorColor: Colors.white,
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Theme.of(context).colorScheme.fandomPink,
                  Theme.of(context).colorScheme.fandomPurple,
                ],
              ),
            ),
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 28),
              child: WikiBrowser(),
            ),
          ),
        ),
        bottomContent: const WikiFooter(),
      ),
    );
  }
}
