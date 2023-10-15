enum SortBy {
  asc,
  desc;

  String get key {
    switch (this) {
      case SortBy.asc:
        return "asc";
      case SortBy.desc:
        return "desc";
    }
  }
}
