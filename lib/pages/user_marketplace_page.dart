import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitnessmarketplace/animations/FadeAnimationDown.dart';
import 'package:fitnessmarketplace/animations/FadeAnimationUp.dart';
import 'package:fitnessmarketplace/models/RecordedVideo.dart';
import 'package:fitnessmarketplace/utils/trainer.dart';
import 'package:fitnessmarketplace/utils/cardio_market.dart';
import 'package:fitnessmarketplace/utils/martial_market.dart';
import 'package:fitnessmarketplace/utils/search_bar.dart';
import 'package:fitnessmarketplace/utils/weight_market.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MarketplaceScreen extends StatefulWidget {
  @override
  _MarketplaceScreenState createState() => _MarketplaceScreenState();
}

class _MarketplaceScreenState extends State<MarketplaceScreen> {
  List<Widget> pages = [WeightMarket(), CardioMarket(), MartialMarket()];
  int pageIndex = 0;
  PageController _pageController = new PageController(initialPage: 0);
  List<RecordedVideo> allVideos;

  @override
  void initState() {
    getRecordedVideos();
    super.initState();
  }

  getRecordedVideos() async {
    allVideos = new List<RecordedVideo>();
    QuerySnapshot allVideosSnapshot =
        await Firestore.instance.collection('recordedVideos').getDocuments();
    List<DocumentSnapshot> allVideosDocuments = allVideosSnapshot.documents;
    for (int i = 0; i < allVideosDocuments.length; i++) {
      allVideos.add(RecordedVideo.fromSnapshot(allVideosDocuments[i]));
    }
    setState(() {});
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
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            FadeAnimationDown(
                                1,
                                makeTraining(
                                    isActive: true,
                                    title: 'Weight Lifting',
                                    page: 0)),
                            FadeAnimationDown(
                                1.2,
                                makeTraining(
                                    isActive: false, title: 'Cardio', page: 1)),
                            FadeAnimationDown(
                                1.4,
                                makeTraining(
                                    isActive: false,
                                    title: 'Martial Arts',
                                    page: 2)),
                          ],
                        ),
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
                child: PageView(
                  children: pages,
                  controller: _pageController,
                  physics: NeverScrollableScrollPhysics(),
                ),
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
                        1.8,
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
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  height: 200,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      FadeAnimationDown(
                        2.8,
                        makeTrending(
                            image:
                            'https://www.keepthefaith.co.uk/wp-content/uploads/2018/08/personal_trainer.jpg',
                            name: 'Carlton Banks',
                            category: 'Weight Lifting',
                            languages: 'English, French',
                            videoCount: 25,
                            sessions: 14,
                            video:
                            'https://cbsnews1.cbsistatic.com/hub/i/2018/06/01/0e92bb08-8639-465e-a579-d6f4277cbf47/gettyimages-891415940.jpg',
                            video2:
                            'http://www.telegraph.co.uk/content/dam/health-fitness/2017/11/09/TELEMMGLPICT000146072663-xlarge_trans_NvBQzQNjv4Bqek9vKm18v_rkIPH9w2GMNtm3NAjPW-2_OvjCiS6COCU.jpeg',
                            description:
                            'Carlton integrates his knowledge as a strength and conditioning specialist in designing an individualized, progressive program of cardiovascular, mobility, core, and strength training exercises for his clients based on their fitness goals.'),
                      ),
                      FadeAnimationDown(
                        3.0,
                        makeTrending(
                            image:
                            'https://im.indiatimes.in/content/2017/Sep/fb_blackdoctor_org_1504271935_725x725.png',
                            name: 'Prasann Singhal',
                            category: 'Yoga',
                            languages: 'English, French',
                            videoCount: 35,
                            sessions: 5,
                            video:
                            'https://cbsnews1.cbsistatic.com/hub/i/2018/06/01/0e92bb08-8639-465e-a579-d6f4277cbf47/gettyimages-891415940.jpg',
                            video2:
                            'http://www.telegraph.co.uk/content/dam/health-fitness/2017/11/09/TELEMMGLPICT000146072663-xlarge_trans_NvBQzQNjv4Bqek9vKm18v_rkIPH9w2GMNtm3NAjPW-2_OvjCiS6COCU.jpeg',
                            description:
                            'Prasann defines his sessions as simple, challenging, and efficient with an emphasis on proper form and mobility. His favorite client is anyone with a goal and a willingness to work towards it!'),
                      ),
                      FadeAnimationDown(
                        3.2,
                        makeTrending(
                            image:
                            'http://www.gymsguide.com.au/wp-content/uploads/2014/08/Mobile-Personal-Training.jpg',
                            name: 'Samantha Malfoy',
                            category: 'Crossfit',
                            languages: 'English, Russian',
                            videoCount: 15,
                            sessions: 12,
                            video:
                            'https://cbsnews1.cbsistatic.com/hub/i/2018/06/01/0e92bb08-8639-465e-a579-d6f4277cbf47/gettyimages-891415940.jpg',
                            video2:
                            'http://www.telegraph.co.uk/content/dam/health-fitness/2017/11/09/TELEMMGLPICT000146072663-xlarge_trans_NvBQzQNjv4Bqek9vKm18v_rkIPH9w2GMNtm3NAjPW-2_OvjCiS6COCU.jpeg',
                            description:
                            'Samantha (or Sam for short) is an ACE Certified Personal Trainer and Group Fitness Instructor. She also holds a specialty certification as a Fitness Nutrition Specialist, Spinning Instructor, and TRX Instructor.'),
                      ),
                    ],
                  ),
                ),
              ),
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
                    ? Container(height: 250, child: ListView.builder(
                    itemCount: allVideos.length,
                    itemBuilder: (BuildContext context, int i) {
                      return FadeAnimationDown(
                        3.4 + i / 10,
                        liveSession(
                          image: 'https://cdn.pixabay.com/photo/2015/07/17/22/43/student-849825_1280.jpg',
                            name: allVideos[i].name,
                            date: allVideos[i].date.toDate().toString(),
                            people: allVideos[i].students),
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

  Widget makeTrending(
      {image,
      name,
      category,
      languages,
      videoCount,
      sessions,
      video2,
      video,
      description}) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Trainer(
                      image: image,
                      name: name,
                      category: category,
                      languages: languages,
                      videoCount: videoCount,
                      sessions: sessions,
                      video2: video2,
                      video: video,
                      description: description,
                    )));
      },
      child: Hero(
        tag: name,
        child: Container(
          width: MediaQuery.of(context).size.width / 2.5,
          height: MediaQuery.of(context).size.height / 4,
          margin: EdgeInsets.only(right: 20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                image: NetworkImage(image),
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
                        name,
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
                        category,
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
