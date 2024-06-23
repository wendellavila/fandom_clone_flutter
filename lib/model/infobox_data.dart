import 'title_content_pair.dart';

class InfoboxData {
  const InfoboxData({this.image, this.caption, this.fields = const []});

  final String? image;
  final String? caption;
  final List<TitleContentPair> fields;

  factory InfoboxData.fromJson(String json) {
    final labelValueRegex =
        RegExp(r'"label":"([a-zA-Z0-9\s]+?)","value":"([^<>\\]+?)"');
    final imageRegex = RegExp(r'"url\":\"https:(.+?\.(jpg|jpeg|png|webp))');

    final allMatches = labelValueRegex.allMatches(json);

    List<TitleContentPair> fields = allMatches
        .map(
          (match) => TitleContentPair(
            title: match.group(1)!,
            content: match.group(2)!.replaceAll('&nbsp;', ''),
          ),
        )
        .toList();
    final imageMatch = imageRegex.firstMatch(json);
    String? image = imageMatch?.group(1);

    return InfoboxData(
      image: image,
      caption: null,
      fields: fields,
    );
  }
}
