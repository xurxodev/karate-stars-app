class TwitterUrlFactory {
  static String baseAddress = 'https://twitter.com/';

  String create(String text) {
    text = text.trim();

    if (text.substring(0, 1) == '#') {
      return baseAddress +
          'hashtag/' +
          text.replaceFirst('#', '') +
          '?src=hash';
    } else if (text.substring(0, 1) == '@') {
      return baseAddress + text.replaceFirst('@', '');
    } else {
      return text;
    }
  }
}
