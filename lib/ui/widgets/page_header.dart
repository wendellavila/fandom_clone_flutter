import 'package:flutter/material.dart';
import 'package:fandom_clone/model/page_info.dart';
import 'package:fandom_clone/model/namespace.dart';

class PageHeader extends StatelessWidget {
  const PageHeader({super.key, required this.pageInfo});

  final PageInfo pageInfo;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              pageInfo.pagename,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          if (pageInfo.namespace == Namespace.category)
            const Padding(
              padding: EdgeInsets.only(bottom: 8),
              child: Text(
                "Category Page",
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
