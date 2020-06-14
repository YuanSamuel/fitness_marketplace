***REMOVED***
***REMOVED***
***REMOVED***
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
***REMOVED***

class TrainerHomeScreen extends StatefulWidget {
***REMOVED***
  _TrainerHomeScreenState createState() => _TrainerHomeScreenState();
***REMOVED***

class _TrainerHomeScreenState extends State<TrainerHomeScreen> {
  List<String> names = ['Johnny Appleseed', 'Samuel Sam', 'John Smith'];
  List<String> dates = ['Jun 15, 5:00 pm', 'July 4, 9:00 pm', 'December 25, 12:00 am'];
  List<String> duration = ['45 minutes', '1 hour', '24 hours'];

  CalendarController _calendarController;
  Trainer currentTrainer;

***REMOVED***
  void initState(){
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
    FirebaseUser getUser = await FirebaseAuth.instance.currentUser();
    DocumentSnapshot userData = await Firestore.instance.collection('trainers').document(getUser.uid).get();
    setState(() {
      currentTrainer = Trainer.fromSnapshot(userData);
    ***REMOVED***);
  ***REMOVED***

***REMOVED***
***REMOVED***
    if (currentTrainer == null) {
  ***REMOVED***
        body: Center(
          child: CircularProgressIndicator(),
***REMOVED***
  ***REMOVED***
    ***REMOVED***
***REMOVED***
  ***REMOVED***
        body:
        SingleChildScrollView(
***REMOVED***
***REMOVED***
***REMOVED***
***REMOVED***height: 30.0,),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Text('Hello, ' + currentTrainer.firstName, style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.w600),),
***REMOVED***,
              Container(child: _buildCalendar()),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Text('1 on 1 Sessions', style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold
  ***REMOVED***,
  ***REMOVED***,
***REMOVED***,
              Container(
                height: 300.0,
                child: ListView.builder(
                  itemCount: names.length,
                  itemBuilder: (BuildContext context, int index){
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
                              offset: Offset(0, 3), // changes position of shadow
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
          ***REMOVED***names[index], style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600, color: Colors.white),),
          ***REMOVED***height: 10.0,),
          ***REMOVED***duration[index], style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w400, color: Colors.white),),
              ***REMOVED***
              ***REMOVED***,
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                  ***REMOVED***
          ***REMOVED***dates[index].substring(0, dates[index].indexOf(',')), style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w400, color: Colors.white),),
          ***REMOVED***height: 10.0,),
          ***REMOVED***dates[index].substring(dates[index].indexOf(',') + 2), style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w400, color: Colors.white),),
              ***REMOVED***
              ***REMOVED***
          ***REMOVED***
          ***REMOVED***,
        ***REMOVED***,
                ***REMOVED***
                  ***REMOVED***,
  ***REMOVED***,
***REMOVED***,
***REMOVED***height: 10.0,),
              Text('Your Videos',  style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold
***REMOVED***,
***REMOVED***,
              Container(
                height: 300.0,
                child: ListView.builder(
                  itemCount: 3,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index){
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
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
                              offset: Offset(0, 3), // changes position of shadow
              ***REMOVED***,
          ***REMOVED***
          ***REMOVED***,
        ***REMOVED***,
                ***REMOVED***
                  ***REMOVED***,
  ***REMOVED***,
***REMOVED***,
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
