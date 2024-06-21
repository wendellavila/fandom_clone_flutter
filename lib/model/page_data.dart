import "package:fandom_clone/model/page_info.dart";

class InfoboxData {
  const InfoboxData({this.image, this.fields = const []});

  final String? image;
  final List<TitleContentPair> fields;
}

class TitleContentPair {
  const TitleContentPair({required this.title, required this.content});

  final String title;
  final String content;
}

class PageData {
  const PageData({
    required this.infobox,
    this.description,
    this.sections = const [],
    this.categories = const [],
  });

  final InfoboxData infobox;
  final String? description;
  final List<TitleContentPair> sections;
  final List<PageInfo> categories;
}
