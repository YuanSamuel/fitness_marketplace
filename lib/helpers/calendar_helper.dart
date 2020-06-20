import 'package:fitnessmarketplace/helpers/string_helper.dart';
import 'package:fitnessmarketplace/models/PrivateSession.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class CalendarHelper {

  List<int> months = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];


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
      } else {
        List<PrivateSession> privateSessionsList = new List<PrivateSession>();
        privateSessionsList.add(allPrivateSessions[i]);
        privateSessionsMap[privateSessionDateNoTime] = privateSessionsList;
      }
    }
    return privateSessionsMap;
  }

  DateTime dateTimeToOnlyDay(DateTime date) {
    return DateTime.utc(date.year, date.month, date.day);
  }

  Map<DateTime, List<dynamic>> listToEventMap(List<dynamic> allPrivateSessions, List<dynamic> allStreams) {
    Map<DateTime, List<dynamic>> returnMap = new Map<DateTime, List<dynamic>>();
    for (int i = 0; i < allPrivateSessions.length; i++) {
      DateTime privateSessionDate = DateTime.fromMillisecondsSinceEpoch(allPrivateSessions[i].date);
      DateTime privateSessionDateNoTime = dateTimeToOnlyDay(privateSessionDate);
      if (returnMap.containsKey(privateSessionDateNoTime)) {
        returnMap[privateSessionDateNoTime].add(allPrivateSessions[i]);
      }
      else {
        List<dynamic> addList = new List<dynamic>();
        addList.add(allPrivateSessions[i]);
        returnMap[privateSessionDateNoTime] = addList;
      }
    }
    for (int i = 0; i < allStreams.length; i++) {
      DateTime streamDate = DateTime.fromMillisecondsSinceEpoch(allStreams[i].date);
      DateTime streamDateNoTime = dateTimeToOnlyDay(streamDate);
      if (returnMap.containsKey(streamDateNoTime)) {
        returnMap[streamDateNoTime].add(allStreams[i]);
      }
      else {
        List<dynamic> addList = new List<dynamic>();
        addList.add(allStreams[i]);
        returnMap[streamDateNoTime] = addList;
      }
    }
    return returnMap;
  }

  int dateToInt(DateTime date) {
    int days = 0;
    for (int i = 0; i < date.month - 1; i++) {
      days += months[i];
    }
    days += date.day;
    days += (date.year - 2010) * 365;
    return days;
  }

  String intToDateString(int givenInt) {
    int year = givenInt ~/ 365;
    givenInt %= 365;
    int countDays = 0;
    int month = 1;
    for (int i = 0; i < 12; i++) {
      if (countDays + months[i] >= givenInt) {
        break;
      }
      month++;
      countDays += months[i];
    }
    DateTime actualDate = DateTime(year, month, givenInt - countDays);
    return StringHelper().dateTimeToDateString(actualDate);
  }
}