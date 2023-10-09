import 'package:flutter/material.dart';

import 'package:fandom_clone/ui/widgets/topbar.dart';
import 'package:fandom_clone/ui/widgets/theme_controller.dart';

class CategoryPage extends StatefulWidget {
  final ThemeController themeController;

  const CategoryPage({required this.themeController, super.key});

  @override
  State<CategoryPage> createState() => _CategoryPage();
}

class _CategoryPage extends State<CategoryPage> {
  Widget _body() {
    return const Column();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          TopBar(themeController: widget.themeController),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(bottom: 8),
                    child: Text(
                      "Category Name",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 5),
                    child: Text(
                      "Category Page",
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ),
                  TextButton(
                      onPressed: () {},
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 2),
                            child: Icon(
                              Icons.edit_outlined,
                              size: 14,
                              color: Theme.of(context).colorScheme.tertiary,
                            ),
                          ),
                          Text(
                            "EDIT",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: Theme.of(context).colorScheme.tertiary),
                          ),
                        ],
                      )),
                  const Row(
                    children: [
                      Flexible(
                          child: Text(
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec rhoncus tempus cursus. Vivamus ultricies mi a dapibus accumsan. Cras in placerat ante. Ut lectus mauris, vehicula vehicula dui in, semper malesuada est. Quisque vel vulputate quam.",
                        textAlign: TextAlign.start,
                      )),
                    ],
                  ),
                  const Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: Text(
                          "Trending pages",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
