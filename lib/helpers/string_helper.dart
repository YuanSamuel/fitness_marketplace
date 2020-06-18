class StringHelper {
  List<String> months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];

  String dateTimeToDateString(DateTime date) {
    return months[date.month] + ' ' + date.day.toString();
  }

  String dateTimeToTimeString(DateTime date) {
    String minute = date.minute.toString();
    if (date.minute < 10) {
      minute = '0' + minute;
    }
    if (date.hour < 12) {
      if (date.hour == 0) {
        return '12:' + minute + ' a.m.';
      }
      return (date.hour).toString() + ':'  + minute + ' a.m.';
    }
    else {
      if (date.hour == 12) {
        return '12:' + minute + ' p.m.';
      }
      return (date.hour - 12).toString() + ':' + minute + ' p.m.';
    }
  }

}