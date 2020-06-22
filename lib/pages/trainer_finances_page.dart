import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitnessmarketplace/helpers/calendar_helper.dart';
import 'package:fitnessmarketplace/models/RecordTransaction.dart';
import 'package:fitnessmarketplace/models/Trainer.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class TrainerFinancesPage extends StatefulWidget {
  TrainerFinancesPage({Key key}) : super(key: key);

  @override
  _TrainerFinancesPageState createState() => _TrainerFinancesPageState();
}

class _TrainerFinancesPageState extends State<TrainerFinancesPage> {
  Trainer currentTrainer;
  List<RecordTransaction> allTransactions;
  bool doneLoading;

  Size screenSize;

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
  };
  List<String> types = ['privateSession', 'stream', 'ondemand'];

  @override
  void initState() {
    doneLoading = false;
    allTransactions = new List<RecordTransaction>();
    _calendarHelper = new CalendarHelper();
    maxBar = 0;
    maxTransactionLine = 0;
    endPrice = 0;
    maxBoughtPrice = 0;
    setUp();
    super.initState();
  }

  setUp() async {
    await getUser();
    await getTransactions();
    setState(() {
      doneLoading = true;
    });
  }

  getUser() async {
    FirebaseUser getUser = await FirebaseAuth.instance.currentUser();
    DocumentSnapshot userData = await Firestore.instance
        .collection('trainers')
        .document(getUser.uid)
        .get();
    currentTrainer = Trainer.fromSnapshot(userData);
  }

  getTransactions() async {
    QuerySnapshot getTransactions = await currentTrainer.reference
        .collection('transactions')
        .getDocuments();
    List<DocumentSnapshot> transactionList = getTransactions.documents;
    for (int i = 0; i < transactionList.length; i++) {
      RecordTransaction currentTransaction =
          RecordTransaction.fromSnapshot(transactionList[i]);
      allTransactions.add(currentTransaction);
    }
    if (allTransactions.length != 0) {
      allTransactions.sort((RecordTransaction recordTransactionA,
          RecordTransaction recordTransactionB) {
        return recordTransactionA.purchaseDate -
            recordTransactionB.purchaseDate;
      });
      startDate = _calendarHelper.dateToInt(
          DateTime.fromMillisecondsSinceEpoch(allTransactions[0].purchaseDate));
      endDate = _calendarHelper.dateToInt(DateTime.fromMillisecondsSinceEpoch(
          allTransactions[allTransactions.length - 1].purchaseDate));
      allTransactions.sort((RecordTransaction recordTransactionA,
          RecordTransaction recordTransactionB) {
        return recordTransactionA.sessionDate - recordTransactionB.sessionDate;
      });
      startDate = min(
          startDate,
          _calendarHelper.dateToInt(DateTime.fromMillisecondsSinceEpoch(
              allTransactions[0].sessionDate)));
      endDate = max(
          endDate,
          _calendarHelper.dateToInt(DateTime.fromMillisecondsSinceEpoch(
              allTransactions[allTransactions.length - 1].sessionDate)));
    }
  }

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;
    if (!doneLoading) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      if (allTransactions.length == 0) {
        return Scaffold(
          body: Center(
            child: Text('No Transaction Data'),
          ),
        );
      } else {
        List<LineChartBarData> purchaseDateLine = new List<LineChartBarData>();
        purchaseDateLine = getTransactionLines('purchaseDate');
        List<LineChartBarData> sessionDateLine = new List<LineChartBarData>();
        sessionDateLine = getTransactionLines('sessionDate');
        List<LineChartBarData> priceLine = new List<LineChartBarData>();
        priceLine = getTransactionLines('price');
        return Scaffold(
          body: allTransactions.length != 0
              ? SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: screenSize.height / 15,
                      ),
                      Text(
                        'Types purchased',
                        textAlign: TextAlign.center,
                      ),
                      Container(
                        width: screenSize.width,
                        child: Padding(
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
                                      } else if (index == 1) {
                                        return 'Private Sessions';
                                      } else if (index == 2) {
                                        return 'Videos';
                                      } else {
                                        return 'Other';
                                      }
                                    }),
                              ),
                              borderData: FlBorderData(
                                show: true,
                                border: Border(
                                    left: BorderSide(
                                        color: Colors.black, width: 2.0),
                                    bottom: BorderSide(
                                        color: Colors.black, width: 2.0)),
                              ),
                              maxY: maxBar * 1.2,
                            ),
                          ),
                        ),
                      ),
                      Text(
                        'Dates Users Bought Items',
                        textAlign: TextAlign.center,
                      ),
                      createTransactionLineGraph(purchaseDateLine),
                      Text(
                        'Dates of Private Session or Class',
                        textAlign: TextAlign.center,
                      ),
                      createTransactionLineGraph(sessionDateLine),
                      Text('Sessions Bought by Price'),
                      getLineGraphOther(priceLine),
                    ],
                  ),
                )
              : Center(child: Text('No Transaction Data')),
        );
      }
    }
  }

  List<BarChartGroupData> _getBarGroups() {
    Map<String, int> countTypes = new Map<String, int>();
    for (int i = 0; i < allTransactions.length; i++) {
      String type = allTransactions[i].type;
      if (countTypes.containsKey(type)) {
        countTypes[type] = countTypes[type] + 1;
      } else {
        countTypes[type] = 1;
      }
    }
    List<BarChartGroupData> barChartGroupData = new List<BarChartGroupData>();
    List<String> keyList = countTypes.keys.toList();
    for (int i = 0; i < keyList.length; i++) {
      maxBar = max(countTypes[keyList[i]], maxBar);
      int index = 3;
      if (keyList[i] == 'stream') {
        index = 0;
      } else if (keyList[i] == 'ondemand') {
        index = 2;
      } else if (keyList[i] == 'privateSession') {
        index = 1;
      }
      print(index);
      barChartGroupData.add(BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            y: countTypes[keyList[i]].toDouble(),
            color: typeToColor[keyList[i]],
          ),
        ],
      ));
    }
    for (int i = 0; i < types.length; i++) {
      if (!keyList.contains(types[i])) {
        print(types[i]);
        int index = 0;
        if (types[i] == 'privateSession') {
          index = 1;
        }
        else if (types[i] == 'ondemand') {
          index = 2;
        }
        print(index);
        barChartGroupData.add(BarChartGroupData(
          x: index,
          barRods: [
            BarChartRodData(
              y: 0.0,
              color: typeToColor[types[i]],
            ),
          ],
        ));
      }
    }
    barChartGroupData.sort((BarChartGroupData barChartGroupDataA,
        BarChartGroupData barChartGroupDataB) {
      return barChartGroupDataA.x - barChartGroupDataB.x;
    });
    return barChartGroupData;
  }

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
          ),
        ));
      }
    }
    return lineData;
  }

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
          } else if (variable == 'sessionDate') {
            day = _calendarHelper.dateToInt(DateTime.fromMillisecondsSinceEpoch(
                allTransactions[i].sessionDate));
          }
          if (countTransactionDates.containsKey(day)) {
            print('increase');
            countTransactionDates[day] = countTransactionDates[day] + 1;
          } else {
            countTransactionDates[day] = 1;
          }
        }
      }
      List<int> countKeys = countTransactionDates.keys.toList();
      for (int i = startDate; i <= endDate; i++) {
        if (countKeys.contains(i)) {
          spots.add(
              new FlSpot(i.toDouble(), countTransactionDates[i].toDouble()));
          maxTransactionLine =
              max(countTransactionDates[i], maxTransactionLine);
        } else {
          spots.add(new FlSpot(i.toDouble(), 0.0));
        }
      }
      return spots;
    } else if (variable == 'price') {
      Map<double, int> countTransactionPrices = new Map<double, int>();
      for (int i = 0; i < allTransactions.length; i++) {
        if (allTransactions[i].type == type) {
          double price = allTransactions[i].price;
          if (countTransactionPrices.containsKey(price)) {
            countTransactionPrices[price] = countTransactionPrices[price] + 1;
          } else {
            endPrice = max(endPrice, price);
            countTransactionPrices[price] = 1;
          }
        }
      }
      List<double> prices = countTransactionPrices.keys.toList();
      prices.sort();
      for (int i = 0; i < prices.length; i++) {
        maxBoughtPrice = max(maxBoughtPrice, countTransactionPrices[prices[i]]);
        spots.add(new FlSpot(
            prices[i], countTransactionPrices[prices[i]].toDouble()));
      }
      return spots;
    }
  }

  Widget createTransactionLineGraph(List<LineChartBarData> data) {
    return Container(
      width: screenSize.width,
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
                  interval: (endDate - startDate) ~/ 3 != 0
                      ? ((endDate - startDate) ~/ 3).toDouble()
                      : 1,
                  getTitles: (double givenDay) {
                    return _calendarHelper.intToDateString(givenDay.round());
                  },
                  textStyle: TextStyle(
                    fontSize: 12.0,
                    color: Colors.black,
                  ),
                ),
              ),
              borderData: FlBorderData(
                border: Border(
                  left: BorderSide(
                    color: Colors.black,
                    width: 2.0,
                  ),
                  bottom: BorderSide(
                    color: Colors.black,
                    width: 2.0,
                  ),
                ),
              ),
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
                  } else if (givenSpots[i].barIndex == 0) {
                    tooltipItems[1] = new LineTooltipItem(
                        givenSpots[i].y.toString(),
                        TextStyle(color: typeToColor['privateSession']));
                  } else if (givenSpots[i].barIndex == 2) {
                    tooltipItems[2] = new LineTooltipItem(
                        givenSpots[i].y.toString(),
                        TextStyle(color: typeToColor['ondemand']));
                  }
                }
                return tooltipItems;
              }))),
        ),
      ),
    );
  }

  Widget getLineGraphOther(List<LineChartBarData> data) {
    return Container(
      width: screenSize.width,
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
              ),
            ),
            borderData: FlBorderData(
              show: true,
              border: Border(
                bottom: BorderSide(
                  color: Colors.black,
                  width: 2.0,
                ),
                left: BorderSide(
                  color: Colors.black,
                  width: 2.0,
                ),
              ),
            ),
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
                    } else if (givenColor == typeToColor['privateSession']) {
                      getStuffs['privateSession'] = i;
                    } else if (givenColor == typeToColor['ondemand']) {
                      getStuffs['ondemand'] = i;
                    }
                  }
                  bool addedX = false;
                  if (getStuffs.containsKey('stream')) {
                    LineBarSpot streamSpot = givenSpots[getStuffs['stream']];
                    tooltipItems.add(LineTooltipItem(
                        streamSpot.x.toStringAsFixed(2) +
                            ': ' +
                            streamSpot.y.toString(),
                        TextStyle(color: typeToColor['stream'])));
                    addedX = true;
                  }
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
                    } else {
                      tooltipItems.add(LineTooltipItem(
                          privateSessionSpot.y.toString(),
                          TextStyle(color: typeToColor['privateSession'])));
                    }
                  }
                  if (getStuffs.containsKey('ondemand')) {
                    LineBarSpot videoSpot = givenSpots[getStuffs['ondemand']];
                    if (!addedX) {
                      tooltipItems.add(LineTooltipItem(
                          videoSpot.x.toStringAsFixed(2) +
                              ': ' +
                              videoSpot.y.toString(),
                          TextStyle(color: typeToColor['ondemand'])));
                      addedX = true;
                    } else {
                      tooltipItems.add(LineTooltipItem(videoSpot.y.toString(),
                          TextStyle(color: typeToColor['ondemand'])));
                    }
                  }
                  return tooltipItems;
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
