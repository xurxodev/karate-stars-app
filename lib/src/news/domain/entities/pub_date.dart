class PubDate {
  final DateTime date;

  PubDate(this.date) : assert(date != null);

  String get antiquity {
    final int antiquityMillis =
        DateTime.now().millisecondsSinceEpoch - date.millisecondsSinceEpoch;

    final seconds = (antiquityMillis / 1000).floor();
    final minutes = (seconds / 60).floor();
    final hours = (minutes / 60).floor();
    final days = (hours / 24).floor();

    if (days > 0) {
      return days.toString() + 'd';
    } else if (hours > 0) {
      return hours.toString() + 'h';
    } else if (minutes > 0) {
      return minutes.toString() + 'm';
    } else if (seconds > 0) {
      return seconds.toString() + 's';
    } else {
      return '0s';
    }
  }
}

