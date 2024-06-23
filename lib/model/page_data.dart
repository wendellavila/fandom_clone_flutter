import 'dart:convert';
import 'package:fandom_clone/model/namespace.dart';
import "package:fandom_clone/model/page_info.dart";
import 'infobox_data.dart';
import 'title_content_pair.dart';

class PageData {
  const PageData({
    this.infobox,
    this.description,
    this.sections = const [],
    this.categories = const [],
  });

  final InfoboxData? infobox;
  final String? description;
  final List<TitleContentPair> sections;
  final List<PageInfo> categories;

  factory PageData.fromJson(String json) {
    final Map jsonMap = jsonDecode(json) as Map;
    final text = jsonMap['parse']['text']['*'] as String;
    final categories = jsonMap['parse']['categories'] as List<dynamic>;
    final sections = jsonMap['parse']['sections'] as List<dynamic>;
    final properties = jsonMap['parse']['properties'] as List<dynamic>;

    InfoboxData? infoboxData;
    if (properties.isNotEmpty) {
      final infobox = properties[0]['*'];
      infoboxData = InfoboxData.fromJson(infobox);
    }

    return PageData(
      infobox: infoboxData,
      description: text.substring(0, 100),
      sections: sections
          .map(
            (section) => TitleContentPair(
              title: (section['line'] as String).replaceAll('_', ' '),
              content: "Content",
            ),
          )
          .toList(),
      categories: categories
          .map(
            (category) => PageInfo(
              pagename: (category['*'] as String).replaceAll('_', ' '),
              namespace: Namespace.category,
            ),
          )
          .toList(),
    );
  }
}
