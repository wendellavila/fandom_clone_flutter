import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TopBar extends StatefulWidget {
  const TopBar({this.title = "Wiki Name", super.key});

  final String title;

  @override
  State<TopBar> createState() => _TopBar();
}

const double _height = 40.0;

class _TopBar extends State<TopBar> {
  late Color _fandomBackgroundColor;
  late Color _fandomTextColor;

  bool _isThemeLight() {
    return Theme.of(context).brightness == Brightness.light;
  }

  Widget _sliverBar() {
    return SliverAppBar(
      backgroundColor: _fandomBackgroundColor,
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
            color: _fandomTextColor,
            fontFamily: GoogleFonts.russoOne().fontFamily),
      ),
      actions: [
        IconButton(
            visualDensity: VisualDensity.compact,
            padding: EdgeInsets.zero,
            icon: Icon(
              Icons.search_outlined,
              size: 22,
              color: _fandomTextColor,
            ),
            onPressed: () {}),
        IconButton(
            visualDensity: VisualDensity.compact,
            padding: EdgeInsets.zero,
            icon: Icon(
              Icons.notifications_outlined,
              size: 22,
              color: _fandomTextColor,
            ),
            onPressed: () {}),
        IconButton(
          visualDensity: VisualDensity.compact,
          padding: EdgeInsets.zero,
          icon: CircleAvatar(
            radius: 10,
            backgroundColor: _fandomTextColor,
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
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
      ),
      actions: [
        IconButton(
            visualDensity: VisualDensity.compact,
            icon: const Icon(
              Icons.chat_bubble_outline,
              size: 18,
            ),
            onPressed: () {}),
        IconButton(
            visualDensity: VisualDensity.compact,
            icon: const Icon(
              Icons.menu_outlined,
              size: 18,
            ),
            onPressed: () {})
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    _fandomBackgroundColor =
        _isThemeLight() ? const Color(0XFFFFC500) : const Color(0XFF520044);
    _fandomTextColor =
        _isThemeLight() ? const Color(0XFF520044) : const Color(0XFFFFC500);

    return _sliverBar();
  }
}
