import 'dart:math';

***REMOVED***
***REMOVED***
import 'package:fitnessmarketplace/helpers/calendar_helper.dart';
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
  int maxBoughtPrice;
  double endPrice;

  Map<String, MaterialColor> typeToColor = {
    'privateSession': Colors.blue,
    'stream': Colors.red,
    'ondemand': Colors.green
  ***REMOVED***;
  List<String> types = ['privateSession', 'stream', 'ondemand'];

***REMOVED***
***REMOVED***
    doneLoading = false;
    allTransactions = new List<RecordTransaction>();
    _calendarHelper = new CalendarHelper();
    maxBar = 0;
    maxTransactionLine = 0;
    endPrice = 0;
    maxBoughtPrice = 0;
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
    if (allTransactions.length != 0) {
      allTransactions.sort((RecordTransaction recordTransactionA,
          RecordTransaction recordTransactionB) {
        return recordTransactionA.purchaseDate -
            recordTransactionB.purchaseDate;
      ***REMOVED***);
      startDate = _calendarHelper.dateToInt(
          DateTime.fromMillisecondsSinceEpoch(allTransactions[0].purchaseDate));
      endDate = _calendarHelper.dateToInt(DateTime.fromMillisecondsSinceEpoch(
          allTransactions[allTransactions.length - 1].purchaseDate));
      allTransactions.sort((RecordTransaction recordTransactionA,
          RecordTransaction recordTransactionB) {
        return recordTransactionA.sessionDate - recordTransactionB.sessionDate;
      ***REMOVED***);
      startDate = min(
          startDate,
          _calendarHelper.dateToInt(DateTime.fromMillisecondsSinceEpoch(
              allTransactions[0].sessionDate)));
      endDate = max(
          endDate,
          _calendarHelper.dateToInt(DateTime.fromMillisecondsSinceEpoch(
              allTransactions[allTransactions.length - 1].sessionDate)));
    ***REMOVED***
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
      if (allTransactions.length == 0) {
    ***REMOVED***
          body: Center(
            child: Text('No Transaction Data'),
***REMOVED***
    ***REMOVED***
      ***REMOVED*** else {
        List<LineChartBarData> purchaseDateLine = new List<LineChartBarData>();
        purchaseDateLine = getTransactionLines('purchaseDate');
        List<LineChartBarData> sessionDateLine = new List<LineChartBarData>();
        sessionDateLine = getTransactionLines('sessionDate');
        List<LineChartBarData> priceLine = new List<LineChartBarData>();
        priceLine = getTransactionLines('price');
    ***REMOVED***
          body: allTransactions.length != 0
              ? SingleChildScrollView(
        ***REMOVED***
        ***REMOVED***
***REMOVED***
                        height: MediaQuery.of(context).size.height / 15,
        ***REMOVED***,
***REMOVED***
                        'Types purchased',
                        textAlign: TextAlign.center,
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
                                    left: BorderSide(
                                        color: Colors.black, width: 2.0),
                                    bottom: BorderSide(
                                        color: Colors.black, width: 2.0)),
                ***REMOVED***,
                              maxY: maxBar * 1.2,
              ***REMOVED***,
            ***REMOVED***,
          ***REMOVED***,
        ***REMOVED***,
***REMOVED***
                        'Dates Users Bought Items',
                        textAlign: TextAlign.center,
        ***REMOVED***,
                      createTransactionLineGraph(purchaseDateLine),
***REMOVED***
                        'Dates of Private Session or Class',
                        textAlign: TextAlign.center,
        ***REMOVED***,
                      createTransactionLineGraph(sessionDateLine),
***REMOVED***'Sessions Bought by Price'),
                      getLineGraphOther(priceLine),
    ***REMOVED***
    ***REMOVED***,
  ***REMOVED***
              : Center(child: Text('No Transaction Data')),
    ***REMOVED***
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
    barChartGroupData.sort((BarChartGroupData barChartGroupDataA,
        BarChartGroupData barChartGroupDataB) {
      return barChartGroupDataA.x - barChartGroupDataB.x;
    ***REMOVED***);
    return barChartGroupData;
  ***REMOVED***

  List<LineChartBarData> getTransactionLines(String variable) {
    List<LineChartBarData> lineData = new List<LineChartBarData>();

    for (int i = 0; i < types.length; i++) {
      List<FlSpot> spots = getSpotsByPurchaseDate(types[i], variable);
      if (spots != null && spots.length != 0) {
        lineData.add(LineChartBarData(
          spots: spots,
          colors: [typeToColor[types[i]]],
          dotData: FlDotData(
            show: spots.length == 1 ? true : false,
***REMOVED***
        ));
      ***REMOVED***
    ***REMOVED***
    return lineData;
  ***REMOVED***

  List<FlSpot> getSpotsByPurchaseDate(String type, String variable) {
    List<FlSpot> spots = new List<FlSpot>();
    if (variable == 'purchaseDate' || variable == 'sessionDate') {
      Map<int, int> countTransactionDates = new Map<int, int>();
      for (int i = 0; i < allTransactions.length; i++) {
        if (allTransactions[i].type == type) {
          int day = 0;
          if (variable == 'purchaseDate') {
            day = _calendarHelper.dateToInt(DateTime.fromMillisecondsSinceEpoch(
                allTransactions[i].purchaseDate));
          ***REMOVED*** else if (variable == 'sessionDate') {
            day = _calendarHelper.dateToInt(DateTime.fromMillisecondsSinceEpoch(
                allTransactions[i].sessionDate));
          ***REMOVED***
          if (countTransactionDates.containsKey(day)) {
            print('increase');
            countTransactionDates[day] = countTransactionDates[day] + 1;
          ***REMOVED*** else {
            countTransactionDates[day] = 1;
          ***REMOVED***
        ***REMOVED***
      ***REMOVED***
      List<int> countKeys = countTransactionDates.keys.toList();
      for (int i = startDate; i <= endDate; i++) {
        if (countKeys.contains(i)) {
          spots.add(
              new FlSpot(i.toDouble(), countTransactionDates[i].toDouble()));
          maxTransactionLine =
              max(countTransactionDates[i], maxTransactionLine);
        ***REMOVED*** else {
          spots.add(new FlSpot(i.toDouble(), 0.0));
        ***REMOVED***
      ***REMOVED***
      return spots;
    ***REMOVED*** else if (variable == 'price') {
      Map<double, int> countTransactionPrices = new Map<double, int>();
      for (int i = 0; i < allTransactions.length; i++) {
        if (allTransactions[i].type == type) {
          double price = allTransactions[i].price;
          if (countTransactionPrices.containsKey(price)) {
            countTransactionPrices[price] = countTransactionPrices[price] + 1;
          ***REMOVED*** else {
            endPrice = max(endPrice, price);
            countTransactionPrices[price] = 1;
          ***REMOVED***
        ***REMOVED***
      ***REMOVED***
      List<double> prices = countTransactionPrices.keys.toList();
      prices.sort();
      for (int i = 0; i < prices.length; i++) {
        maxBoughtPrice = max(maxBoughtPrice, countTransactionPrices[prices[i]]);
        spots.add(new FlSpot(
            prices[i], countTransactionPrices[prices[i]].toDouble()));
      ***REMOVED***
      return spots;
    ***REMOVED***
  ***REMOVED***

  Widget createTransactionLineGraph(List<LineChartBarData> data) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: LineChart(
          LineChartData(
              minX: startDate - 2.0,
              maxX: endDate + 2.0,
              minY: 0,
              maxY: maxTransactionLine * 1.2,
              lineBarsData: data,
              titlesData: FlTitlesData(
                show: true,
                bottomTitles: SideTitles(
                  showTitles: true,
                  interval: endDate != startDate
                      ? ((endDate - startDate) ~/ 3).toDouble()
                      : 1,
                  getTitles: (double givenDay) {
                    return _calendarHelper.intToDateString(givenDay.round());
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
              lineTouchData: LineTouchData(touchTooltipData:
                  LineTouchTooltipData(
                      getTooltipItems: (List<LineBarSpot> givenSpots) {
                List<LineTooltipItem> tooltipItems =
                    new List<LineTooltipItem>(givenSpots.length);
                for (int i = 0; i < givenSpots.length; i++) {
                  if (givenSpots[i].barIndex == 1) {
                    tooltipItems[0] = new LineTooltipItem(
                        _calendarHelper
                                .intToDateString(givenSpots[i].x.round()) +
                            ': ' +
                            givenSpots[i].y.toString(),
                        TextStyle(color: typeToColor['stream']));
                  ***REMOVED*** else if (givenSpots[i].barIndex == 0) {
                    tooltipItems[1] = new LineTooltipItem(
                        givenSpots[i].y.toString(),
                        TextStyle(color: typeToColor['privateSession']));
                  ***REMOVED*** else if (givenSpots[i].barIndex == 2) {
                    tooltipItems[2] = new LineTooltipItem(
                        givenSpots[i].y.toString(),
                        TextStyle(color: typeToColor['ondemand']));
                  ***REMOVED***
                ***REMOVED***
                return tooltipItems;
              ***REMOVED***))),
***REMOVED***
***REMOVED***
***REMOVED***
  ***REMOVED***

  Widget getLineGraphOther(List<LineChartBarData> data) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: LineChart(
          LineChartData(
            minX: 0,
            minY: 0,
            maxX: endPrice * 1.2,
            maxY: maxBoughtPrice * 1.2,
            lineBarsData: data,
            titlesData: FlTitlesData(
              show: true,
              bottomTitles: SideTitles(
                showTitles: true,
                interval: (endPrice ~/ 5).toDouble(),
***REMOVED***,
***REMOVED***
            borderData: FlBorderData(
              show: true,
              border: Border(
                bottom: BorderSide(
                  color: Colors.black,
                  width: 2.0,
  ***REMOVED***,
                left: BorderSide(
                  color: Colors.black,
                  width: 2.0,
  ***REMOVED***,
***REMOVED***,
***REMOVED***
            lineTouchData: LineTouchData(
              touchSpotThreshold: 4.0,
              touchTooltipData: LineTouchTooltipData(
                getTooltipItems: (List<LineBarSpot> givenSpots) {
                  List<LineTooltipItem> tooltipItems =
                      new List<LineTooltipItem>();
                  Map<String, int> getStuffs = new Map<String, int>();
                  for (int i = 0; i < givenSpots.length; i++) {
                    Color givenColor = givenSpots[i].bar.colors[0];
                    if (givenColor == typeToColor['stream']) {
                      getStuffs['stream'] = i;
                    ***REMOVED*** else if (givenColor == typeToColor['privateSession']) {
                      getStuffs['privateSession'] = i;
                    ***REMOVED*** else if (givenColor == typeToColor['ondemand']) {
                      getStuffs['ondemand'] = i;
                    ***REMOVED***
                  ***REMOVED***
                  bool addedX = false;
                  if (getStuffs.containsKey('stream')) {
                    LineBarSpot streamSpot = givenSpots[getStuffs['stream']];
                    tooltipItems.add(LineTooltipItem(
                        streamSpot.x.toStringAsFixed(2) +
                            ': ' +
                            streamSpot.y.toString(),
                        TextStyle(color: typeToColor['stream'])));
                    addedX = true;
                  ***REMOVED***
                  if (getStuffs.containsKey('privateSession')) {
                    LineBarSpot privateSessionSpot =
                        givenSpots[getStuffs['privateSession']];
                    if (!addedX) {
                      tooltipItems.add(LineTooltipItem(
                          privateSessionSpot.x.toStringAsFixed(2) +
                              ': ' +
                              privateSessionSpot.y.toString(),
                          TextStyle(color: typeToColor['privateSession'])));
                      addedX = true;
                    ***REMOVED*** else {
                      tooltipItems.add(LineTooltipItem(
                          privateSessionSpot.y.toString(),
                          TextStyle(color: typeToColor['privateSession'])));
                    ***REMOVED***
                  ***REMOVED***
                  if (getStuffs.containsKey('ondemand')) {
                    LineBarSpot videoSpot = givenSpots[getStuffs['ondemand']];
                    if (!addedX) {
                      tooltipItems.add(LineTooltipItem(
                          videoSpot.x.toStringAsFixed(2) +
                              ': ' +
                              videoSpot.y.toString(),
                          TextStyle(color: typeToColor['ondemand'])));
                      addedX = true;
                    ***REMOVED*** else {
                      tooltipItems.add(LineTooltipItem(videoSpot.y.toString(),
                          TextStyle(color: typeToColor['ondemand'])));
                    ***REMOVED***
                  ***REMOVED***
                  return tooltipItems;
                ***REMOVED***,
***REMOVED***,
***REMOVED***
***REMOVED***
***REMOVED***
***REMOVED***
***REMOVED***
  ***REMOVED***
***REMOVED***
