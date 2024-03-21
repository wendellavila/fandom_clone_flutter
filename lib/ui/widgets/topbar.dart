import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:provider/provider.dart';

import 'package:fandom_clone/ui/widgets/theme_controller.dart';

class TopNavigationBar extends StatefulWidget {
  const TopNavigationBar({this.title = "Wiki Name", super.key});

  final String title;

  @override
  State<TopNavigationBar> createState() => _TopNavigationBar();
}

const double _height = 40.0;

class _TopNavigationBar extends State<TopNavigationBar> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Provider.of<ThemeController>(context, listen: true);
    return SliverBar(parentWidget: widget, context: context, themeController: themeController);
  }
}

class SliverBar extends StatelessWidget {
  const SliverBar({
    super.key,
    required this.parentWidget,
    required this.context,
    required this.themeController,
  });

  final TopNavigationBar parentWidget;
  final BuildContext context;
  final ThemeController themeController;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      backgroundColor: themeController.isThemeLight() ? const Color(0XFFFFC500) : const Color(0XFF520044),
      pinned: true,
      toolbarHeight: _height,
      expandedHeight: _height * 2,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: BottomBar(parentWidget: parentWidget, context: context, themeController: themeController),
      ),
      title: Text(
        "Fandom",
        style: TextStyle(
            color: themeController.isThemeLight() ? const Color(0XFF520044) : const Color(0XFFFFC500), fontFamily: GoogleFonts.russoOne().fontFamily),
      ),
      actions: [
        IconButton(
            visualDensity: VisualDensity.compact,
            padding: EdgeInsets.zero,
            icon: Icon(
              Icons.search_outlined,
              size: 22,
              color: themeController.isThemeLight() ? const Color(0XFF520044) : const Color(0XFFFFC500),
            ),
            onPressed: () {}),
        IconButton(
            visualDensity: VisualDensity.compact,
            padding: EdgeInsets.zero,
            icon: Icon(
              Icons.notifications_outlined,
              size: 22,
              color: themeController.isThemeLight() ? const Color(0XFF520044) : const Color(0XFFFFC500),
            ),
            onPressed: () {}),
        IconButton(
          visualDensity: VisualDensity.compact,
          padding: EdgeInsets.zero,
          icon: CircleAvatar(
            radius: 10,
            backgroundColor: themeController.isThemeLight() ? const Color(0XFF520044) : const Color(0XFFFFC500),
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
    );
  }
}

class BottomBar extends StatelessWidget {
  const BottomBar({
    super.key,
    required this.parentWidget,
    required this.context,
    required this.themeController,
  });

  final TopNavigationBar parentWidget;
  final BuildContext context;
  final ThemeController themeController;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      toolbarHeight: _height,
      title: Text(
        parentWidget.title.toUpperCase(),
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, letterSpacing: 0.5),
      ),
      actions: [
        IconButton(
            visualDensity: VisualDensity.compact,
            icon: const Icon(
              Icons.forum_outlined,
              size: 18,
            ),
            onPressed: () {}),
        DropdownButtonHideUnderline(
          child: DropdownButton2(
            customButton: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                Icons.notes_outlined,
                size: 21,
              ),
            ),
            dropdownStyleData: DropdownStyleData(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: Theme.of(context).colorScheme.primaryContainer,
              ),
            ),
            menuItemStyleData: const MenuItemStyleData(height: 35, padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0)),
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
                    Text("Main Page", style: TextStyle(fontSize: 14, color: Theme.of(context).colorScheme.onPrimaryContainer))
                  ],
                ),
              ),
              DropdownMenuItem(
                value: "theme",
                child: Row(
                  children: [
                    Icon(
                      themeController.isThemeLight() ? Icons.dark_mode_outlined : Icons.light_mode_outlined,
                      size: 16,
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      "${themeController.isThemeLight() ? "Dark" : "Light"} Theme",
                      style: TextStyle(fontSize: 14, color: Theme.of(context).colorScheme.onPrimaryContainer),
                    )
                  ],
                ),
              ),
            ],
            onChanged: (dropdownItemValue) {
              if (dropdownItemValue == "theme") {
                themeController.switchTheme();
              } else if (dropdownItemValue == "home") {}
            },
          ),
        ),
      ],
    );
  }
}
