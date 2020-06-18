import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitnessmarketplace/animations/FadeAnimationDown.dart';
import 'package:fitnessmarketplace/models/RecordedVideo.dart';
import 'package:fitnessmarketplace/widgets/trainer_market.dart';
import 'package:fitnessmarketplace/widgets//trainer_widget.dart';
import 'package:fitnessmarketplace/utils/search_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fitnessmarketplace/models/Trainer.dart';

class MarketplaceScreen extends StatefulWidget {
  @override
  _MarketplaceScreenState createState() => _MarketplaceScreenState();
}

class _MarketplaceScreenState extends State<MarketplaceScreen> {
  List<Widget> pages;
  int pageIndex = 0;
  PageController _pageController = new PageController(initialPage: 0);
  List<RecordedVideo> allVideos;
  List<Trainer> allTrainers;

  List<String> trainingTypes = [
    'Weight Lifting',
    'Cardio',
    'Martial Arts',
    'Running'
  ];

  @override
  void initState() {
    setUp();
    super.initState();
  }

  setUp() async {
    await getRecordedVideos();
    await getTrainers();
    setState(() {});
  }

  getRecordedVideos() async {
    allVideos = new List<RecordedVideo>();
    QuerySnapshot allVideosSnapshot =
        await Firestore.instance.collection('videos').getDocuments();
    List<DocumentSnapshot> allVideosDocuments = allVideosSnapshot.documents;
    for (int i = 0; i < allVideosDocuments.length; i++) {
      allVideos.add(RecordedVideo.fromSnapshot(allVideosDocuments[i]));
    }
    setState(() {});
  }

  getTrainers() async {
    allTrainers = new List<Trainer>();
    QuerySnapshot trainersSnapshot =
        await Firestore.instance.collection('trainers').getDocuments();
    List<DocumentSnapshot> trainersList = trainersSnapshot.documents;
    for (int i = 0; i < trainersList.length; i++) {
      allTrainers.add(Trainer.fromSnapshot(trainersList[i]));
    }
    pages = new List<Widget>();
    for (int i = 0; i < trainingTypes.length; i++) {
      pages.add(TrainerMarket(
        allTrainers: allTrainers,
        type: trainingTypes[i],
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        elevation: 5,
        brightness: Brightness.light,
        title: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text(
            'Fitness Marketplace',
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25),
          ),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              SearchBar(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Container(
                      height: 50,
                      child: Expanded(
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: trainingTypes.length,
                            itemBuilder: (BuildContext context, int i) {
                              return FadeAnimationDown(
                                  1 + i * 0.2,
                                  makeTraining(
                                      isActive: true,
                                      title: trainingTypes[i],
                                      page: i));
                            }),
                      ),
                    ),
                    FadeAnimationDown(
                        1.6,
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 5, vertical: 15),
                          child: Text(
                            "Popular Trainers",
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )),
                  ],
                ),
              ),
              SizedBox(
                height: 0,
              ),
              Container(
                height: MediaQuery.of(context).size.height / 3,
                child: pages != null
                    ? PageView(
                        children: pages,
                        controller: _pageController,
                        physics: NeverScrollableScrollPhysics(),
                      )
                    : CircularProgressIndicator(),
              ),
              SizedBox(
                height: 0,
              ),
              FadeAnimationDown(
                  2.6,
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: FadeAnimationDown(
                        0.7,
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 5, vertical: 15),
                          child: Text(
                            "Trending Trainers",
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )),
              allTrainers != null
                  ? Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                          height: 200,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: allTrainers.length,
                            itemBuilder: (BuildContext context, int i) {
                              Trainer currentTrainer = allTrainers[i];
                              return FadeAnimationDown(
                                0.7,
                                makeTrending(givenTrainer: currentTrainer),
                              );
                            },
                          )))
                  : CircularProgressIndicator(),
              FadeAnimationDown(
                  3.4,
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 15),
                        child: Text(
                          "Upcoming Live Sessions",
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: allVideos != null
                    ? Container(
                        height: 250,
                        child: ListView.builder(
                            itemCount: allVideos.length,
                            itemBuilder: (BuildContext context, int i) {
                              return FadeAnimationDown(
                                3.4 + i / 10,
                                liveSession(
                                    image:
                                        'https://cdn.pixabay.com/photo/2015/07/17/22/43/student-849825_1280.jpg',
                                    name: allVideos[i].name,
                                    date: Timestamp.fromMillisecondsSinceEpoch(
                                            allVideos[i].date)
                                        .toDate()
                                        .toString(),
                                    people: "No limit"),
                              );
                            }))
                    : SizedBox.shrink(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget makeTraining({isActive, title, page}) {
    return GestureDetector(
      onTap: () {
        setState(() {
          pageIndex = page;
          print(title);
          _pageController.animateToPage(pageIndex,
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOutSine);
        });
      },
      child: AspectRatio(
        aspectRatio: pageIndex == page ? 3 : 2.75 / 1,
        child: Container(
          margin: EdgeInsets.only(right: 10),
          decoration: BoxDecoration(
            color: pageIndex == page ? Colors.red[700] : Colors.white,
            borderRadius: BorderRadius.circular(50),
          ),
          child: Align(
            child: Text(
              title,
              style: TextStyle(
                color: pageIndex == page ? Colors.white : Colors.black,
                fontSize: 18,
                fontWeight:
                    pageIndex == page ? FontWeight.bold : FontWeight.w300,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget makeTrending({Trainer givenTrainer}) {
    String trainerName = givenTrainer.firstName + ' ' + givenTrainer.lastName;
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => TrainerWidget(
                      trainer: givenTrainer,
                    )));
      },
      child: Hero(
        tag: trainerName,
        child: Container(
          width: MediaQuery.of(context).size.width / 2.5,
          height: MediaQuery.of(context).size.height / 4,
          margin: EdgeInsets.only(right: 20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                image: NetworkImage(givenTrainer.profileUrl),
                fit: BoxFit.cover,
              )),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(begin: Alignment.bottomCenter, stops: [
                  .2,
                  .9
                ], colors: [
                  Colors.black.withOpacity(.9),
                  Colors.black.withOpacity(.3),
                ])),
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: Icon(
                      Icons.favorite,
                      color: Colors.white,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        trainerName,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        givenTrainer.trainingTypes.toString(),
                        style: TextStyle(color: Colors.grey, fontSize: 15),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget liveSession({image, name, date, people}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: InkWell(
        onTap: () {},
        child: Container(
          height: 100,
          width: 400,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              //Hero
              Container(
                height: 100,
                width: 60,
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(image),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(1, 1), blurRadius: 5, spreadRadius: 1)
                    ]),
              ),
              SizedBox(
                width: 30,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      name,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      date,
                      style: TextStyle(color: Colors.black45),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      people.toString() + " people to attend",
                      style: TextStyle(color: Colors.black45),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: OutlineButton(
                  child: Text('Register'),
                  borderSide: BorderSide(color: Colors.red),
                  onPressed: () {},
                  highlightedBorderColor: Colors.red,
                  splashColor: Colors.redAccent.withOpacity(0.5),
                  color: Colors.red,
                  textColor: Colors.red,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
