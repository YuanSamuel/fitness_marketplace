***REMOVED***
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class TrainerHomeScreen extends StatefulWidget {
***REMOVED***
  _TrainerHomeScreenState createState() => _TrainerHomeScreenState();
***REMOVED***

class _TrainerHomeScreenState extends State<TrainerHomeScreen> {
  List<String> names = ['Johnny Appleseed', 'Samuel Sam', 'John Smith'];
  List<String> dates = ['Jun 15, 5:00 pm', 'July 4, 9:00 pm', 'December 25, 12:00 am'];
  List<String> duration = ['45 minutes', '1 hour', '24 hours'];

  CalendarController _calendarController;

***REMOVED***
  void initState(){
    _calendarController = CalendarController();
  ***REMOVED***

***REMOVED***
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  ***REMOVED***


***REMOVED***
***REMOVED***
***REMOVED***
      body:
      SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30.0,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Row(
    ***REMOVED***
                  Text('Trainer: Lucas', style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.w600),),
                  Spacer(),
                  IconButton(
                    icon: Icon(Icons.account_circle),
                    onPressed: (){***REMOVED***,
    ***REMOVED***
***REMOVED***
***REMOVED***
***REMOVED***
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Divider(height: 10.0, thickness: 0.75,),
***REMOVED***
            Container(child: _buildCalendar()),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Divider(height: 10.0, thickness: 0.75,),
***REMOVED***
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Text('Upcoming Sessions', style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold
***REMOVED***,
***REMOVED***,
***REMOVED***
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
***REMOVED***

            SizedBox(height: 10.0,),
            Container(
  ***REMOVED***
                color: Colors.white,
                border: Border.symmetric(
                 vertical: BorderSide(
                     width: 0.5,
                   color: Colors.black26
   ***REMOVED***,
  ***REMOVED***
***REMOVED***,
    ***REMOVED***
    ***REMOVED***
    ***REMOVED***
    ***REMOVED***height: 10.0,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal:15.0),
                    child:Row(
          ***REMOVED***
  ***REMOVED***'Your Videos',  style: TextStyle(
                            fontSize: 25.0,
      ***REMOVED***
          ***REMOVED***,
          ***REMOVED***,
                        Spacer(),
  ***REMOVED***'See All', style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w400,
                          color: Colors.black26
          ***REMOVED***,),
      ***REMOVED***
      ***REMOVED***
    ***REMOVED***,
                  Container(
                    color: Colors.white,
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
***REMOVED***,
            )
          ],
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
