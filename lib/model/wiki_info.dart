class WikiInfo implements Comparable {
  final String prefix;
  final String name;
  final String logo;
  late String url;

  WikiInfo({
    required this.prefix,
    required this.name,
    required this.logo,
  }) {
    url = "$prefix.fandom.com";
  }

  @override
  int compareTo(other) {
    return name.compareTo(other.name);
  }
}
