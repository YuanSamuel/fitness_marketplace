***REMOVED***
***REMOVED***
import 'package:fitnessmarketplace/models/RecordedVideo.dart';
import 'package:fitnessmarketplace/utils/trainer.dart';
import 'package:fitnessmarketplace/utils/cardio_market.dart';
import 'package:fitnessmarketplace/utils/martial_market.dart';
import 'package:fitnessmarketplace/utils/search_bar.dart';
import 'package:fitnessmarketplace/utils/weight_market.dart';
***REMOVED***
***REMOVED***

class MarketplaceScreen extends StatefulWidget {
***REMOVED***
  _MarketplaceScreenState createState() => _MarketplaceScreenState();
***REMOVED***

class _MarketplaceScreenState extends State<MarketplaceScreen> {
  List<Widget> pages = [WeightMarket(), CardioMarket(), MartialMarket()];
  int pageIndex = 0;
  PageController _pageController = new PageController(initialPage: 0);
  List<RecordedVideo> allVideos;

***REMOVED***
***REMOVED***
    getRecordedVideos();
***REMOVED***
  ***REMOVED***

  getRecordedVideos() async {
    allVideos = new List<RecordedVideo>();
    QuerySnapshot allVideosSnapshot =
        await Firestore.instance.collection('recordedVideos').getDocuments();
    List<DocumentSnapshot> allVideosDocuments = allVideosSnapshot.documents;
    for (int i = 0; i < allVideosDocuments.length; i++) {
      allVideos.add(RecordedVideo.fromSnapshot(allVideosDocuments[i]));
    ***REMOVED***
    setState(() {***REMOVED***);
  ***REMOVED***

***REMOVED***
***REMOVED***
***REMOVED***
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
***REMOVED***
***REMOVED***
***REMOVED***
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
***REMOVED***
***REMOVED***
***REMOVED***
***REMOVED***
***REMOVED***,
              SearchBar(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
      ***REMOVED***
      ***REMOVED***
      ***REMOVED***
      ***REMOVED***height: 10),
                    Container(
                      height: 50,
                      child: Expanded(
                        child: ListView(
                          scrollDirection: Axis.horizontal,
              ***REMOVED***
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
          ***REMOVED***
          ***REMOVED***,
        ***REMOVED***,
      ***REMOVED***,
                    FadeAnimationDown(
                        1.6,
                        Padding(
                          padding:
                          EdgeInsets.symmetric(horizontal: 5, vertical: 15),
      ***REMOVED***
                            "Popular Trainers",
        ***REMOVED***
                              color: Colors.grey[700],
                              fontSize: 20,
  ***REMOVED***
              ***REMOVED***,
            ***REMOVED***,
          ***REMOVED***),
  ***REMOVED***
  ***REMOVED***,
***REMOVED***,
***REMOVED***
                height: 0,
***REMOVED***,
              Container(
                height: MediaQuery.of(context).size.height / 3,
                child: PageView(
                  children: pages,
                  controller: _pageController,
                  physics: NeverScrollableScrollPhysics(),
  ***REMOVED***,
***REMOVED***,
***REMOVED***
                height: 0,
***REMOVED***,
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
      ***REMOVED***
                            "Trending Trainers",
        ***REMOVED***
                              color: Colors.grey[700],
                              fontSize: 20,
  ***REMOVED***
              ***REMOVED***,
            ***REMOVED***,
          ***REMOVED***,
        ***REMOVED***,
      ***REMOVED***,
    ***REMOVED***),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  height: 200,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
        ***REMOVED***
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
        ***REMOVED***,
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
        ***REMOVED***,
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
        ***REMOVED***,
    ***REMOVED***
    ***REMOVED***,
  ***REMOVED***,
***REMOVED***,
              FadeAnimationDown(
                  3.4,
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.center,
              ***REMOVED***
                        padding:
                        EdgeInsets.symmetric(horizontal: 5, vertical: 15),
    ***REMOVED***
                          "Upcoming Live Sessions",
      ***REMOVED***
      ***REMOVED***
                            fontSize: 23,
***REMOVED***
            ***REMOVED***,
          ***REMOVED***,
        ***REMOVED***,
      ***REMOVED***,
    ***REMOVED***),
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
                  ***REMOVED***
                    ***REMOVED***))
                    : SizedBox.shrink(),
***REMOVED***,
***REMOVED***
***REMOVED***
***REMOVED***
***REMOVED***
***REMOVED***
  ***REMOVED***

  Widget makeTraining({isActive, title, page***REMOVED***) {
    return GestureDetector(
      onTap: () {
  ***REMOVED***
          pageIndex = page;
          print(title);
          _pageController.animateToPage(pageIndex,
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOutSine);
        ***REMOVED***);
      ***REMOVED***,
      child: AspectRatio(
        aspectRatio: pageIndex == page ? 3 : 2.75 / 1,
        child: Container(
          margin: EdgeInsets.only(right: 10),
          decoration: BoxDecoration(
            color: pageIndex == page ? Colors.red[700] : Colors.white,
            borderRadius: BorderRadius.circular(50),
***REMOVED***
          child: Align(
            child: Text(
              title,
              style: TextStyle(
                color: pageIndex == page ? Colors.white : Colors.black,
                fontSize: 18,
                fontWeight:
                    pageIndex == page ? FontWeight.bold : FontWeight.w300,
***REMOVED***,
***REMOVED***
***REMOVED***
***REMOVED***
***REMOVED***
***REMOVED***
  ***REMOVED***

  Widget makeTrending(
      {image,
      name,
      category,
      languages,
      videoCount,
      sessions,
      video2,
      video,
      description***REMOVED***) {
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
      ***REMOVED***));
      ***REMOVED***,
      child: Hero(
        tag: name,
        child: Container(
          width: MediaQuery.of(context).size.width / 2.5,
          height: MediaQuery.of(context).size.height / 4,
          margin: EdgeInsets.only(right: 20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
***REMOVED***
                image: NetworkImage(image),
***REMOVED***
***REMOVED***),
          child: Container(
***REMOVED***
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(begin: Alignment.bottomCenter, stops: [
                  .2,
                  .9
***REMOVED*** colors: [
                  Colors.black.withOpacity(.9),
                  Colors.black.withOpacity(.3),
                ])),
    ***REMOVED***
              padding: EdgeInsets.all(15),
    ***REMOVED***
    ***REMOVED***
***REMOVED***
    ***REMOVED***
                  Align(
                    alignment: Alignment.topRight,
                    child: Icon(
                      Icons.favorite,
                      color: Colors.white,
      ***REMOVED***,
    ***REMOVED***,
                  Column(
        ***REMOVED***
        ***REMOVED***
***REMOVED***
                        name,
    ***REMOVED***
  ***REMOVED***
                          fontSize: 20,
    ***REMOVED***,
          ***REMOVED***,
        ***REMOVED***,
***REMOVED***
                        height: 5,
        ***REMOVED***,
***REMOVED***
                        category,
    ***REMOVED***color: Colors.grey, fontSize: 15),
        ***REMOVED***
    ***REMOVED***
    ***REMOVED***
***REMOVED***
***REMOVED***,
***REMOVED***
***REMOVED***
***REMOVED***
***REMOVED***
***REMOVED***
  ***REMOVED***

  Widget liveSession({image, name, date, people***REMOVED***) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: InkWell(
        onTap: () {***REMOVED***,
        child: Container(
          height: 100,
          width: 400,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
***REMOVED***
              //Hero
              Container(
                height: 100,
                width: 60,
    ***REMOVED***
      ***REMOVED***
                      image: NetworkImage(image),
      ***REMOVED***
      ***REMOVED***,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      bottomRight: Radius.circular(20),
      ***REMOVED***,
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(1, 1), blurRadius: 5, spreadRadius: 1)
                    ]),
***REMOVED***,
***REMOVED***
                width: 30,
***REMOVED***,
              Expanded(
      ***REMOVED***
      ***REMOVED***
      ***REMOVED***
      ***REMOVED***
      ***REMOVED***
      ***REMOVED***,
                    Text(
                      name,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ***REMOVED***,
      ***REMOVED***
                      height: 5,
      ***REMOVED***,
                    Text(
                      date,
  ***REMOVED***color: Colors.black45),
      ***REMOVED***,
      ***REMOVED***
      ***REMOVED***
      ***REMOVED***,
                    Text(
                      people.toString() + " people to attend",
  ***REMOVED***color: Colors.black45),
      ***REMOVED***,
  ***REMOVED***
  ***REMOVED***,
***REMOVED***,
              Align(
                alignment: Alignment.centerRight,
                child: OutlineButton(
                  child: Text('Register'),
                  borderSide: BorderSide(color: Colors.red),
                  onPressed: () {***REMOVED***,
                  highlightedBorderColor: Colors.red,
                  splashColor: Colors.redAccent.withOpacity(0.5),
                  color: Colors.red,
                  textColor: Colors.red,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
  ***REMOVED***,
***REMOVED***
***REMOVED***
***REMOVED***
***REMOVED***
***REMOVED***
***REMOVED***
  ***REMOVED***
***REMOVED***
