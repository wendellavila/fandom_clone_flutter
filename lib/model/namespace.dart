enum Namespace {
  main(code: 0, prefix: ''),
  category(code: 14, prefix: 'Category:');

  final int code;
  final String prefix;
  const Namespace({required this.code, required this.prefix});

  bool prefixCompare(Namespace namespace, String prefix) {
    if (Namespace.category.prefix.toLowerCase() == prefix.toLowerCase()) {
      return true;
    }
    return false;
  }

  factory Namespace.fromPrefix(String prefix) {
    switch (prefix.toLowerCase()) {
      case 'category':
        return Namespace.category;
      default:
        return Namespace.main;
    }
  }

  factory Namespace.fromCode(int code) {
    switch (code) {
      case 14:
        return Namespace.category;
      default:
        return Namespace.main;
    }
  }

  @override
  toString() {
    return prefix;
  }
}
