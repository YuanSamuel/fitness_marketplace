import 'dart:math';

***REMOVED***
***REMOVED***
import 'package:fitnessmarketplace/helpers/calendar_helper.dart';
import 'package:fitnessmarketplace/models/PrivateSession.dart';
import 'package:fitnessmarketplace/models/RecordedVideo.dart';
import 'package:fitnessmarketplace/models/RecordTransaction.dart';
***REMOVED***
import 'package:fl_chart/fl_chart.dart';
***REMOVED***
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class TrainerFinancesPage extends StatefulWidget {
  TrainerFinancesPage({Key key***REMOVED***) : super(key: key);

***REMOVED***
  _TrainerFinancesPageState createState() => _TrainerFinancesPageState();
***REMOVED***

class _TrainerFinancesPageState extends State<TrainerFinancesPage> {
  Trainer currentTrainer;
  List<RecordTransaction> allTransactions;
  bool doneLoading;

  CalendarHelper _calendarHelper;
  int maxBar;
  int startDate;
  int endDate;
  int maxTransactionLine;

  Map<String, MaterialColor> typeToColor = {
    'privateSession': Colors.blue,
    'stream': Colors.red,
    'video': Colors.green
  ***REMOVED***;
  List<String> types = ['privateSession', 'stream', 'video'];

***REMOVED***
***REMOVED***
    doneLoading = false;
    allTransactions = new List<RecordTransaction>();
    _calendarHelper = new CalendarHelper();
    maxBar = 0;
    maxTransactionLine = 0;
    setUp();
***REMOVED***
  ***REMOVED***

  setUp() async {
    await getUser();
    await getTransactions();
    setState(() {
      doneLoading = true;
    ***REMOVED***);
  ***REMOVED***

  getUser() async {
    FirebaseUser getUser = await FirebaseAuth.instance.currentUser();
    DocumentSnapshot userData = await Firestore.instance
        .collection('trainers')
        .document(getUser.uid)
        .get();
    currentTrainer = Trainer.fromSnapshot(userData);
  ***REMOVED***

  getTransactions() async {
    QuerySnapshot getTransactions = await currentTrainer.reference
        .collection('transactions')
        .getDocuments();
    List<DocumentSnapshot> transactionList = getTransactions.documents;
    for (int i = 0; i < transactionList.length; i++) {
      RecordTransaction currentTransaction =
          RecordTransaction.fromSnapshot(transactionList[i]);
      allTransactions.add(currentTransaction);
    ***REMOVED***
    print(allTransactions);
    allTransactions.sort((RecordTransaction recordTransactionA,
        RecordTransaction recordTransactionB) {
      return recordTransactionA.date - recordTransactionB.date;
    ***REMOVED***);
    startDate = _calendarHelper.dateToInt(
        DateTime.fromMillisecondsSinceEpoch(allTransactions[0].date));
    endDate = _calendarHelper.dateToInt(DateTime.fromMillisecondsSinceEpoch(
        allTransactions[allTransactions.length - 1].date));
  ***REMOVED***

***REMOVED***
***REMOVED***
    if (!doneLoading) {
  ***REMOVED***
        body: Center(
          child: CircularProgressIndicator(),
***REMOVED***
  ***REMOVED***
    ***REMOVED*** else {
      print(allTransactions);
      List<LineChartBarData> transactionLines = new List<LineChartBarData>();
      transactionLines = getTransactionLines();
      print(transactionLines);
  ***REMOVED***
        body: allTransactions.length != 0
            ? Column(
    ***REMOVED***
    ***REMOVED***
                    height: MediaQuery.of(context).size.height / 15,
    ***REMOVED***,
                  Container(
                    width: MediaQuery.of(context).size.width,
            ***REMOVED***
                      padding: EdgeInsets.all(16.0),
                      child: BarChart(
                        BarChartData(
                          barGroups: _getBarGroups(),
                          alignment: BarChartAlignment.spaceAround,
                          titlesData: FlTitlesData(
                            show: true,
                            bottomTitles: SideTitles(
                                showTitles: true,
                                interval: 1,
                                getTitles: (double index) {
                                  if (index == 0) {
                                    return 'Streams';
                                  ***REMOVED*** else if (index == 1) {
                                    return 'Private Sessions';
                                  ***REMOVED*** else if (index == 2) {
                                    return 'Videos';
                                  ***REMOVED*** else {
                                    return 'Other';
                                  ***REMOVED***
                                ***REMOVED***),
            ***REMOVED***,
                          borderData: FlBorderData(
                            show: true,
                            border: Border(
                                left:
                                    BorderSide(color: Colors.black, width: 2.0),
                                bottom: BorderSide(
                                    color: Colors.black, width: 2.0)),
            ***REMOVED***,
                          maxY: maxBar * 1.2,
          ***REMOVED***,
        ***REMOVED***,
      ***REMOVED***,
    ***REMOVED***,
                  //hello
                  Container(
                    width: MediaQuery.of(context).size.width,
            ***REMOVED***
                      padding: EdgeInsets.all(16.0),
                      child: LineChart(
                        LineChartData(
                            minX: startDate - 2.0,
                            maxX: endDate + 2.0,
                            minY: 0,
                            maxY: maxTransactionLine * 1.2,
                            lineBarsData: transactionLines,
                            titlesData: FlTitlesData(
                              show: true,
                              bottomTitles: SideTitles(
                                showTitles: true,
                                interval: ((endDate - startDate) ~/ 5).toDouble(),
                                getTitles: (double givenDay) {
                                  return _calendarHelper
                                      .intToDateString(givenDay.round());
                                ***REMOVED***,
                                textStyle: TextStyle(
                                  fontSize: 12.0,
                                  color: Colors.black,
                  ***REMOVED***,
                ***REMOVED***,
              ***REMOVED***,
                            borderData: FlBorderData(
                              border: Border(
                                left: BorderSide(
                                  color: Colors.black,
                                  width: 2.0,
                  ***REMOVED***,
                                bottom: BorderSide(
                                  color: Colors.black,
                                  width: 2.0,
                  ***REMOVED***,
                ***REMOVED***,
              ***REMOVED***,
          ***REMOVED***,
        ***REMOVED***,
      ***REMOVED***,
    ***REMOVED***
***REMOVED***
***REMOVED***
            : Center(child: Text('No Transaction Data')),
  ***REMOVED***
    ***REMOVED***
  ***REMOVED***

  List<BarChartGroupData> _getBarGroups() {
    Map<String, int> countTypes = new Map<String, int>();
    for (int i = 0; i < allTransactions.length; i++) {
      String type = allTransactions[i].type;
      if (countTypes.containsKey(type)) {
        countTypes[type] = countTypes[type] + 1;
      ***REMOVED*** else {
        countTypes[type] = 1;
      ***REMOVED***
    ***REMOVED***
    List<BarChartGroupData> barChartGroupData = new List<BarChartGroupData>();
    List<String> keyList = countTypes.keys.toList();
    for (int i = 0; i < keyList.length; i++) {
      print(keyList[i]);
      print(countTypes[keyList[i]]);
      maxBar = max(countTypes[keyList[i]], maxBar);
      int index = 3;
      if (keyList[i] == 'stream') {
        index = 0;
      ***REMOVED*** else if (keyList[i] == 'ondemand') {
        index = 2;
      ***REMOVED*** else if (keyList[i] == 'privateSession') {
        index = 1;
      ***REMOVED***
      barChartGroupData.add(BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            y: countTypes[keyList[i]].toDouble(),
            color: typeToColor[keyList[i]],
***REMOVED***
        ],
      ));
    ***REMOVED***
    barChartGroupData.sort((BarChartGroupData barChartGroupDataA, BarChartGroupData barChartGroupDataB) {
      return barChartGroupDataA.x - barChartGroupDataB.x;
    ***REMOVED***);
    return barChartGroupData;
  ***REMOVED***

  List<LineChartBarData> getTransactionLines() {
    List<LineChartBarData> lineData = new List<LineChartBarData>();

    for (int i = 0; i < types.length; i++) {
      List<FlSpot> spots = getTransactionSpots(types[i]);
      if (spots != null && spots.length != 0) {
        print('added');
        lineData.add(LineChartBarData(
          spots: spots,
          colors: [typeToColor[types[i]]],
          dotData: FlDotData(
            show: false,
***REMOVED***
        ));
      ***REMOVED***
    ***REMOVED***
    return lineData;
  ***REMOVED***

  List<FlSpot> getTransactionSpots(String type) {
    List<FlSpot> spots = new List<FlSpot>();
    Map<int, int> countTransactions = new Map<int, int>();
    for (int i = 0; i < allTransactions.length; i++) {
      if (allTransactions[i].type == type) {
        int day = _calendarHelper.dateToInt(
            DateTime.fromMillisecondsSinceEpoch(allTransactions[i].date));
        if (countTransactions.containsKey(day)) {
          countTransactions[day] = countTransactions[day] + 1;
        ***REMOVED*** else {
          countTransactions[day] = 1;
        ***REMOVED***
      ***REMOVED***
    ***REMOVED***
    List<int> countKeys = countTransactions.keys.toList();
    print(countKeys);
    for (int i = startDate; i <= endDate; i++) {
      if (countKeys.contains(i)) {
        print(countTransactions[i]);
        spots.add(new FlSpot(i.toDouble(), countTransactions[i].toDouble()));
        maxTransactionLine = max(countTransactions[i], maxTransactionLine);
      ***REMOVED***
  ***REMOVED***
        spots.add(new FlSpot(i.toDouble(), 0.0));
      ***REMOVED***
    ***REMOVED***
    return spots;
  ***REMOVED***

***REMOVED***
