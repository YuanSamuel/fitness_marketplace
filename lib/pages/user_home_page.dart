***REMOVED***
***REMOVED***
import 'package:fitnessmarketplace/helpers/string_helper.dart';
import 'package:fitnessmarketplace/helpers/calendar_helper.dart';
import 'package:fitnessmarketplace/models/PrivateSession.dart';
import 'package:fitnessmarketplace/models/RecordedVideo.dart';
import 'package:fitnessmarketplace/models/Stream.dart' as models;
***REMOVED***
***REMOVED***
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
  List<dynamic> trainervideos;
  List<models.Stream> allStreams;
  List<dynamic> selectedStreams;
  DateTime selectedDate;
  List<dynamic> allEvents;

  CalendarController _calendarController;

  StringHelper _stringHelper;
  CalendarHelper _calendarHelper;

  Widget makeVideo({image, vidReference***REMOVED***) {
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Player(video: vidReference)),
    ***REMOVED***
      ***REMOVED***,
      child: AspectRatio(
        aspectRatio: 1.5 / 1,
        child: Container(
          margin: EdgeInsets.only(right: 20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image:
              DecorationImage(image: NetworkImage(image), fit: BoxFit.cover)),
          child: Container(
***REMOVED***
                gradient: LinearGradient(begin: Alignment.bottomRight, colors: [
                  Colors.black.withOpacity(.9),
                  Colors.black.withOpacity(.3)
                ])),
            child: Align(
              child: Icon(
                Icons.play_arrow,
                color: Colors.white,
                size: 70,
***REMOVED***,
***REMOVED***
***REMOVED***
***REMOVED***
***REMOVED***
***REMOVED***
  ***REMOVED***

***REMOVED***
***REMOVED***
    _calendarController = CalendarController();
    _calendarHelper = new CalendarHelper();
    _stringHelper = new StringHelper();
    allEvents = new List<dynamic>();
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
    await getStreams();
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

  Future getRecordedVideos() async {
    QuerySnapshot queryVideos = await currentStudent.reference
        .collection('videos')
        .getDocuments();
    List<DocumentSnapshot> videoData = queryVideos.documents;
    setState(() {
      trainervideos = videoData;
    ***REMOVED***);
    setState(() {***REMOVED***);
  ***REMOVED***

  Future<void> getStreams() async {
    allStreams = new List<models.Stream>();
    selectedStreams = new List<models.Stream>();
    QuerySnapshot getStreams = await currentStudent.reference.collection('streams').getDocuments();
    List<DocumentSnapshot> streamSnapshots = getStreams.documents;
    for (int i = 0; i < streamSnapshots.length; i++) {
      allStreams.add(models.Stream.fromSnapshot(streamSnapshots[i]));
    ***REMOVED***
    return;
  ***REMOVED***


  VideoInfo getVidInfoFromDs(DocumentSnapshot ds){
    return VideoInfo(
      videoUrl: ds.data['videoUrl'],
      thumbUrl: ds.data['thumbUrl'],
      coverUrl: ds.data['coverUrl'],
      aspectRatio: ds.data['aspectRatio'],
      videoName: ds.data['videoName'],
      uploadedAt: ds.data['uploadedAt'],
***REMOVED***
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
                                Container(
                                  width: 7 * MediaQuery.of(context).size.width / 10,
                                  height: 40,
                                  child: isStream ? Text(
                                    allEvents[i].title + ' - Live Class',
                                    overflow: TextOverflow.fade,
                ***REMOVED***
              ***REMOVED***
                                      fontSize: 20.0,
          ***REMOVED***
                      ***REMOVED***,
                    ***REMOVED*** : Text(
                                    'Lesson with: ' +
                                        selectedPrivateSessions[i].trainerName,
                                    overflow: TextOverflow.fade,
                ***REMOVED***
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white),
                    ***REMOVED***,
                  ***REMOVED***,
          ***REMOVED***
                                  height: 10.0,
                  ***REMOVED***,
          ***REMOVED***
                                  length,
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
                                  date,
              ***REMOVED***
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white),
                  ***REMOVED***,
          ***REMOVED***
                                  height: 10.0,
                  ***REMOVED***,
          ***REMOVED***
                                  time,
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
                        itemCount: trainervideos.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int i) {

                          return Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: GestureDetector(
                              onTap: (){
          ***REMOVED***
        ***REMOVED***
        ***REMOVED***builder: (context) => Player(video: getVidInfoFromDs(trainervideos[i]))),
                            ***REMOVED***
                              ***REMOVED***,
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
                ***REMOVED***trainervideos[i].data["title"],
                    ***REMOVED***),)
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
          for (int i = 0; i < events.length; i++) {
            if (events[i] is models.Stream) {
              selectedStreams.add(events[i]);
            ***REMOVED***
        ***REMOVED***
              selectedPrivateSessions.add(events[i]);
            ***REMOVED***
          ***REMOVED***
    ***REMOVED***
            selectedDate = date;
            allEvents = events;
          ***REMOVED***);
        ***REMOVED***,
        locale: 'en_US',
        events: _calendarHelper.listToEventMap(allPrivateSessions, allStreams),
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
***REMOVED***
