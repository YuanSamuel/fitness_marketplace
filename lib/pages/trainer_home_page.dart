import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:fitnessmarketplace/models/Trainer.dart';
import 'package:fitnessmarketplace/pages/show_video_page.dart';
import 'package:fitnessmarketplace/models/RecordedVideo.dart';

class TrainerHomePage extends StatefulWidget {
  @override
  _TrainerHomePageState createState() => _TrainerHomePageState();
}

class _TrainerHomePageState extends State<TrainerHomePage> {
  List<String> names = ['Johnny Appleseed', 'Samuel Sam', 'John Smith'];
  List<String> dates = ['Jun 15, 5:00 pm', 'July 4, 9:00 pm', 'December 25, 12:00 am'];
  List<String> duration = ['45 minutes', '1 hour', '24 hours'];

  CalendarController _calendarController;
  Trainer currentTrainer;
  List<RecordedVideo> trainerVideos;

  @override
  void initState(){
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
    FirebaseUser getUser = await FirebaseAuth.instance.currentUser();
    DocumentSnapshot userData = await Firestore.instance.collection('trainers').document(getUser.uid).get();
    currentTrainer = Trainer.fromSnapshot(userData);
    await getVideos();
    setState(() {
      
    });
  }
  
  getVideos() async {
    QuerySnapshot getVideos = await currentTrainer.reference.collection('recordedVideos').getDocuments();
    List<DocumentSnapshot> allVideos = getVideos.documents;
    for (int i = 0; i < allVideos.length; i++) {
      print('got');
      trainerVideos.add(RecordedVideo.fromSnapshot(allVideos[i]));
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
    }
    else {
      return Scaffold(
        body:
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30.0,),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Text('Hello, ' + currentTrainer.firstName, style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.w600),),
              ),
              Container(child: _buildCalendar()),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Text('1 on 1 Sessions', style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold
                ),
                ),
              ),
              Container(
                height: 300.0,
                child: ListView.builder(
                  itemCount: names.length,
                  itemBuilder: (BuildContext context, int index){
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
                              offset: Offset(0, 3), // changes position of shadow
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
                                Text(names[index], style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600, color: Colors.white),),
                                SizedBox(height: 10.0,),
                                Text(duration[index], style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w400, color: Colors.white),),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(dates[index].substring(0, dates[index].indexOf(',')), style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w400, color: Colors.white),),
                                SizedBox(height: 10.0,),
                                Text(dates[index].substring(dates[index].indexOf(',') + 2), style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w400, color: Colors.white),),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 10.0,),
              Text('Your Videos',  style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold
              ),
              ),
              Container(
                height: 300.0,
                child: ListView.builder(
                  itemCount: trainerVideos.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int i){
                    print(i);
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: GestureDetector(
                        onTap: () {
                          print('tapped');
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ShowVideoPage(
                                  videoDownloadUrl:
                                  trainerVideos[i].videoUrl,
                                )),
                          );
                        },
                        child: Container(
                          height: 300.0,
                          width: 300.0,
                          child: Center(
                            child: Text(trainerVideos[i].name + '  ' + trainerVideos[i].date.toDate().toString()),
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.0),
                            color: Colors.blue,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
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
