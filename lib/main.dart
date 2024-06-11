import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fandom_clone/ui/screens/category/category_screen.dart';
import 'package:fandom_clone/providers/theme_notifier.dart';
import 'package:fandom_clone/config/theme_data.dart';

void main() {
  runApp(
    const ProviderScope(
      child: App(),
    ),
  );
}

class App extends ConsumerStatefulWidget {
  const App({
    super.key,
  });

  @override
  ConsumerState<App> createState() => _AppState();
}

class _AppState extends ConsumerState<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FANDOM Clone',
      theme: themeData(context: context, themeMode: ThemeMode.light),
      darkTheme: themeData(context: context, themeMode: ThemeMode.dark),
      themeMode: ref.watch(themeNotifier).theme,
      home: const CategoryPage(
        title: "Category:Browse",
        wikiName: "Wiki Name",
      ),
    );
  }
}
