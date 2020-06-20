import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitnessmarketplace/helpers/calendar_helper.dart';
import 'package:fitnessmarketplace/models/PrivateSession.dart';
import 'package:fitnessmarketplace/models/RecordedVideo.dart';
import 'package:fitnessmarketplace/models/RecordTransaction.dart';
import 'package:fitnessmarketplace/models/Trainer.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class TrainerFinancesPage extends StatefulWidget {
  TrainerFinancesPage({Key key}) : super(key: key);

  @override
  _TrainerFinancesPageState createState() => _TrainerFinancesPageState();
}

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
  };
  List<String> types = ['privateSession', 'stream', 'video'];

  @override
  void initState() {
    doneLoading = false;
    allTransactions = new List<RecordTransaction>();
    _calendarHelper = new CalendarHelper();
    maxBar = 0;
    maxTransactionLine = 0;
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
    allTransactions.sort((RecordTransaction recordTransactionA,
        RecordTransaction recordTransactionB) {
      return recordTransactionA.date - recordTransactionB.date;
    });
    startDate = _calendarHelper.dateToInt(
        DateTime.fromMillisecondsSinceEpoch(allTransactions[0].date));
    endDate = _calendarHelper.dateToInt(DateTime.fromMillisecondsSinceEpoch(
        allTransactions[allTransactions.length - 1].date));
  }

  @override
  Widget build(BuildContext context) {
    if (!doneLoading) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      print(allTransactions);
      List<LineChartBarData> transactionLines = new List<LineChartBarData>();
      transactionLines = getTransactionLines();
      return Scaffold(
        body: allTransactions.length != 0
            ? Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 15,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
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
                                left:
                                    BorderSide(color: Colors.black, width: 2.0),
                                bottom: BorderSide(
                                    color: Colors.black, width: 2.0)),
                          ),
                          maxY: maxBar * 1.2,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
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
                                interval: (endDate - startDate) ~/ 5,
                                getTitles: (double givenDay) {
                                  return _calendarHelper
                                      .intToDateString(givenDay.round());
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
                            )),
                      ),
                    ),
                  )
                ],
              )
            : Center(child: Text('No Transaction Data')),
      );
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
      print(keyList[i]);
      print(countTypes[keyList[i]]);
      maxBar = max(countTypes[keyList[i]], maxBar);
      int index = 3;
      if (keyList[i] == 'stream') {
        index = 0;
      } else if (keyList[i] == 'ondemand') {
        index = 2;
      } else if (keyList[i] == 'privateSession') {
        index = 1;
      }
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
    barChartGroupData.sort((BarChartGroupData barChartGroupDataA, BarChartGroupData barChartGroupDataB) {
      return barChartGroupDataA.x - barChartGroupDataB.x;
    });
    return barChartGroupData;
  }

  List<LineChartBarData> getTransactionLines() {
    List<LineChartBarData> lineData = new List<LineChartBarData>();

    for (int i = 0; i < types.length; i++) {
      List<FlSpot> spots = getTransactionSpots(types[i]);
      if (spots != null && spots.length != 0) {
        lineData.add(LineChartBarData(
          spots: spots,
          colors: [typeToColor[types[i]]],
        ));
      }
    }
    return lineData;
  }

  List<FlSpot> getTransactionSpots(String type) {
    List<FlSpot> spots = new List<FlSpot>();
    Map<int, int> countTransactions = new Map<int, int>();
    for (int i = 0; i < allTransactions.length; i++) {
      if (allTransactions[i].type == type) {
        int day = _calendarHelper.dateToInt(
            DateTime.fromMillisecondsSinceEpoch(allTransactions[i].date));
        if (countTransactions.containsKey(day)) {
          countTransactions[day] = countTransactions[day] + 1;
        } else {
          countTransactions[day] = 1;
        }
      }
    }
    List<int> countKeys = countTransactions.keys.toList();
    for (int i = 0; i < countKeys.length; i++) {
      maxTransactionLine =
          max(countTransactions[countKeys[i]], maxTransactionLine);
      spots.add(new FlSpot(
          countKeys[i].toDouble(), countTransactions[countKeys[i]].toDouble()));
    }
    return spots;
  }
}
