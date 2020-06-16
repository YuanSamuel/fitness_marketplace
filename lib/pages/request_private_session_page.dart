***REMOVED***
***REMOVED***
import 'package:fitnessmarketplace/models/PrivateSession.dart';
***REMOVED***
***REMOVED***
import 'package:table_calendar/table_calendar.dart';

class RequestPrivateSessionPage extends StatefulWidget {
  RequestPrivateSessionPage({Key key, this.trainer***REMOVED***) : super(key: key);

***REMOVED***

***REMOVED***
  _RequestPrivateSessionPageState createState() =>
      _RequestPrivateSessionPageState();
***REMOVED***

class _RequestPrivateSessionPageState extends State<RequestPrivateSessionPage> {
  CalendarController _calendarController;
  List<PrivateSession> privateSessionTimes;
  DateTime selectedDate;
  List<PrivateSession> events;

***REMOVED***
***REMOVED***
    events = new List<PrivateSession>();
    _calendarController = new CalendarController();
    getAvailablePrivateSessionTimes();
***REMOVED***
  ***REMOVED***

  void dispose() {
    _calendarController.dispose();
    super.dispose();
  ***REMOVED***

  getAvailablePrivateSessionTimes() async {
    privateSessionTimes = new List<PrivateSession>();
    QuerySnapshot allPrivateSessionsSnapshot = await widget.trainer.reference
        .collection('privateSessions')
        .getDocuments();
    List<DocumentSnapshot> allPrivateSessionsList =
        allPrivateSessionsSnapshot.documents;

    for (int i = 0; i < allPrivateSessionsList.length; i++) {
      PrivateSession currentPrivateSession =
          PrivateSession.fromSnapshot(allPrivateSessionsList[i]);
      if (currentPrivateSession.available) {
        privateSessionTimes.add(currentPrivateSession);
      ***REMOVED***
    ***REMOVED***
    setState(() {***REMOVED***);
  ***REMOVED***

***REMOVED***
***REMOVED***
    if (privateSessionTimes == null) {
  ***REMOVED***
        body: Center(
          child: CircularProgressIndicator(),
***REMOVED***
  ***REMOVED***
    ***REMOVED*** else {
  ***REMOVED***
        body: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 20,
***REMOVED***
            TableCalendar(
              calendarController: _calendarController,
              events: getAvailableTimes(),
              onDaySelected: (DateTime date, List<dynamic> givenEvents) {
                events = givenEvents;
          ***REMOVED******REMOVED***);
              ***REMOVED***,
***REMOVED***
            Container(
              height: 200,
              child: ListView.builder(
                  itemCount: events.length,
                  itemBuilder: (BuildContext context, int i) {
                    return GestureDetector(
                      child: Container(
              ***REMOVED***
              ***REMOVED***
      ***REMOVED***events[i].name),
      ***REMOVED***events[i].trainerName),
      ***REMOVED***events[i].date.toDate().toString()),
          ***REMOVED***
          ***REMOVED***,
        ***REMOVED***,
                      onTap: () {
                        events[i].reference.updateData({'available': false***REMOVED***);
                        addToUserPrivateSessions(events[i]);
                        Navigator.pop(context);
                      ***REMOVED***,
                ***REMOVED***
                  ***REMOVED***),
***REMOVED***
          ],
***REMOVED***
  ***REMOVED***
    ***REMOVED***
  ***REMOVED***

  addToUserPrivateSessions(PrivateSession session) async {
    FirebaseUser currentUser = await FirebaseAuth.instance.currentUser();
    session.available = false;
    Firestore.instance
        .collection('students')
        .document(currentUser.uid)
        .collection('privateSessions')
        .add(session.toJson());
  ***REMOVED***

  Map<DateTime, List<PrivateSession>> getAvailableTimes() {
    Map<DateTime, List<PrivateSession>> allTimes =
        new Map<DateTime, List<PrivateSession>>();

    for (int i = 0; i < privateSessionTimes.length; i++) {
      PrivateSession privateSession = privateSessionTimes[i];
      DateTime privateSessionDate = privateSession.date.toDate().toLocal();
      if (allTimes.containsKey(privateSessionDate)) {
        allTimes[privateSessionDate].add(privateSession);
      ***REMOVED*** else {
        List<PrivateSession> privateSessionsList = new List<PrivateSession>();
        privateSessionsList.add(privateSession);
        allTimes[privateSessionDate] = privateSessionsList;
      ***REMOVED***
    ***REMOVED***

    return allTimes;
  ***REMOVED***
***REMOVED***
