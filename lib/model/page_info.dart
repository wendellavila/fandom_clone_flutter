import 'namespace.dart';

class PageInfo implements Comparable {
  PageInfo({required this.pagename, this.namespace = Namespace.main});
  final String pagename;
  final Namespace namespace;

  @override
  int compareTo(other) {
    return "${namespace.prefix}:$pagename".compareTo("${other.namespace.prefix}:${other.pagename}");
  }

  @override
  String toString() {
    return "${namespace.prefix}${namespace == Namespace.main ? '' : ':'}$pagename";
  }
}
