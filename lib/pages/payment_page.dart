import 'package:agora_rtc_engine/agora_rtc_engine.dart';
***REMOVED***
***REMOVED***
***REMOVED***
***REMOVED***
import 'package:fitnessmarketplace/pages/stream_page.dart';
***REMOVED***
***REMOVED***
***REMOVED***
***REMOVED***


 class PaymentPage extends StatefulWidget{
  const PaymentPage({Key key, this.stream, this.video, this.isStream***REMOVED***) : super(key: key);


   _PaymentPageState createState() => _PaymentPageState();
 ***REMOVED***
 ***REMOVED***
 ***REMOVED***

 ***REMOVED***

 class _PaymentPageState extends State<PaymentPage>{

 ***REMOVED***
 ***REMOVED***
 ***REMOVED***
 ***REMOVED***
 ***REMOVED***
 ***REMOVED***
   ***REMOVED***

 ***REMOVED***

   ***REMOVED***


 ***REMOVED***
 ***REMOVED***

 ***REMOVED***
 ***REMOVED***
 ***REMOVED***

   ***REMOVED***
 ***REMOVED***

   ***REMOVED***

  ***REMOVED***
***REMOVED***
***REMOVED***
      appBar: AppBar(
          actions: <Widget>[
            // action button
            IconButton(
              icon: Icon(Icons.arrow_right),
              onPressed: () {
                openVideo();
              ***REMOVED***,
***REMOVED***
          ],
        title: Text('Proceed to Payment',
        style: TextStyle(
          fontStyle: FontStyle.italic
 ***REMOVED***
        )
***REMOVED***
      body : Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage('https://www.debt.com/wp-content/uploads/2014/05/Credit-Card-Visa-Master-Card-Background.jpg'),
            fit: BoxFit.cover,
            alignment: Alignment.topCenter
          )
***REMOVED***

***REMOVED***
      floatingActionButton: FloatingActionButton(
        onPressed:_pay,
        tooltip: 'Enter Card Number',
        child: Icon(Icons.payment),
***REMOVED***

***REMOVED***
  ***REMOVED***

   VideoInfo getVidInfoFromDs(DocumentSnapshot ds){
     return VideoInfo(
       videoUrl: ds.data['videoUrl'],
       thumbUrl: ds.data['thumbUrl'],
       coverUrl: ds.data['coverUrl'],
       aspectRatio: ds.data['aspectRatio'],
       videoName: ds.data['videoName'],
       uploadedAt: ds.data['uploadedAt'],
 ***REMOVED***
   ***REMOVED***

  Future openVideo(){
     if (widget.isStream){
       Navigator.push(
         context,
         MaterialPageRoute(builder: (context) => StreamPage(role: ClientRole.Broadcaster,channelName: widget.stream.reference.documentID,)),
   ***REMOVED***
     ***REMOVED***
 ***REMOVED***
       VideoInfo video = getVidInfoFromDs(widget.video);
       Navigator.push(
         context,
         MaterialPageRoute(
           builder: (context) {
             return Player(
               video: video,
         ***REMOVED***
           ***REMOVED***,
 ***REMOVED***
   ***REMOVED***
     ***REMOVED***
  ***REMOVED***




 ***REMOVED***

