***REMOVED***
***REMOVED***
import 'package:fitnessmarketplace/helpers/calendar_helper.dart';
import 'package:fitnessmarketplace/models/PrivateSession.dart';
import 'package:fitnessmarketplace/models/Student.dart';
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
  Student currentStudent;
  CalendarController _calendarController;
  List<PrivateSession> privateSessionTimes;
  DateTime selectedDate;
  List<dynamic> events;

  CalendarHelper _calendarHelper;

***REMOVED***
***REMOVED***
    _calendarController = new CalendarController();
    _calendarHelper = new CalendarHelper();
    events = new List<PrivateSession>();
    getAvailablePrivateSessionTimes();
***REMOVED***
  ***REMOVED***

  void dispose() {
    _calendarController.dispose();
    super.dispose();
  ***REMOVED***

  setUp() async {
    await getCurrentUser();
    await getAvailablePrivateSessionTimes();
    setState(() {***REMOVED***);
  ***REMOVED***

  getCurrentUser() async {
    FirebaseUser getUser = await FirebaseAuth.instance.currentUser();
    DocumentSnapshot userData = await Firestore.instance
        .collection('students')
        .document(getUser.uid)
        .get();
    currentStudent = Student.fromSnapshot(userData);
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
              events: _calendarHelper
                  .privateSessionsToEventMap(privateSessionTimes),
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
                    return Padding(
                      padding: EdgeInsets.all(8.0),
                      child: GestureDetector(
                        child: Container(
                ***REMOVED***
                ***REMOVED***
        ***REMOVED***events[i].name),
        ***REMOVED***events[i].trainerName),
        ***REMOVED***DateTime.fromMillisecondsSinceEpoch(
                                      events[i].date)
                                  .toString()),
            ***REMOVED***
            ***REMOVED***,
          ***REMOVED***,
                        onTap: () {
                          events[i].reference.updateData({
                            'available': false,
                            'studentName': currentStudent.firstName +
                                ' ' +
                                currentStudent.lastName
                          ***REMOVED***);
                          addToUserPrivateSessions(events[i]);
                          Navigator.pop(context);
                        ***REMOVED***,
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
    DocumentSnapshot userSnapshot = await Firestore.instance
        .collection('students')
        .document(currentUser.uid)
        .get();
    Student student = Student.fromSnapshot(userSnapshot);
    session.available = false;
    session.studentName = student.firstName + ' ' + student.lastName;
    student.reference.collection('privateSessions').add(session.toJson());
  ***REMOVED***
***REMOVED***
