***REMOVED***
***REMOVED***
import 'package:fitnessmarketplace/helpers/calendar_helper.dart';
import 'package:fitnessmarketplace/helpers/string_helper.dart';
import 'package:fitnessmarketplace/models/PrivateSession.dart';
import 'package:fitnessmarketplace/models/Stream.dart' as models;
import 'package:fitnessmarketplace/models/Student.dart';
import 'package:fitnessmarketplace/pages/session_preview_page.dart';
***REMOVED***
***REMOVED***
import 'package:table_calendar/table_calendar.dart';
***REMOVED***
***REMOVED***

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
  List<models.Stream> streamTimes;
  DateTime selectedDate;
  List<dynamic> events;
  PrivateSession selectedPrivateSession;

  CalendarHelper _calendarHelper;
  StringHelper _stringHelper;

***REMOVED***
***REMOVED***
    _calendarController = new CalendarController();
    _calendarHelper = new CalendarHelper();
    _stringHelper = new StringHelper();
    events = new List<PrivateSession>();
    setUp();
***REMOVED***
  ***REMOVED***

  void dispose() {
    _calendarController.dispose();
    super.dispose();
  ***REMOVED***

  setUp() async {
    await getCurrentUser();
    await getAvailablePrivateSessionTimes();
    await getTrainerStreams();
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
  ***REMOVED***

  getTrainerStreams() async {
    streamTimes = new List<models.Stream>();
    QuerySnapshot streams =
        await widget.trainer.reference.collection('streams').getDocuments();
    List<DocumentSnapshot> streamSnapshots = streams.documents;
    for (int i = 0; i < streamSnapshots.length; i++) {
      streamTimes.add(models.Stream.fromSnapshot(streamSnapshots[i]));
    ***REMOVED***
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
              events: _calendarHelper.listToEventMap(
                  privateSessionTimes, streamTimes),
              onDaySelected: (DateTime date, List<dynamic> givenEvents) {
          ***REMOVED***
                  events = givenEvents;
                ***REMOVED***);
              ***REMOVED***,
***REMOVED***
            Container(
              height: 200,
              child: ListView.builder(
                  itemCount: events.length,
                  itemBuilder: (BuildContext context, int i) {
                    String trainerName = widget.trainer.firstName +
                        ' ' +
                        widget.trainer.lastName;

                    bool isStream = events[i] is models.Stream;

                    String length = isStream
                        ? _stringHelper
                            .intToLengthString(events[i].minutes.floor())
                        : _stringHelper.intToLengthString(events[i].length);

                    DateTime date =
                        DateTime.fromMillisecondsSinceEpoch(events[i].date)
                            .toLocal();

                    return GestureDetector(
                      onTap: () {
                        if (events[i] is models.Stream) {
                          print("STUFF SHOULD BE HAPPENING?");
    ***REMOVED***
  ***REMOVED***
  ***REMOVED***
                                builder: (context) => SessionPreview(
                                      stream: events[i],
                                      isStream: true,
                                      trainer: widget.trainer,
                      ***REMOVED***),
                      ***REMOVED***
                        ***REMOVED*** else {
                          selectedPrivateSession = events[i];
                      ***REMOVED***
                        ***REMOVED***
                        //Navigator.pop(context);
                      ***REMOVED***,
              ***REMOVED***
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 15.0),
              ***REMOVED***
                            borderRadius: BorderRadius.circular(30.0),
                            color: Colors.blue,
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
                                            events[i].title + ' - Live Class',
                                            overflow: TextOverflow.fade,
                        ***REMOVED***
                                              fontSize: 20.0,
                  ***REMOVED***
                      ***REMOVED***
                              ***REMOVED***,
                            ***REMOVED***
                                        : Text(
                                            'Private Session with: ' +
                                                trainerName,
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
                  ***REMOVED***),
***REMOVED***
          ],
***REMOVED***
  ***REMOVED***
    ***REMOVED***
  ***REMOVED***

  void _pay() {
    InAppPayments.setSquareApplicationId(
        '***REMOVED***');
***REMOVED***
***REMOVED***
***REMOVED***
***REMOVED***
  ***REMOVED***

  void _onCardEntryCancel() {***REMOVED***
  void _onCardNonceRequestSuccess(CardDetails result) {
***REMOVED***

***REMOVED***
***REMOVED***
***REMOVED***
  ***REMOVED***

  void _cardEntryComplete() {
    selectedPrivateSession.reference.updateData({
      'available': false,
      'studentName': currentStudent.firstName + ' ' + currentStudent.lastName
    ***REMOVED***);

    selectedPrivateSession.available = false;
    selectedPrivateSession.studentName =
        currentStudent.firstName + ' ' + currentStudent.lastName;
    currentStudent.reference
        .collection('privateSessions')
        .add(selectedPrivateSession.toJson());

    currentStudent.reference.collection('transactions').add({
      'type': "privateSession",
      'sessionID': selectedPrivateSession.reference.documentID,
      'price': widget.trainer.oneOnOnePrice,
      'trainer': widget.trainer.reference.documentID,
      'sessionDate': selectedPrivateSession.date,
***REMOVED***
    ***REMOVED***);

    widget.trainer.reference.collection("transactions").add({
      'type': "privateSession",
      'sessionID': selectedPrivateSession.reference.documentID,
      'price': widget.trainer.oneOnOnePrice,
      'trainer': widget.trainer.reference.documentID,
      'sessionDate': selectedPrivateSession.date,
***REMOVED***
    ***REMOVED***);

    Navigator.pop(context);
  ***REMOVED***
***REMOVED***
