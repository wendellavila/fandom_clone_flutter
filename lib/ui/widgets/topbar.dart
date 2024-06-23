import 'package:fandom_clone/config/theme_data.dart';
import 'package:fandom_clone/model/page_info.dart';
import 'package:fandom_clone/model/wiki_info.dart';
import 'package:fandom_clone/ui/screens/article/article_screen.dart';
import 'package:fandom_clone/ui/screens/fandom_home/fandom_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fandom_clone/providers/theme_notifier.dart';

const double _height = 40.0;

class TopNavigationBar extends StatelessWidget {
  const TopNavigationBar({
    this.wikiInfo,
    super.key,
  });
  final WikiInfo? wikiInfo;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) => SliverAppBar(
        automaticallyImplyLeading: false,
        backgroundColor: ref.read(themeNotifier).isThemeLight
            ? Theme.of(context).colorScheme.fandomYellow
            : Theme.of(context).colorScheme.fandomPurple,
        pinned: true,
        toolbarHeight: _height,
        expandedHeight: _height * (wikiInfo != null ? 2 : 1),
        bottom: wikiInfo != null
            ? PreferredSize(
                preferredSize: const Size.fromHeight(0),
                child: BottomBar(
                  wikiInfo: wikiInfo!,
                  context: context,
                ),
              )
            : null,
        titleSpacing: 3,
        title: TextButton(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const FandomHomeScreen(),
            ),
          ),
          style: ButtonStyle(
            overlayColor: WidgetStateColor.resolveWith(
              (_) => ref.watch(themeNotifier).isThemeLight
                  ? Theme.of(context).colorScheme.fandomPurpleTranslucent
                  : Theme.of(context).colorScheme.fandomYellowTranslucent,
            ),
          ),
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: 'Fand',
              style: TextStyle(
                  color: ref.read(themeNotifier).isThemeLight
                      ? Theme.of(context).colorScheme.fandomPurple
                      : Theme.of(context).colorScheme.fandomYellow,
                  fontFamily: GoogleFonts.russoOne().fontFamily,
                  fontSize: 22),
              children: [
                TextSpan(
                  text: 'o',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.fandomPink,
                  ),
                ),
                const TextSpan(text: 'm'),
              ],
            ),
          ),
        ),
        actions: [
          if (wikiInfo != null)
            IconButton(
                visualDensity: VisualDensity.compact,
                padding: EdgeInsets.zero,
                hoverColor: ref.watch(themeNotifier).isThemeLight
                    ? Theme.of(context).colorScheme.fandomPurpleTranslucent
                    : Theme.of(context).colorScheme.fandomYellowTranslucent,
                highlightColor: ref.watch(themeNotifier).isThemeLight
                    ? Theme.of(context).colorScheme.fandomPurpleTranslucent
                    : Theme.of(context).colorScheme.fandomYellowTranslucent,
                splashColor: ref.watch(themeNotifier).isThemeLight
                    ? Theme.of(context).colorScheme.fandomPurpleTranslucent
                    : Theme.of(context).colorScheme.fandomYellowTranslucent,
                icon: Icon(
                  Icons.search_outlined,
                  size: 22,
                  color: ref.watch(themeNotifier).isThemeLight
                      ? Theme.of(context).colorScheme.fandomPurple
                      : Theme.of(context).colorScheme.fandomYellow,
                ),
                onPressed: () {}),
          IconButton(
              visualDensity: VisualDensity.compact,
              padding: EdgeInsets.zero,
              hoverColor: ref.watch(themeNotifier).isThemeLight
                  ? Theme.of(context).colorScheme.fandomPurpleTranslucent
                  : Theme.of(context).colorScheme.fandomYellowTranslucent,
              highlightColor: ref.watch(themeNotifier).isThemeLight
                  ? Theme.of(context).colorScheme.fandomPurpleTranslucent
                  : Theme.of(context).colorScheme.fandomYellowTranslucent,
              splashColor: ref.watch(themeNotifier).isThemeLight
                  ? Theme.of(context).colorScheme.fandomPurpleTranslucent
                  : Theme.of(context).colorScheme.fandomYellowTranslucent,
              icon: Icon(
                Icons.notifications_outlined,
                size: 22,
                color: ref.watch(themeNotifier).isThemeLight
                    ? Theme.of(context).colorScheme.fandomPurple
                    : Theme.of(context).colorScheme.fandomYellow,
              ),
              onPressed: () {}),
          IconButton(
            visualDensity: VisualDensity.compact,
            padding: EdgeInsets.zero,
            hoverColor: ref.watch(themeNotifier).isThemeLight
                ? Theme.of(context).colorScheme.fandomPurpleTranslucent
                : Theme.of(context).colorScheme.fandomYellowTranslucent,
            highlightColor: ref.watch(themeNotifier).isThemeLight
                ? Theme.of(context).colorScheme.fandomPurpleTranslucent
                : Theme.of(context).colorScheme.fandomYellowTranslucent,
            splashColor: ref.watch(themeNotifier).isThemeLight
                ? Theme.of(context).colorScheme.fandomPurpleTranslucent
                : Theme.of(context).colorScheme.fandomYellowTranslucent,
            icon: CircleAvatar(
              radius: 10,
              backgroundColor: ref.watch(themeNotifier).isThemeLight
                  ? Theme.of(context).colorScheme.fandomPurple
                  : Theme.of(context).colorScheme.fandomYellow,
              child: Padding(
                padding: const EdgeInsets.all(2),
                child: ClipOval(
                  child: Image.asset('assets/img/user.png'),
                ),
              ),
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

class BottomBar extends StatelessWidget {
  const BottomBar({
    super.key,
    required this.context,
    required this.wikiInfo,
  });

  final BuildContext context;
  final WikiInfo wikiInfo;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      toolbarHeight: _height,
      titleSpacing: 4,
      title: TextButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ArticleScreen(
              pageInfo: PageInfo(pagename: 'Main Page'),
              wikiInfo: wikiInfo,
            ),
          ),
        ),
        child: Text(
          wikiInfo.name.toUpperCase(),
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
            color: Colors.white,
          ),
        ),
      ),
      actions: [
        IconButton(
          visualDensity: VisualDensity.compact,
          icon: const Icon(
            Icons.forum_outlined,
            size: 18,
          ),
          onPressed: () {},
        ),
        Consumer(
          builder: (context, ref, child) => DropdownButtonHideUnderline(
            child: DropdownButton2(
              onChanged: (dropdownItemValue) {
                if (dropdownItemValue == "theme") {
                  ref.read(themeNotifier.notifier).switchTheme();
                } else if (dropdownItemValue == "home") {
                  //
                }
              },
              customButton: const Padding(
                padding: EdgeInsets.all(8),
                child: Icon(
                  Icons.notes_outlined,
                  size: 21,
                ),
              ),
              dropdownStyleData: DropdownStyleData(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Theme.of(context).colorScheme.primaryContainer,
                ),
              ),
              menuItemStyleData: const MenuItemStyleData(
                height: 45,
                padding: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 0,
                ),
              ),
              items: [
                DropdownMenuItem(
                  value: "home",
                  child: Row(
                    children: [
                      Icon(
                        Icons.home_outlined,
                        size: 16,
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Main Page",
                        style: TextStyle(
                          fontSize: 14,
                          color:
                              Theme.of(context).colorScheme.onPrimaryContainer,
                        ),
                      )
                    ],
                  ),
                ),
                DropdownMenuItem(
                  value: "theme",
                  child: Row(
                    children: [
                      Icon(
                        ref.watch(themeNotifier).isThemeLight
                            ? Icons.dark_mode_outlined
                            : Icons.light_mode_outlined,
                        size: 16,
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        "${ref.watch(themeNotifier).isThemeLight ? "Dark" : "Light"} Theme",
                        style: TextStyle(
                          fontSize: 14,
                          color:
                              Theme.of(context).colorScheme.onPrimaryContainer,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
