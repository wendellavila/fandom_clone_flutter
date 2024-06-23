import 'package:fandom_clone/model/wiki_info.dart';
import 'package:fandom_clone/model/page_info.dart';

class CategorySubsection {
  final String title;
  final WikiInfo wikiInfo;
  bool isExpanded;
  final List<PageInfo> pages;

  CategorySubsection({
    required this.title,
    required this.wikiInfo,
    this.isExpanded = false,
    required this.pages,
  });
}
