import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fandom_clone/providers/theme_notifier.dart';

const double _height = 40.0;

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
        backgroundColor: ref.read(themeNotifier).isThemeLight ? const Color(0XFFFFC500) : const Color(0XFF520044),
        pinned: true,
        toolbarHeight: _height,
        expandedHeight: _height * 2,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(0),
          child: BottomBar(title: title, context: context),
        ),
        title: Text(
          "Fandom",
          style: TextStyle(
              color: ref.read(themeNotifier).isThemeLight ? const Color(0XFF520044) : const Color(0XFFFFC500),
              fontFamily: GoogleFonts.russoOne().fontFamily),
        ),
        actions: [
          IconButton(
              visualDensity: VisualDensity.compact,
              padding: EdgeInsets.zero,
              icon: Icon(
                Icons.search_outlined,
                size: 22,
                color: ref.watch(themeNotifier).isThemeLight ? const Color(0XFF520044) : const Color(0XFFFFC500),
              ),
              onPressed: () {}),
          IconButton(
              visualDensity: VisualDensity.compact,
              padding: EdgeInsets.zero,
              icon: Icon(
                Icons.notifications_outlined,
                size: 22,
                color: ref.watch(themeNotifier).isThemeLight ? const Color(0XFF520044) : const Color(0XFFFFC500),
              ),
              onPressed: () {}),
          IconButton(
            visualDensity: VisualDensity.compact,
            padding: EdgeInsets.zero,
            icon: CircleAvatar(
              radius: 10,
              backgroundColor: ref.watch(themeNotifier).isThemeLight ? const Color(0XFF520044) : const Color(0XFFFFC500),
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
      title: Text(
        title.toUpperCase(),
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, letterSpacing: 0.5),
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
                padding: EdgeInsets.all(8.0),
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
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
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
                        style: TextStyle(fontSize: 14, color: Theme.of(context).colorScheme.onPrimaryContainer),
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
