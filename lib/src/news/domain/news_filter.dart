enum NewsType { all, current, social }

class NewsFilter{
  final NewsType? type;
  final String? searchTerm;

  NewsFilter({this.type, this.searchTerm});
}
