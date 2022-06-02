import 'package:flutter/foundation.dart';

enum NewsType { all, current, social }

extension NewsTypeExtension on NewsType {
  String get name => describeEnum(this);
}

class NewsFilter{
  final NewsType? type;
  final String? searchTerm;
  final int? count;

  NewsFilter({this.type, this.searchTerm, this.count});
}
