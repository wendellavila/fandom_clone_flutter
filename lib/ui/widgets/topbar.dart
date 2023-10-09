import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

import 'package:fandom_clone/ui/widgets/theme_controller.dart';

class TopBar extends StatefulWidget {
  const TopBar(
      {required this.themeController, this.title = "Wiki Name", super.key});

  final String title;
  final ThemeController themeController;

  @override
  State<TopBar> createState() => _TopBar();
}

const double _height = 40.0;

class _TopBar extends State<TopBar> {
  @override
  void initState() {
    super.initState();
  }

  Widget _sliverBar() {
    return SliverAppBar(
      backgroundColor: widget.themeController.isThemeLight()
          ? const Color(0XFFFFC500)
          : const Color(0XFF520044),
      pinned: true,
      toolbarHeight: _height,
      expandedHeight: _height * 2,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: _bottomBar(),
      ),
      title: Text(
        "Fandom",
        style: TextStyle(
            color: widget.themeController.isThemeLight()
                ? const Color(0XFF520044)
                : const Color(0XFFFFC500),
            fontFamily: GoogleFonts.russoOne().fontFamily),
      ),
      actions: [
        IconButton(
            visualDensity: VisualDensity.compact,
            padding: EdgeInsets.zero,
            icon: Icon(
              Icons.search_outlined,
              size: 22,
              color: widget.themeController.isThemeLight()
                  ? const Color(0XFF520044)
                  : const Color(0XFFFFC500),
            ),
            onPressed: () {}),
        IconButton(
            visualDensity: VisualDensity.compact,
            padding: EdgeInsets.zero,
            icon: Icon(
              Icons.notifications_outlined,
              size: 22,
              color: widget.themeController.isThemeLight()
                  ? const Color(0XFF520044)
                  : const Color(0XFFFFC500),
            ),
            onPressed: () {}),
        IconButton(
          visualDensity: VisualDensity.compact,
          padding: EdgeInsets.zero,
          icon: CircleAvatar(
            radius: 10,
            backgroundColor: widget.themeController.isThemeLight()
                ? const Color(0XFF520044)
                : const Color(0XFFFFC500),
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

  Widget _bottomBar() {
    return AppBar(
      toolbarHeight: _height,
      title: Text(
        widget.title.toUpperCase(),
        style: const TextStyle(
            fontSize: 14, fontWeight: FontWeight.w600, letterSpacing: 0.5),
      ),
      actions: [
        IconButton(
            visualDensity: VisualDensity.compact,
            icon: const Icon(
              Icons.chat_bubble_outline,
              size: 18,
            ),
            onPressed: () {}),
        DropdownButtonHideUnderline(
          child: DropdownButton2(
            customButton: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                Icons.menu_outlined,
                size: 18,
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
            menuItemStyleData: const MenuItemStyleData(
                height: 35,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0)),
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
                    Text("Main Page",
                        style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context)
                                .colorScheme
                                .onPrimaryContainer))
                  ],
                ),
              ),
              DropdownMenuItem(
                value: "theme",
                child: Row(
                  children: [
                    Icon(
                      widget.themeController.isThemeLight()
                          ? Icons.dark_mode_outlined
                          : Icons.light_mode_outlined,
                      size: 16,
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      "${widget.themeController.isThemeLight() ? "Dark" : "Light"} Theme",
                      style: TextStyle(
                          fontSize: 14,
                          color:
                              Theme.of(context).colorScheme.onPrimaryContainer),
                    )
                  ],
                ),
              ),
            ],
            onChanged: (value) {
              if (value == "theme") {
                widget.themeController.switchTheme();
                setState(() {});
              } else if (value == "home") {}
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return _sliverBar();
  }
}
