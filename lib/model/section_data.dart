class SectionData {
  SectionData({
    required this.title,
    required this.content,
    this.isExpanded = true,
  });
  final String title;
  final String content;
  bool isExpanded;
}
