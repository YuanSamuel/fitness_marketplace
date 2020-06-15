***REMOVED***
***REMOVED***
import 'package:fitnessmarketplace/models/OneOnOneSession.dart';
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
  List<OneOnOneSession> oneOnOneSessions;

***REMOVED***
***REMOVED***
    _calendarController = CalendarController();
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
    oneOnOneSessions = new List<OneOnOneSession>();

    FirebaseUser getUser = await FirebaseAuth.instance.currentUser();
    DocumentSnapshot userData = await Firestore.instance
        .collection('trainers')
        .document(getUser.uid)
        .get();
    currentTrainer = Trainer.fromSnapshot(userData);

    await getOneOnOneSessions();
    await getVideos();

    setState(() {***REMOVED***);
  ***REMOVED***

  getVideos() async {
    QuerySnapshot getVideos = await currentTrainer.reference
        .collection('recordedVideos')
        .getDocuments();
    List<DocumentSnapshot> allVideos = getVideos.documents;
    for (int i = 0; i < allVideos.length; i++) {
      trainerVideos.add(RecordedVideo.fromSnapshot(allVideos[i]));
    ***REMOVED***
  ***REMOVED***

  getOneOnOneSessions() async {
    QuerySnapshot getOneOnOneSessions = await currentTrainer.reference
        .collection('oneOnOneSessions')
        .getDocuments();
    List<DocumentSnapshot> allOneOnOneSessions = getOneOnOneSessions.documents;
    for (int i = 0; i < allOneOnOneSessions.length; i++) {
      oneOnOneSessions
          .add(OneOnOneSession.fromSnapshot(allOneOnOneSessions[i]));
    ***REMOVED***
  ***REMOVED***

***REMOVED***
***REMOVED***
    if (currentTrainer == null) {
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
                child: Text(
                  '1 on 1 Sessions',
***REMOVED***fontSize: 25.0, fontWeight: FontWeight.bold),
  ***REMOVED***,
***REMOVED***,
              Container(
                height: 250.0,
                child: ListView.builder(
                  itemCount: oneOnOneSessions.length,
                  itemBuilder: (BuildContext context, int i) {
                    DateTime oneOnOneSessionDate =
                        oneOnOneSessions[i].date.toDate().toLocal();
                    String oneOnOneSessionLength =
                        getLengthFromInt(oneOnOneSessions[i].length);

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
                                  oneOnOneSessions[i].name,
              ***REMOVED***
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white),
                  ***REMOVED***,
          ***REMOVED***
                                  height: 10.0,
                  ***REMOVED***,
          ***REMOVED***
                                  oneOnOneSessionLength,
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
                                  oneOnOneSessionDate.month.toString() +
                                      '/' +
                                      oneOnOneSessionDate.day.toString(),
              ***REMOVED***
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white),
                  ***REMOVED***,
          ***REMOVED***
                                  height: 10.0,
                  ***REMOVED***,
          ***REMOVED***
                                  oneOnOneSessionDate.hour.toString() +
                                      ':' +
                                      oneOnOneSessionDate.minute.toString(),
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
                          itemCount: trainerVideos.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int i) {
                            print(i);
                            return Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: GestureDetector(
                                onTap: () {
                                  print('tapped');
                                  /*Navigator.push(
          ***REMOVED***
          ***REMOVED***
                                        builder: (context) => ShowVideoPage(
                                              videoDownloadUrl:
                                                  trainerVideos[i].videoUrl,
                              ***REMOVED***),
                              ***REMOVED****/
                                  //TODO make sessions database implementation
                                ***REMOVED***,
                                child: Container(
                                  height: 300.0,
                                  width: 300.0,
                                  child: Center(
                ***REMOVED***trainerVideos[i].name +
                                        '  ' +
                                        trainerVideos[i]
                                            .date
                                            .toDate()
                                            .toString()),
                    ***REMOVED***,
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

  String getLengthFromInt(int length) {
    String returnLength = '';
    if (length > 60) {
      returnLength = returnLength + (length ~/ 60).toString() + ' hours ';
    ***REMOVED***
    returnLength = returnLength + (length % 60).toString() + ' minutes';
    return returnLength;
  ***REMOVED***

  Map<DateTime, List<String>> getEvents() {
    Map<DateTime, List<String>> oneOnOneSessionsMap =
        new Map<DateTime, List<String>>();
    for (int i = 0; i < oneOnOneSessions.length; i++) {
      DateTime oneOnOneSessionDate = oneOnOneSessions[i].date.toDate();
      if (oneOnOneSessionsMap.containsKey(oneOnOneSessionDate)) {
        oneOnOneSessionsMap[oneOnOneSessionDate].add(oneOnOneSessions[i].name);
      ***REMOVED*** else {
        List<String> oneOnOneSessionsList = new List<String>();
        oneOnOneSessionsList.add(oneOnOneSessions[i].name);
        oneOnOneSessionsMap[oneOnOneSessionDate] = oneOnOneSessionsList;
      ***REMOVED***
    ***REMOVED***
    return oneOnOneSessionsMap;
  ***REMOVED***
***REMOVED***
