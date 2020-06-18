import 'package:fitnessmarketplace/models/PrivateSession.dart';

class CalendarHelper {
  Map<DateTime, List<PrivateSession>> privateSessionsToEventMap(List<dynamic> allPrivateSessions) {
    Map<DateTime, List<PrivateSession>> privateSessionsMap =
    new Map<DateTime, List<PrivateSession>>();
    for (int i = 0; i < allPrivateSessions.length; i++) {
      DateTime privateSessionDate = DateTime.fromMillisecondsSinceEpoch(allPrivateSessions[i].date);
      DateTime privateSessionDateNoTime = dateTimeToOnlyDay(privateSessionDate);
      if (privateSessionsMap.containsKey(privateSessionDateNoTime)) {
        privateSessionsMap[privateSessionDateNoTime].add(allPrivateSessions[i]);
      ***REMOVED*** else {
        List<PrivateSession> privateSessionsList = new List<PrivateSession>();
        privateSessionsList.add(allPrivateSessions[i]);
        privateSessionsMap[privateSessionDateNoTime] = privateSessionsList;
      ***REMOVED***
    ***REMOVED***
    return privateSessionsMap;
  ***REMOVED***

  DateTime dateTimeToOnlyDay(DateTime date) {
    return DateTime.utc(date.year, date.month, date.day);
  ***REMOVED***
***REMOVED***