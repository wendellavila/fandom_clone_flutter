import 'package:flutter/material.dart';
import 'package:fandom_clone/model/section_data.dart';

class SectionList extends StatelessWidget {
  const SectionList({
    required this.sections,
    required this.setSectionExpandedCallback,
    super.key,
  });
  final List<SectionData> sections;
  final Function({
    required int index,
    required bool isExpanded,
  }) setSectionExpandedCallback;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionPanelList(
          elevation: 0,
          expandedHeaderPadding: EdgeInsets.zero,
          expandIconColor: Theme.of(context).colorScheme.onSecondary,
          expansionCallback: (panelIndex, isExpanded) {
            setSectionExpandedCallback(
              index: panelIndex,
              isExpanded: isExpanded,
            );
          },
          children: [
            for (int panelIndex = 0; panelIndex < sections.length; panelIndex++)
              ExpansionPanel(
                isExpanded: sections[panelIndex].isExpanded,
                backgroundColor: Theme.of(context).colorScheme.surface,
                canTapOnHeader: true,
                headerBuilder: (context, isExpanded) {
                  return ListTile(
                    style: ListTileStyle.list,
                    title: Text(sections[panelIndex].title),
                  );
                },
                body: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      sections[panelIndex].content,
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
