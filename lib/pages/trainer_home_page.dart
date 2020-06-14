***REMOVED***
***REMOVED***
import 'package:fitnessmarketplace/pages/show_video_page.dart';

class TrainerHomePage extends StatefulWidget {
  TrainerHomePage({Key key, this.title***REMOVED***) : super(key: key);

  final String title;

***REMOVED***
  _TrainerHomePageState createState() => _TrainerHomePageState();
***REMOVED***

class _TrainerHomePageState extends State<TrainerHomePage> {
***REMOVED***
***REMOVED***
      body: Column(children: [
        SizedBox(
          height: MediaQuery.of(context).size.height / 10,
***REMOVED***
        Text(
          'My Videos',
          style: TextStyle(fontSize: 20),
***REMOVED***
        FutureBuilder<List<String>>(
          future: getTrainerVideos(),
          builder: (context, AsyncSnapshot<List<String>> snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return CircularProgressIndicator();
            ***REMOVED*** else {
              List<String> downloadUrls = snapshot.data;
              return downloadUrls != null
                  ? Expanded(
              ***REMOVED***
                        padding: EdgeInsets.all(10.0),
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: downloadUrls.length,
                            itemBuilder: (context, i) {
                              return Container(
                                width: 50.0,
                                height: 50.0,
                    ***REMOVED***
                                  color: Colors.green,
                  ***REMOVED***,
                                child: GestureDetector(
              ***REMOVED***i.toString(), style: TextStyle(color: Colors.white),),
                                  onTap: () {
                                    print('tapped');
                                    print(downloadUrls[i]);
              ***REMOVED***
            ***REMOVED***
            ***REMOVED***
                                          builder: (context) => ShowVideoPage(
                                            videoDownloadUrl: downloadUrls[i],
                            ***REMOVED***),
                                ***REMOVED***
                                  ***REMOVED***,
                  ***REMOVED***,
                          ***REMOVED***
                            ***REMOVED***),
        ***REMOVED***,
      ***REMOVED***
                  : SizedBox.shrink();
            ***REMOVED***
          ***REMOVED***,
        )
      ]),
***REMOVED***
  ***REMOVED***

  Future<List<String>> getTrainerVideos() async {
    List<String> downloadUrls = new List<String>();
    QuerySnapshot allVideos =
        await Firestore.instance.collection('videos').getDocuments();
    for (int i = 0; i < allVideos.documents.length; i++) {
      downloadUrls.add(allVideos.documents[i].data['url']);
    ***REMOVED***
    return downloadUrls;
  ***REMOVED***
***REMOVED***
