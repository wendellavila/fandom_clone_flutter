import 'package:fandom_clone/ui/screens/article/article_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fandom_clone/providers/theme_notifier.dart';
import 'package:url_launcher/url_launcher.dart';

const double _height = 40.0;

const fandomYellow = Color(0XFFFFC500);
const fandomPurple = Color(0XFF520044);
const fandomPink = Color(0XFFFA005A);
const fandomPurpleTranslucent = Color.fromARGB(19, 82, 0, 68);
const fandomYellowTranslucent = Color.fromARGB(19, 255, 197, 0);

class TopNavigationBar extends StatelessWidget {
  const TopNavigationBar({
    this.title = "Wiki Name",
    super.key,
  });
  final String title;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) => SliverAppBar(
        automaticallyImplyLeading: false,
        backgroundColor: ref.read(themeNotifier).isThemeLight ? fandomYellow : fandomPurple,
        pinned: true,
        toolbarHeight: _height,
        expandedHeight: _height * 2,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(0),
          child: BottomBar(title: title, context: context),
        ),
        titleSpacing: 3,
        title: TextButton(
          onPressed: () async {
            await launchUrl(Uri.parse('https://fandom.com'));
          },
          style: ButtonStyle(
            overlayColor: WidgetStateColor.resolveWith(
              (_) => ref.watch(themeNotifier).isThemeLight ? fandomPurpleTranslucent : fandomYellowTranslucent,
            ),
          ),
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: 'Fand',
              style: TextStyle(
                  color: ref.read(themeNotifier).isThemeLight ? fandomPurple : fandomYellow,
                  fontFamily: GoogleFonts.russoOne().fontFamily,
                  fontSize: 22),
              children: const [
                TextSpan(
                  text: 'o',
                  style: TextStyle(
                    color: fandomPink,
                  ),
                ),
                TextSpan(text: 'm'),
              ],
            ),
          ),
        ),
        actions: [
          IconButton(
              visualDensity: VisualDensity.compact,
              padding: EdgeInsets.zero,
              hoverColor: ref.watch(themeNotifier).isThemeLight ? fandomPurpleTranslucent : fandomYellowTranslucent,
              highlightColor: ref.watch(themeNotifier).isThemeLight ? fandomPurpleTranslucent : fandomYellowTranslucent,
              splashColor: ref.watch(themeNotifier).isThemeLight ? fandomPurpleTranslucent : fandomYellowTranslucent,
              icon: Icon(
                Icons.search_outlined,
                size: 22,
                color: ref.watch(themeNotifier).isThemeLight ? fandomPurple : fandomYellow,
              ),
              onPressed: () {}),
          IconButton(
              visualDensity: VisualDensity.compact,
              padding: EdgeInsets.zero,
              hoverColor: ref.watch(themeNotifier).isThemeLight ? fandomPurpleTranslucent : fandomYellowTranslucent,
              highlightColor: ref.watch(themeNotifier).isThemeLight ? fandomPurpleTranslucent : fandomYellowTranslucent,
              splashColor: ref.watch(themeNotifier).isThemeLight ? fandomPurpleTranslucent : fandomYellowTranslucent,
              icon: Icon(
                Icons.notifications_outlined,
                size: 22,
                color: ref.watch(themeNotifier).isThemeLight ? fandomPurple : fandomYellow,
              ),
              onPressed: () {}),
          IconButton(
            visualDensity: VisualDensity.compact,
            padding: EdgeInsets.zero,
            hoverColor: ref.watch(themeNotifier).isThemeLight ? fandomPurpleTranslucent : fandomYellowTranslucent,
            highlightColor: ref.watch(themeNotifier).isThemeLight ? fandomPurpleTranslucent : fandomYellowTranslucent,
            splashColor: ref.watch(themeNotifier).isThemeLight ? fandomPurpleTranslucent : fandomYellowTranslucent,
            icon: CircleAvatar(
              radius: 10,
              backgroundColor: ref.watch(themeNotifier).isThemeLight ? fandomPurple : fandomYellow,
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
  const BottomBar({super.key, required this.context, required this.title});

  final BuildContext context;
  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      toolbarHeight: _height,
      title: TextButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ArticlePage(
              pagename: 'Main Page',
              wikiName: title,
            ),
          ),
        ),
        child: Text(
          title.toUpperCase(),
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
                          color: Theme.of(context).colorScheme.onPrimaryContainer,
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
                        ref.watch(themeNotifier).isThemeLight ? Icons.dark_mode_outlined : Icons.light_mode_outlined,
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
                          color: Theme.of(context).colorScheme.onPrimaryContainer,
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
