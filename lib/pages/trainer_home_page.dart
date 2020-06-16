import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitnessmarketplace/apis/firebase_provider.dart';
import 'package:fitnessmarketplace/models/PrivateSession.dart';
import 'package:fitnessmarketplace/models/video_info.dart';
import 'package:fitnessmarketplace/pages/add_new_screen.dart';
import 'package:fitnessmarketplace/pages/player.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:fitnessmarketplace/models/Trainer.dart';
import 'package:fitnessmarketplace/models/RecordedVideo.dart';

class TrainerHomePage extends StatefulWidget {
  @override
  _TrainerHomePageState createState() => _TrainerHomePageState();
}

class _TrainerHomePageState extends State<TrainerHomePage> {
  CalendarController _calendarController;
  Trainer currentTrainer;
  List<RecordedVideo> trainerVideos;
  List<PrivateSession> privateSessions;
  List<VideoInfo> _videos = <VideoInfo>[];


  @override
  void initState() {

    FirebaseProvider.listenToVideos((newVideos) {
      setState(() {
        _videos = newVideos;
      });
    });

    _calendarController = CalendarController();
    setUp();
    super.initState();
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  setUp() async {
    trainerVideos = new List<RecordedVideo>();
    privateSessions = new List<PrivateSession>();

    FirebaseUser getUser = await FirebaseAuth.instance.currentUser();
    DocumentSnapshot userData = await Firestore.instance
        .collection('trainers')
        .document(getUser.uid)
        .get();
    currentTrainer = Trainer.fromSnapshot(userData);

    await getPrivateSessions();
    await getVideos();

    setState(() {});
  }

  getVideos() async {
    QuerySnapshot getVideos = await currentTrainer.reference
        .collection('videos')
        .getDocuments();
    List<DocumentSnapshot> allVideos = getVideos.documents;
    print("NUMBER OF VIDEOS");
    print(allVideos.length);
    for (int i = 0; i < allVideos.length; i++) {
      setState(() {
        trainerVideos.add(RecordedVideo.fromSnapshot(allVideos[i]));
      });
    }
  }

  getPrivateSessions() async {
    QuerySnapshot getPrivateSessions = await currentTrainer.reference
        .collection('privateSessions')
        .getDocuments();
    List<DocumentSnapshot> allPrivateSessions = getPrivateSessions.documents;
    for (int i = 0; i < allPrivateSessions.length; i++) {
      setState(() {
        privateSessions
            .add(PrivateSession.fromSnapshot(allPrivateSessions[i]));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (currentTrainer == null) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
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
                        'Trainer: ' + currentTrainer.firstName,
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
                  '1 on 1 Sessions',
                  style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                height: 250.0,
                child: ListView.builder(
                  itemCount: privateSessions.length,
                  itemBuilder: (BuildContext context, int i) {
                    DateTime privateSessionDate =
                        privateSessions[i].date.toDate().toLocal();
                    String privateSessionLength =
                        getLengthFromInt(privateSessions[i].length);

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
                                Text(
                                  privateSessions[i].name,
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  privateSessionLength,
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
                                  privateSessionDate.month.toString() +
                                      '/' +
                                      privateSessionDate.day.toString(),
                                  style: TextStyle(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  privateSessionDate.hour.toString() +
                                      ':' +
                                      privateSessionDate.minute.toString(),
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
                  height: 340.0,
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
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.bold),
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
                          itemCount: trainerVideos.length+1,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int i) {
                            print(i);
                            if (i==0){
                              return Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: GestureDetector(
                                  onTap: () {
                                    print('tapped');
                                    Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AddNewRecording( )),
                                  );
                                    //TODO make sessions database implementation
                                  },
                                  child: Container(
                                    height: 300.0,
                                    width: 300.0,
                                    child: Center(
                                      child: FlatButton(
                                        child: Icon(Icons.add),
                                      )
                                    ),
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
                                  ),
                                ),
                              );
                            }
                            print("WHY ISNT STUFF SHOWING");
                            return Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: GestureDetector(
                                onTap: () {
                                  print('tapped');
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Player(
                                              video:
                                                  _videos[i-1],
                                            )),
                                  );
                                  //TODO make sessions database implementation
                                },
                                child: Container(
                                  height: 300.0,
                                  width: 300.0,
                                  child: Center(
                                    child: Text(trainerVideos[i-1].name +
                                        '  ' +
                                        Timestamp.fromMillisecondsSinceEpoch(trainerVideos[i-1]
                                            .date)
                                            .toDate()
                                            .toString()),
                                  ),
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: Image.network(trainerVideos[i-1].videoUrl).image,
                                      fit: BoxFit.cover,
                                    ),
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
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  )),
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
        //onDaySelected: _onDaySelected,
        locale: 'en_US',
        //events: _selectedDay,
        calendarController: _calendarController,
        initialCalendarFormat: CalendarFormat.month,
        formatAnimation: FormatAnimation.slide,
        startingDayOfWeek: StartingDayOfWeek.sunday,
        availableGestures: AvailableGestures.horizontalSwipe,
        events: getEvents(),
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

  String getLengthFromInt(int length) {
    String returnLength = '';
    if (length > 60) {
      returnLength = returnLength + (length ~/ 60).toString() + ' hours ';
    }
    returnLength = returnLength + (length % 60).toString() + ' minutes';
    return returnLength;
  }

  Map<DateTime, List<String>> getEvents() {
    Map<DateTime, List<String>> privateSessionsMap =
        new Map<DateTime, List<String>>();
    for (int i = 0; i < privateSessions.length; i++) {
      DateTime privateSessionDate = privateSessions[i].date.toDate();
      if (privateSessionsMap.containsKey(privateSessionDate)) {
        privateSessionsMap[privateSessionDate].add(privateSessions[i].name);
      } else {
        List<String> privateSessionsList = new List<String>();
        privateSessionsList.add(privateSessions[i].name);
        privateSessionsMap[privateSessionDate] = privateSessionsList;
      }
    }
    return privateSessionsMap;
  }
}
