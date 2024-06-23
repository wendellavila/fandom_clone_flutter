import 'package:fandom_clone/model/wiki_statistics.dart';

class WikiInfo implements Comparable {
  final String prefix;
  final String name;
  final String logo;
  late String url;
  final WikiStatistics statistics;

  WikiInfo({
    required this.prefix,
    required this.name,
    required this.logo,
    required this.statistics,
  }) {
    url = "$prefix.fandom.com";
  }

  @override
  int compareTo(other) {
    return name.compareTo(other.name);
  }
}
