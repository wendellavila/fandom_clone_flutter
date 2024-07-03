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
    this.images = const [],
  });

  final InfoboxData? infobox;
  final String? description;
  final List<TitleContentPair> sections;
  final List<PageInfo> categories;
  final List<String> images;

  factory PageData.parse({
    required String pagename,
    required String htmlResponse,
    required String wikitextResponse,
  }) {
    final Map htmlJson = jsonDecode(htmlResponse) as Map;
    final Map wikitextJson = jsonDecode(wikitextResponse) as Map;

    final categories = htmlJson['parse']['categories'] as List<dynamic>;
    final sections = htmlJson['parse']['sections'] as List<dynamic>;
    final properties = htmlJson['parse']['properties'] as List<dynamic>;

    final pageRevisions = wikitextJson['query']['pages'] as Map<String, dynamic>;
    final pageId = pageRevisions.keys.first;

    final wikitext = pageRevisions[pageId]['revisions'][0]['slots']['main']['*'] as String;

    String description = wikitext.split(RegExp('\n+')).firstWhere(
          (element) =>
              element.isNotEmpty &&
              !['=', '{', '*', '#', '[', '|', '}'].contains(
                element[0],
              ),
          orElse: () => '',
        );

    description.replaceAll('{{PAGENAME}}', pagename);

    final htmlText = htmlJson['parse']['text'].toString();
    final images = RegExp(
      r'https?:\/\/[^\s]+?\.(?:jpg|jpeg|png|webp)',
    ).allMatches(htmlText).map((z) => z.group(0)).nonNulls.toList();

    InfoboxData? infoboxData;
    if (properties.isNotEmpty) {
      final infobox = properties[0]['*'];
      infoboxData = InfoboxData.fromJson(infobox);
    }

    return PageData(
      infobox: infoboxData,
      description: description,
      images: images,
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
