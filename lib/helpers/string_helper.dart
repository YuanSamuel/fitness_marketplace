class StringHelper {
  List<String> months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];

  String dateTimeToDateString(DateTime date) {
    return months[date.month] + ' ' + date.day.toString();
  ***REMOVED***

  String dateTimeToTimeString(DateTime date) {
    String minute = date.minute.toString();
    if (date.minute < 10) {
      minute = '0' + minute;
    ***REMOVED***
    if (date.hour < 12) {
      if (date.hour == 0) {
        return '12:' + minute + ' a.m.';
      ***REMOVED***
      return (date.hour).toString() + ':'  + minute + ' a.m.';
    ***REMOVED***
***REMOVED***
      if (date.hour == 12) {
        return '12:' + minute + ' p.m.';
      ***REMOVED***
      return (date.hour - 12).toString() + ':' + minute + ' p.m.';
    ***REMOVED***
  ***REMOVED***
  
***REMOVED***