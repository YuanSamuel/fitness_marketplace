import 'package:fitnessmarketplace/models/PrivateSession.dart';

class CalendarHelper {
  Map<DateTime, List<PrivateSession>> privateSessionsToEventMap(
      List<dynamic> allPrivateSessions) {
    Map<DateTime, List<PrivateSession>> privateSessionsMap =
    new Map<DateTime, List<PrivateSession>>();
    for (int i = 0; i < allPrivateSessions.length; i++) {
      DateTime privateSessionDate = DateTime.fromMillisecondsSinceEpoch(
          allPrivateSessions[i].date);
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

  Map<DateTime, List<dynamic>> listToEventMap(List<dynamic> allPrivateSessions, List<dynamic> allStreams) {
    Map<DateTime, List<dynamic>> returnMap = new Map<DateTime, List<dynamic>>();
    for (int i = 0; i < allPrivateSessions.length; i++) {
      DateTime privateSessionDate = DateTime.fromMillisecondsSinceEpoch(allPrivateSessions[i].date);
      DateTime privateSessionDateNoTime = dateTimeToOnlyDay(privateSessionDate);
      if (returnMap.containsKey(privateSessionDateNoTime)) {
        returnMap[privateSessionDateNoTime].add(allPrivateSessions[i]);
      ***REMOVED***
  ***REMOVED***
        List<dynamic> addList = new List<dynamic>();
        addList.add(allPrivateSessions[i]);
        returnMap[privateSessionDateNoTime] = addList;
      ***REMOVED***
    ***REMOVED***
    for (int i = 0; i < allStreams.length; i++) {
      DateTime streamDate = DateTime.fromMillisecondsSinceEpoch(allStreams[i].date);
      DateTime streamDateNoTime = dateTimeToOnlyDay(streamDate);
      if (returnMap.containsKey(streamDateNoTime)) {
        returnMap[streamDateNoTime].add(allStreams[i]);
      ***REMOVED***
  ***REMOVED***
        List<dynamic> addList = new List<dynamic>();
        addList.add(allStreams[i]);
        returnMap[streamDateNoTime] = addList;
      ***REMOVED***
    ***REMOVED***
    return returnMap;
  ***REMOVED***
***REMOVED***