import 'package:fandom_clone/model/title_content_pair.dart';
import 'package:fandom_clone/ui/widgets/loading.dart';
import 'package:flutter/material.dart';

class SectionList extends StatelessWidget {
  const SectionList({
    required this.sections,
    super.key,
  });
  final List<TitleContentPair>? sections;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: sections == null
          ? const Loading()
          : Column(
              children: sections!
                  .map(
                    (section) => ExpansionTile(
                      initiallyExpanded: true,
                      title: Text(section.title),
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(18),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              section.content,
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                  .toList(),
            ),
    );
  }
}
