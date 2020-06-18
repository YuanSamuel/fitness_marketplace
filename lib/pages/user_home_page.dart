***REMOVED***
***REMOVED***
import 'package:fitnessmarketplace/helpers/string_helper.dart';
import 'package:fitnessmarketplace/helpers/calendar_helper.dart';
import 'package:fitnessmarketplace/models/PrivateSession.dart';
import 'package:fitnessmarketplace/models/RecordedVideo.dart';
***REMOVED***
***REMOVED***
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:fitnessmarketplace/models/Student.dart';

class UserHomePage extends StatefulWidget {
***REMOVED***
  _UserHomePageState createState() => _UserHomePageState();
***REMOVED***

class _UserHomePageState extends State<UserHomePage> {
  Student currentStudent;
  List<PrivateSession> allPrivateSessions;
  List<dynamic> selectedPrivateSessions;
  List<RecordedVideo> recordedVideos;
  DateTime selectedDate;

  CalendarController _calendarController;

  StringHelper _stringHelper;
  CalendarHelper _calendarHelper;

***REMOVED***
***REMOVED***
    _calendarController = CalendarController();
    _calendarHelper = new CalendarHelper();
    _stringHelper = new StringHelper();
    getCurrentStudent();
***REMOVED***
  ***REMOVED***

***REMOVED***
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  ***REMOVED***

  void getCurrentStudent() async {
    FirebaseUser getUser = await FirebaseAuth.instance.currentUser();
    DocumentSnapshot userData = await Firestore.instance
        .collection('students')
        .document(getUser.uid)
        .get();
    currentStudent = Student.fromSnapshot(userData);
    await getPrivateSessions();
    await getRecordedVideos();
    setState(() {***REMOVED***);
  ***REMOVED***

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
    ***REMOVED***
    return;
  ***REMOVED***

  Future<void> getRecordedVideos() async {
    recordedVideos = new List<RecordedVideo>();
    QuerySnapshot allRecordedVideos =
        await currentStudent.reference.collection('videos').getDocuments();
    List<DocumentSnapshot> videos = allRecordedVideos.documents;
    for (int i = 0; i < videos.length; i++) {
      RecordedVideo currentVideo = RecordedVideo.fromSnapshot(videos[i]);
      recordedVideos.add(currentVideo);
    ***REMOVED***
    return;
  ***REMOVED***

***REMOVED***
***REMOVED***
    if (currentStudent == null) {
  ***REMOVED***
        body: Center(
          child: CircularProgressIndicator(),
***REMOVED***
  ***REMOVED***
    ***REMOVED*** else {
      print(allPrivateSessions);
  ***REMOVED***
  ***REMOVED***
***REMOVED***
***REMOVED***
***REMOVED***
***REMOVED***
                height: 30.0,
***REMOVED***,
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Row(
        ***REMOVED***
***REMOVED***
                        'Student: ' + currentStudent.firstName,
    ***REMOVED***
                            fontSize: 30.0, fontWeight: FontWeight.w600),
        ***REMOVED***,
                      Spacer(),
                      IconButton(
                        icon: Icon(Icons.account_circle),
    ***REMOVED******REMOVED***,
        ***REMOVED***
    ***REMOVED***
    ***REMOVED***),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Divider(
                  height: 10.0,
                  thickness: 0.75,
  ***REMOVED***,
***REMOVED***,
              Container(child: _buildCalendar()),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Divider(
                  height: 10.0,
                  thickness: 0.75,
  ***REMOVED***,
***REMOVED***,
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Text(
                  'Upcoming Sessions',
***REMOVED***fontSize: 25.0, fontWeight: FontWeight.bold),
  ***REMOVED***,
***REMOVED***,
              Container(
                height: 250.0,
                child: ListView.builder(
                  itemCount: selectedPrivateSessions.length,
                  itemBuilder: (BuildContext context, int i) {
                    DateTime privateSessionDate =
                        DateTime.fromMillisecondsSinceEpoch(
                            selectedPrivateSessions[i].date);
                    DateTime localPrivateSessionDate =
                        privateSessionDate.toLocal();
                    String privateSessionDateString = _stringHelper
                        .dateTimeToDateString(localPrivateSessionDate);
                    String privateSessionTimeString = _stringHelper
                        .dateTimeToTimeString(localPrivateSessionDate);
                    String privateSessionLengthString =
                        getLengthFromInt(selectedPrivateSessions[i].length);

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 15.0),
            ***REMOVED***
                          borderRadius: BorderRadius.circular(30.0),
                          color: Color(0xff3B3B3B),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset:
                                  Offset(0, 3), // changes position of shadow
              ***REMOVED***,
          ***REMOVED***
          ***REMOVED***,
                        height: 100.0,
                        child: Row(
          ***REMOVED***
                          crossAxisAlignment: CrossAxisAlignment.center,
              ***REMOVED***
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                  ***REMOVED***
                  ***REMOVED***
          ***REMOVED***
                                  'Lesson with: ' +
                                      selectedPrivateSessions[i].trainerName,
              ***REMOVED***
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white),
                  ***REMOVED***,
          ***REMOVED***
                                  height: 10.0,
                  ***REMOVED***,
          ***REMOVED***
                                  privateSessionLengthString,
              ***REMOVED***
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white),
                  ***REMOVED***,
              ***REMOVED***
              ***REMOVED***,
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                  ***REMOVED***
          ***REMOVED***
                                  privateSessionDateString,
              ***REMOVED***
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white),
                  ***REMOVED***,
          ***REMOVED***
                                  height: 10.0,
                  ***REMOVED***,
          ***REMOVED***
                                  privateSessionTimeString,
              ***REMOVED***
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white),
                  ***REMOVED***,
              ***REMOVED***
              ***REMOVED***
          ***REMOVED***
          ***REMOVED***,
        ***REMOVED***,
                ***REMOVED***
                  ***REMOVED***,
  ***REMOVED***,
***REMOVED***,
***REMOVED***
                height: 10.0,
***REMOVED***,
              Container(
    ***REMOVED***
                    color: Colors.white,
                    border: Border.symmetric(
                      vertical: BorderSide(width: 0.5, color: Colors.black26),
      ***REMOVED***),
      ***REMOVED***
      ***REMOVED***
      ***REMOVED***
      ***REMOVED***
                      height: 10.0,
      ***REMOVED***,
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Row(
              ***REMOVED***
      ***REMOVED***
                              'Your Videos',
          ***REMOVED***
                                  fontSize: 25.0, fontWeight: FontWeight.bold),
              ***REMOVED***,
                            Spacer(),
      ***REMOVED***
                              'See All',
          ***REMOVED***
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black26),
              ***REMOVED***,
          ***REMOVED***
          ***REMOVED***),
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
                      ***REMOVED***
                                    borderRadius: BorderRadius.circular(30.0),
                                    color: Colors.blue,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset: Offset(
                                            0, 3), // changes position of shadow
                        ***REMOVED***,
                    ***REMOVED***
                    ***REMOVED***,
                                  child: Center(
                ***REMOVED***recordedVideos[i].name +
                                        ' ' +
                                        Timestamp.fromMillisecondsSinceEpoch(
                                                recordedVideos[i].date)
                                            .toDate()
                                            .toString()),
                    ***REMOVED***),
                              //TODO set up this so that it works with actual videos / streams
                              /*onTap: () {
          ***REMOVED***
        ***REMOVED***
        ***REMOVED***builder: (context) => ShowVideoPage(videoDownloadUrl: recordedVideos[i].videoUrl,)),
                            ***REMOVED***
                              ***REMOVED***,*/
              ***REMOVED***,
                      ***REMOVED***
                        ***REMOVED***,
        ***REMOVED***,
      ***REMOVED***,
  ***REMOVED***
  ***REMOVED***,
***REMOVED***
***REMOVED***
***REMOVED***
***REMOVED***
  ***REMOVED***
    ***REMOVED***
  ***REMOVED***

  Widget _buildCalendar() {
    return Container(
      //color: Color(0xff465466),
      //color: Colors.white,
      child: TableCalendar(
        rowHeight: 40.0,
        onDaySelected: (DateTime date, List<dynamic> events) {
    ***REMOVED***
            selectedDate = date;
            selectedPrivateSessions = events;
          ***REMOVED***);
        ***REMOVED***,
        locale: 'en_US',
        events: _calendarHelper.privateSessionsToEventMap(allPrivateSessions),
        calendarController: _calendarController,
        initialCalendarFormat: CalendarFormat.month,
        formatAnimation: FormatAnimation.slide,
        startingDayOfWeek: StartingDayOfWeek.sunday,
        availableGestures: AvailableGestures.horizontalSwipe,
        availableCalendarFormats: const {
          CalendarFormat.month: 'Month',
        ***REMOVED***,
        calendarStyle: CalendarStyle(
          weekdayStyle: TextStyle(color: Colors.black),
          weekendStyle: TextStyle(color: Colors.red),
          outsideStyle: TextStyle(color: Colors.grey),
          unavailableStyle: TextStyle(color: Colors.grey),
          outsideWeekendStyle: TextStyle(color: Colors.grey),
***REMOVED***
        daysOfWeekStyle: DaysOfWeekStyle(
          dowTextBuilder: (date, locale) {
            return DateFormat.E(locale)
                .format(date)
                .substring(0, 3)
                .toUpperCase();
          ***REMOVED***,
          weekdayStyle: TextStyle(color: Colors.grey),
          weekendStyle: TextStyle(color: Colors.grey),
***REMOVED***
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
  ***REMOVED***,
                margin: const EdgeInsets.all(4.0),
                width: 4,
                height: 4,
***REMOVED***
            ];
          ***REMOVED***,
          selectedDayBuilder: (context, date, _) {
            return Container(
              decoration: new BoxDecoration(
                color: Color(0xFF30A9B2),
                shape: BoxShape.circle,
***REMOVED***,
              margin: const EdgeInsets.all(4.0),
              width: 100,
              height: 100,
              child: Center(
                child: Text(
                  '${date.day***REMOVED***',
***REMOVED***
                    fontSize: 16.0,
                    color: Colors.white,
    ***REMOVED***,
  ***REMOVED***,
***REMOVED***,
        ***REMOVED***
          ***REMOVED***,
***REMOVED***
***REMOVED***
***REMOVED***
  ***REMOVED***

  getLengthFromInt(int length) {
    String duration = '';
    if (length > 60) {
      duration = duration + (length ~/ 60).toString() + ' hours ';
    ***REMOVED***
    duration = duration + (length % 60).toString() + ' minutes';
    return duration;
  ***REMOVED***
***REMOVED***
