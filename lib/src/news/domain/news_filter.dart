import 'package:flutter/foundation.dart';

enum NewsType { all, current, social }

extension NewsTypeExtension on NewsType {
  String get name => describeEnum(this);
}

class NewsFilter{
  final NewsType? type;
  final String? searchTerm;

  NewsFilter({this.type, this.searchTerm});
}
