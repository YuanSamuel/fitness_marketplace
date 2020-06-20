import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitnessmarketplace/helpers/string_helper.dart';
import 'package:fitnessmarketplace/helpers/calendar_helper.dart';
import 'package:fitnessmarketplace/models/PrivateSession.dart';
import 'package:fitnessmarketplace/models/RecordedVideo.dart';
import 'package:fitnessmarketplace/models/Stream.dart' as models;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:fitnessmarketplace/models/Student.dart';

class UserHomePage extends StatefulWidget {
  @override
  _UserHomePageState createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  Student currentStudent;
  List<PrivateSession> allPrivateSessions;
  List<dynamic> selectedPrivateSessions;
  List<RecordedVideo> recordedVideos;
  List<models.Stream> allStreams;
  List<dynamic> selectedStreams;
  DateTime selectedDate;
  List<dynamic> allEvents;

  CalendarController _calendarController;

  StringHelper _stringHelper;
  CalendarHelper _calendarHelper;

  @override
  void initState() {
    _calendarController = CalendarController();
    _calendarHelper = new CalendarHelper();
    _stringHelper = new StringHelper();
    allEvents = new List<dynamic>();
    getCurrentStudent();
    super.initState();
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  void getCurrentStudent() async {
    FirebaseUser getUser = await FirebaseAuth.instance.currentUser();
    DocumentSnapshot userData = await Firestore.instance
        .collection('students')
        .document(getUser.uid)
        .get();
    currentStudent = Student.fromSnapshot(userData);
    await getPrivateSessions();
    await getRecordedVideos();
    await getStreams();
    setState(() {});
  }

  Future<void> getPrivateSessions() async {
    allPrivateSessions = new List<PrivateSession>();
    selectedPrivateSessions = new List<PrivateSession>();
    QuerySnapshot queryPrivateLessons = await currentStudent.reference
        .collection('privateSessions')
        .getDocuments();
    List<DocumentSnapshot> holdPrivateSessions = queryPrivateLessons.documents;
    for (int i = 0; i < holdPrivateSessions.length; i++) {
      PrivateSession currentPrivateSession =
          PrivateSession.fromSnapshot(holdPrivateSessions[i]);
      allPrivateSessions.add(currentPrivateSession);
    }
    return;
  }

  Future<void> getRecordedVideos() async {
    recordedVideos = new List<RecordedVideo>();
    QuerySnapshot allRecordedVideos =
        await currentStudent.reference.collection('videos').getDocuments();
    List<DocumentSnapshot> videos = allRecordedVideos.documents;
    for (int i = 0; i < videos.length; i++) {
      RecordedVideo currentVideo = RecordedVideo.fromSnapshot(videos[i]);
      recordedVideos.add(currentVideo);
    }
    return;
  }

  Future<void> getStreams() async {
    allStreams = new List<models.Stream>();
    selectedStreams = new List<models.Stream>();
    QuerySnapshot getStreams = await currentStudent.reference.collection('streams').getDocuments();
    List<DocumentSnapshot> streamSnapshots = getStreams.documents;
    for (int i = 0; i < streamSnapshots.length; i++) {
      allStreams.add(models.Stream.fromSnapshot(streamSnapshots[i]));
    }
    return;
  }

  @override
  Widget build(BuildContext context) {
    if (currentStudent == null) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      print(allPrivateSessions);
      return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 30.0,
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Row(
                    children: [
                      Text(
                        'Student: ' + currentStudent.firstName,
                        style: TextStyle(
                            fontSize: 30.0, fontWeight: FontWeight.w600),
                      ),
                      Spacer(),
                      IconButton(
                        icon: Icon(Icons.account_circle),
                        onPressed: () {},
                      )
                    ],
                  )),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Divider(
                  height: 10.0,
                  thickness: 0.75,
                ),
              ),
              Container(child: _buildCalendar()),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Divider(
                  height: 10.0,
                  thickness: 0.75,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Text(
                  'Upcoming Sessions',
                  style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                height: 250.0,
                child: ListView.builder(
                  itemCount: allEvents.length,
                  itemBuilder: (BuildContext context, int i) {

                    bool isStream = allEvents[i] is models.Stream;

                    String length = isStream ? _stringHelper.intToLengthString(allEvents[i].minutes.floor()) :  _stringHelper.intToLengthString(allEvents[i].length);

                    DateTime eventDate = DateTime.fromMillisecondsSinceEpoch(allEvents[i].date).toLocal();

                    String date = _stringHelper.dateTimeToDateString(eventDate);

                    String time = _stringHelper.dateTimeToTimeString(eventDate);

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 15.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.0),
                          color: Color(0xff3B3B3B),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        height: 100.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 7 * MediaQuery.of(context).size.width / 10,
                                  height: 40,
                                  child: isStream ? Text(
                                    allEvents[i].title + ' - Live Class',
                                    overflow: TextOverflow.fade,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ) : Text(
                                    'Lesson with: ' +
                                        selectedPrivateSessions[i].trainerName,
                                    overflow: TextOverflow.fade,
                                    style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white),
                                  ),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  length,
                                  style: TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  date,
                                  style: TextStyle(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  time,
                                  style: TextStyle(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.symmetric(
                      vertical: BorderSide(width: 0.5, color: Colors.black26),
                    )),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10.0,
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Row(
                          children: [
                            Text(
                              'Your Videos',
                              style: TextStyle(
                                  fontSize: 25.0, fontWeight: FontWeight.bold),
                            ),
                            Spacer(),
                            Text(
                              'See All',
                              style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black26),
                            ),
                          ],
                        )),
                    Container(
                      color: Colors.white,
                      height: 300.0,
                      child: ListView.builder(
                        itemCount: recordedVideos.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int i) {
                          return Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: GestureDetector(
                              child: Container(
                                  height: 300.0,
                                  width: 300.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30.0),
                                    color: Colors.blue,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset: Offset(
                                            0, 3), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                    child: Text(recordedVideos[i].name +
                                        ' ' +
                                        Timestamp.fromMillisecondsSinceEpoch(
                                                recordedVideos[i].date)
                                            .toDate()
                                            .toString()),
                                  )),
                              //TODO set up this so that it works with actual videos / streams
                              /*onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => ShowVideoPage(videoDownloadUrl: recordedVideos[i].videoUrl,)),
                                );
                              },*/
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
    }
  }

  Widget _buildCalendar() {
    return Container(
      //color: Color(0xff465466),
      //color: Colors.white,
      child: TableCalendar(
        rowHeight: 40.0,
        onDaySelected: (DateTime date, List<dynamic> events) {
          for (int i = 0; i < events.length; i++) {
            if (events[i] is models.Stream) {
              selectedStreams.add(events[i]);
            }
            else {
              selectedPrivateSessions.add(events[i]);
            }
          }
          setState(() {
            selectedDate = date;
            allEvents = events;
          });
        },
        locale: 'en_US',
        events: _calendarHelper.listToEventMap(allPrivateSessions, allStreams),
        calendarController: _calendarController,
        initialCalendarFormat: CalendarFormat.month,
        formatAnimation: FormatAnimation.slide,
        startingDayOfWeek: StartingDayOfWeek.sunday,
        availableGestures: AvailableGestures.horizontalSwipe,
        availableCalendarFormats: const {
          CalendarFormat.month: 'Month',
        },
        calendarStyle: CalendarStyle(
          weekdayStyle: TextStyle(color: Colors.black),
          weekendStyle: TextStyle(color: Colors.red),
          outsideStyle: TextStyle(color: Colors.grey),
          unavailableStyle: TextStyle(color: Colors.grey),
          outsideWeekendStyle: TextStyle(color: Colors.grey),
        ),
        daysOfWeekStyle: DaysOfWeekStyle(
          dowTextBuilder: (date, locale) {
            return DateFormat.E(locale)
                .format(date)
                .substring(0, 3)
                .toUpperCase();
          },
          weekdayStyle: TextStyle(color: Colors.grey),
          weekendStyle: TextStyle(color: Colors.grey),
        ),
        headerVisible: true,
        headerStyle: HeaderStyle(
            titleTextStyle: TextStyle(color: Colors.black, fontSize: 20.0)),
        builders: CalendarBuilders(
          markersBuilder: (context, date, events, holidays) {
            return [
              Container(
                decoration: new BoxDecoration(
                  color: Color(0xFF30A9B2),
                  //color: Color(C),
                  shape: BoxShape.circle,
                ),
                margin: const EdgeInsets.all(4.0),
                width: 4,
                height: 4,
              )
            ];
          },
          selectedDayBuilder: (context, date, _) {
            return Container(
              decoration: new BoxDecoration(
                color: Color(0xFF30A9B2),
                shape: BoxShape.circle,
              ),
              margin: const EdgeInsets.all(4.0),
              width: 100,
              height: 100,
              child: Center(
                child: Text(
                  '${date.day}',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.white,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
