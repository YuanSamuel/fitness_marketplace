import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitnessmarketplace/pages/show_video_page.dart';

class TrainerHomePage extends StatefulWidget {
  TrainerHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _TrainerHomePageState createState() => _TrainerHomePageState();
}

class _TrainerHomePageState extends State<TrainerHomePage> {
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        SizedBox(
          height: MediaQuery.of(context).size.height / 10,
        ),
        Text(
          'My Videos',
          style: TextStyle(fontSize: 20),
        ),
        FutureBuilder<List<String>>(
          future: getTrainerVideos(),
          builder: (context, AsyncSnapshot<List<String>> snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return CircularProgressIndicator();
            } else {
              List<String> downloadUrls = snapshot.data;
              return downloadUrls != null
                  ? Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: downloadUrls.length,
                            itemBuilder: (context, i) {
                              return Container(
                                width: 50.0,
                                height: 50.0,
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                ),
                                child: GestureDetector(
                                  child: Text(
                                    i.toString(),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onTap: () {
                                    print('tapped');
                                    print(downloadUrls[i]);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ShowVideoPage(
                                                videoDownloadUrl:
                                                    downloadUrls[i],
                                              )),
                                    );
                                  },
                                ),
                              );
                            }),
                      ),
                    )
                  : SizedBox.shrink();
            }
          },
        )
      ]),
    );
  }

  Future<List<String>> getTrainerVideos() async {
    List<String> downloadUrls = new List<String>();
    QuerySnapshot allVideos =
        await Firestore.instance.collection('videos').getDocuments();
    for (int i = 0; i < allVideos.documents.length; i++) {
      downloadUrls.add(allVideos.documents[i].data['url']);
    }
    return downloadUrls;
  }
}
