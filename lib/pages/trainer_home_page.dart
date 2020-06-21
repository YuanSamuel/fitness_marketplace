import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitnessmarketplace/apis/firebase_provider.dart';
import 'package:fitnessmarketplace/helpers/calendar_helper.dart';
import 'package:fitnessmarketplace/helpers/string_helper.dart';
import 'package:fitnessmarketplace/models/PrivateSession.dart';
import 'package:fitnessmarketplace/models/Stream.dart' as models;
import 'package:fitnessmarketplace/models/video_info.dart';
import 'package:fitnessmarketplace/pages/add_new_screen.dart';
import 'package:fitnessmarketplace/pages/add_session_page.dart';
import 'package:fitnessmarketplace/pages/player.dart';
import 'package:fitnessmarketplace/pages/stream_page.dart';
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
  List<PrivateSession> allPrivateSessions;
  List<dynamic> privateSessions;
  List<VideoInfo> _videos = <VideoInfo>[];
  List<models.Stream> allStreams;
  List<dynamic> selectedStreams;
  DateTime selectedDate;
  List<dynamic> allEvents;

  StringHelper _stringHelper = new StringHelper();
  CalendarHelper _calendarHelper = new CalendarHelper();

  @override
  void initState() {
    FirebaseProvider.listenToVideos((newVideos) {
      setState(() {
        _videos = newVideos;
      });
    });
    selectedDate = DateTime.now();
    _calendarController = CalendarController();
    allEvents = new List<dynamic>();
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
    allPrivateSessions = new List<PrivateSession>();
    privateSessions = new List<PrivateSession>();
    allStreams = new List<models.Stream>();
    selectedStreams = new List<models.Stream>();

    FirebaseUser getUser = await FirebaseAuth.instance.currentUser();
    DocumentSnapshot userData = await Firestore.instance
        .collection('trainers')
        .document(getUser.uid)
        .get();
    currentTrainer = Trainer.fromSnapshot(userData);

    await getPrivateSessions();
    await getStreams();
    await getVideos();

    setState(() {});
  }

  getVideos() async {
    QuerySnapshot getVideos =
        await currentTrainer.reference.collection('videos').getDocuments();
    List<DocumentSnapshot> allVideos = getVideos.documents;
    for (int i = 0; i < allVideos.length; i++) {
      trainerVideos.add(RecordedVideo.fromSnapshot(allVideos[i]));
    }
  }

  getPrivateSessions() async {
    allPrivateSessions = new List<PrivateSession>();
    QuerySnapshot getPrivateSessions = await currentTrainer.reference
        .collection('privateSessions')
        .getDocuments();
    List<DocumentSnapshot> allPrivateSessionDocuments =
        getPrivateSessions.documents;
    for (int i = 0; i < allPrivateSessionDocuments.length; i++) {
      allPrivateSessions
          .add(PrivateSession.fromSnapshot(allPrivateSessionDocuments[i]));
    }
  }

  getStreams() async {
    allStreams = new List<models.Stream>();
    QuerySnapshot getStreams =
        await currentTrainer.reference.collection('streams').getDocuments();
    List<DocumentSnapshot> allStreamDocuments = getStreams.documents;
    for (int i = 0; i < allStreamDocuments.length; i++) {
      allStreams.add(models.Stream.fromSnapshot(allStreamDocuments[i]));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (currentTrainer == null) {
      TrainerHomePage();
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
                child: Row(
                  children: [
                    Text(
                      'Private Sessions',
                      style: TextStyle(
                          fontSize: 25.0, fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddSessionPage(
                                    chosenDate: selectedDate,
                                    currentTrainer: currentTrainer,
                                  )),
                        );
                        await getPrivateSessions();
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),
              Container(
                height: 250.0,
                child: ListView.builder(
                  itemCount: allEvents.length,
                  itemBuilder: (BuildContext context, int i) {
                    DateTime date =
                        DateTime.fromMillisecondsSinceEpoch(allEvents[i].date)
                            .toLocal();

                    bool isStream = allEvents[i] is models.Stream;

                    String length = isStream
                        ? _stringHelper
                            .intToLengthString(allEvents[i].minutes.floor())
                        : _stringHelper.intToLengthString(allEvents[i].length);

                    return GestureDetector(
                      onTap:() {

                        // Within the `FirstRoute` widget
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => StreamPage(channelName:"HAPPY" /*currentTrainer.reference.documentID*/,role: ClientRole.Broadcaster,isTrainer: true,)),
                        );

                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 15.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.0),
                            color: isStream || allEvents[i].available
                                ? Colors.blue
                                : Color(0xff3B3B3B),
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
                                    width: 7 *
                                        MediaQuery.of(context).size.width /
                                        10,
                                    height: 40,
                                    child: isStream
                                        ? Text(
                                            allEvents[i].title + ' - Live Class',
                                            overflow: TextOverflow.fade,
                                            style: TextStyle(
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          )
                                        : Text(
                                            allEvents[i].available
                                                ? 'Open Session'
                                                : 'Private Session with: ' +
                                                    allEvents[i].studentName,
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
                                    _stringHelper.dateTimeToDateString(date),
                                    style: TextStyle(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(
                                    _stringHelper.dateTimeToTimeString(date),
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
                          itemCount: trainerVideos.length + 1,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int i) {
                            if (i == 0) {
                              return Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: GestureDetector(
                                  onTap: () {
                                    print('tapped');
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              AddNewRecording()),
                                    );
                                    //TODO make sessions database implementation
                                  },
                                  child: Container(
                                    height: 300.0,
                                    width: 300.0,
                                    child: Center(
                                        child: FlatButton(
                                      child: Icon(Icons.add),
                                    )),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30.0),
                                      color: Colors.blue,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 5,
                                          blurRadius: 7,
                                          offset: Offset(0,
                                              3), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }
                            return Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: GestureDetector(
                                onTap: () {
                                  print('tapped');
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Player(
                                              video: _videos[i - 1],
                                            )),
                                  );
                                  //TODO make sessions database implementation
                                },
                                child: Container(
                                  height: 300.0,
                                  width: 300.0,
                                  child: Center(
                                    child: Text(trainerVideos[i - 1].name +
                                        '  ' +
                                        Timestamp.fromMillisecondsSinceEpoch(
                                                trainerVideos[i - 1].uploadedAt)
                                            .toDate()
                                            .toString()),
                                  ),
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: Image.network(
                                              trainerVideos[i - 1].videoUrl)
                                          .image,
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
        onDaySelected: (DateTime date, List<dynamic> events) {
          for (int i = 0; i < events.length; i++) {
            if (events[i] is PrivateSession) {
              privateSessions.add(events[i]);
            } else if (events[i] is models.Stream) {
              selectedStreams.add(events[i]);
            }
          }
          setState(() {
            selectedDate = date;
            allEvents = events;
          });
        },
        locale: 'en_US',
        calendarController: _calendarController,
        initialCalendarFormat: CalendarFormat.month,
        formatAnimation: FormatAnimation.slide,
        startingDayOfWeek: StartingDayOfWeek.sunday,
        availableGestures: AvailableGestures.horizontalSwipe,
        events: _calendarHelper.listToEventMap(allPrivateSessions, allStreams),
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
