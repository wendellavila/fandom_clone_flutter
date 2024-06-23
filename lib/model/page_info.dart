import 'namespace.dart';

class PageInfo implements Comparable {
  PageInfo({required String pagename, this.namespace = Namespace.main}) {
    this.pagename = pagename.replaceFirst(namespace.prefix, '');
  }
  late String pagename;
  final Namespace namespace;

  @override
  int compareTo(other) {
    return "${namespace.prefix}:$pagename"
        .compareTo("${other.namespace.prefix}:${other.pagename}");
  }

  @override
  String toString() {
    return "${namespace.prefix}$pagename";
  }
}
