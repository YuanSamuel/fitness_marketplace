import 'package:agora_rtc_engine/agora_rtc_engine.dart';
***REMOVED***
***REMOVED***
import 'package:fitnessmarketplace/apis/firebase_provider.dart';
import 'package:fitnessmarketplace/helpers/calendar_helper.dart';
import 'package:fitnessmarketplace/helpers/string_helper.dart';
import 'package:fitnessmarketplace/models/PrivateSession.dart';
import 'package:fitnessmarketplace/models/Stream.dart' as models;
***REMOVED***
import 'package:fitnessmarketplace/pages/add_new_screen.dart';
import 'package:fitnessmarketplace/pages/add_session_page.dart';
***REMOVED***
import 'package:fitnessmarketplace/pages/stream_page.dart';
***REMOVED***
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
***REMOVED***
import 'package:fitnessmarketplace/models/RecordedVideo.dart';

class TrainerHomePage extends StatefulWidget {
***REMOVED***
  _TrainerHomePageState createState() => _TrainerHomePageState();
***REMOVED***

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

***REMOVED***
***REMOVED***
    FirebaseProvider.listenToVideos((newVideos) {
***REMOVED***
        _videos = newVideos;
      ***REMOVED***);
    ***REMOVED***);
    selectedDate = DateTime.now();
    _calendarController = CalendarController();
    allEvents = new List<dynamic>();
    setUp();
***REMOVED***
  ***REMOVED***

***REMOVED***
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  ***REMOVED***

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

    setState(() {***REMOVED***);
  ***REMOVED***

  getVideos() async {
    QuerySnapshot getVideos =
        await currentTrainer.reference.collection('videos').getDocuments();
    List<DocumentSnapshot> allVideos = getVideos.documents;
    for (int i = 0; i < allVideos.length; i++) {
      trainerVideos.add(RecordedVideo.fromSnapshot(allVideos[i]));
    ***REMOVED***
  ***REMOVED***

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
    ***REMOVED***
  ***REMOVED***

  getStreams() async {
    allStreams = new List<models.Stream>();
    QuerySnapshot getStreams =
        await currentTrainer.reference.collection('streams').getDocuments();
    List<DocumentSnapshot> allStreamDocuments = getStreams.documents;
    for (int i = 0; i < allStreamDocuments.length; i++) {
      allStreams.add(models.Stream.fromSnapshot(allStreamDocuments[i]));
    ***REMOVED***
  ***REMOVED***

***REMOVED***
***REMOVED***
    if (currentTrainer == null) {
      TrainerHomePage();
  ***REMOVED***
        body: Center(
          child: CircularProgressIndicator(),
***REMOVED***
  ***REMOVED***
    ***REMOVED*** else {
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
                        'Trainer: ' + currentTrainer.firstName,
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
                child: Row(
      ***REMOVED***
                    Text(
                      'Private Sessions',
  ***REMOVED***
                          fontSize: 25.0, fontWeight: FontWeight.bold),
      ***REMOVED***,
                    Spacer(),
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () async {
                        await Navigator.push(
***REMOVED***
***REMOVED***
                              builder: (context) => AddSessionPage(
                                    chosenDate: selectedDate,
                                    currentTrainer: currentTrainer,
                    ***REMOVED***),
                    ***REMOVED***
                        await getPrivateSessions();
                  ***REMOVED******REMOVED***);
                      ***REMOVED***,
      ***REMOVED***,
  ***REMOVED***
  ***REMOVED***,
***REMOVED***,
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
  ***REMOVED***
***REMOVED***
***REMOVED***builder: (context) => StreamPage(channelName:currentTrainer.reference.documentID,role: ClientRole.Broadcaster,isTrainer: true,)),
                    ***REMOVED***

                      ***REMOVED***,
              ***REMOVED***
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 15.0),
              ***REMOVED***
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
                                    width: 7 *
                                        MediaQuery.of(context).size.width /
                                        10,
                                    height: 40,
                                    child: isStream
                                        ? Text(
                                            allEvents[i].title + ' - Live Class',
                                            overflow: TextOverflow.fade,
                        ***REMOVED***
                                              fontSize: 20.0,
                  ***REMOVED***
                      ***REMOVED***
                              ***REMOVED***,
                            ***REMOVED***
                                        : Text(
                                            allEvents[i].available
                                                ? 'Open Session'
                                                : 'Private Session with: ' +
                                                    allEvents[i].studentName,
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
                                    _stringHelper.dateTimeToDateString(date),
                ***REMOVED***
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white),
                    ***REMOVED***,
            ***REMOVED***
                                    height: 10.0,
                    ***REMOVED***,
            ***REMOVED***
                                    _stringHelper.dateTimeToTimeString(date),
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
        ***REMOVED***,
                ***REMOVED***
                  ***REMOVED***,
  ***REMOVED***,
***REMOVED***,
***REMOVED***
                height: 10.0,
***REMOVED***,
              Container(
                  height: 340.0,
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
                                    fontSize: 25.0,
            ***REMOVED***
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
***REMOVED***
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
              ***REMOVED***
            ***REMOVED***
            ***REMOVED***
                                          builder: (context) =>
                                              AddNewRecording()),
                                ***REMOVED***
                                    //TODO make sessions database implementation
                                  ***REMOVED***,
                                  child: Container(
                                    height: 300.0,
                                    width: 300.0,
                                    child: Center(
                                        child: FlatButton(
                                      child: Icon(Icons.add),
                      ***REMOVED***),
                        ***REMOVED***
                                      borderRadius: BorderRadius.circular(30.0),
                                      color: Colors.blue,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 5,
                                          blurRadius: 7,
                                          offset: Offset(0,
                                              3), // changes position of shadow
                          ***REMOVED***,
                      ***REMOVED***
                      ***REMOVED***,
                    ***REMOVED***,
                  ***REMOVED***,
                          ***REMOVED***
                            ***REMOVED***
                            return Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: GestureDetector(
                                onTap: () {
                                  print('tapped');
            ***REMOVED***
          ***REMOVED***
          ***REMOVED***
                                        builder: (context) => Player(
                                              video: _videos[i - 1],
                              ***REMOVED***),
                              ***REMOVED***
                                  //TODO make sessions database implementation
                                ***REMOVED***,
                                child: Container(
                                  height: 300.0,
                                  width: 300.0,
                                  child: Center(
                ***REMOVED***trainerVideos[i - 1].name +
                                        '  ' +
                                        Timestamp.fromMillisecondsSinceEpoch(
                                                trainerVideos[i - 1].date)
                                            .toDate()
                                            .toString()),
                    ***REMOVED***,
                      ***REMOVED***
                      ***REMOVED***
                                      image: Image.network(
                                              trainerVideos[i - 1].videoUrl)
                                          .image,
                      ***REMOVED***
                      ***REMOVED***,
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
                  ***REMOVED***,
                ***REMOVED***,
                        ***REMOVED***
                          ***REMOVED***,
          ***REMOVED***,
        ***REMOVED***
    ***REMOVED***
    ***REMOVED***),
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
            if (events[i] is PrivateSession) {
              privateSessions.add(events[i]);
            ***REMOVED*** else if (events[i] is models.Stream) {
              selectedStreams.add(events[i]);
            ***REMOVED***
          ***REMOVED***
    ***REMOVED***
            selectedDate = date;
            allEvents = events;
          ***REMOVED***);
        ***REMOVED***,
        locale: 'en_US',
        calendarController: _calendarController,
        initialCalendarFormat: CalendarFormat.month,
        formatAnimation: FormatAnimation.slide,
        startingDayOfWeek: StartingDayOfWeek.sunday,
        availableGestures: AvailableGestures.horizontalSwipe,
        events: _calendarHelper.listToEventMap(allPrivateSessions, allStreams),
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
