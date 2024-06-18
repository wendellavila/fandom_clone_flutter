import 'package:fandom_clone/ui/screens/fandom_home/home_form.dart';
import 'package:fandom_clone/ui/widgets/topbar.dart';
import 'package:fandom_clone/ui/widgets/wiki_footer.dart';
import 'package:flutter/material.dart';

class FandomHomePage extends StatelessWidget {
  const FandomHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CustomScrollView(
        physics: ClampingScrollPhysics(),
        slivers: [
          TopNavigationBar(
            showBottomBar: false,
          ),
          SliverFillRemaining(
            child: Column(
              children: [
                Expanded(
                  child: WikiBrowser(),
                ),
                WikiFooter(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
