import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitnessmarketplace/models/video_info.dart';
import 'package:fitnessmarketplace/pages/player.dart';
import 'package:fitnessmarketplace/pages/stream_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:square_in_app_payments/models.dart';
import 'package:square_in_app_payments/in_app_payments.dart';


 class PaymentPage extends StatefulWidget{
  const PaymentPage({Key key, this.stream, this.video, this.isStream, this.isPrivate}) : super(key: key);


   _PaymentPageState createState() => _PaymentPageState();
   final String stream;
   final DocumentSnapshot video;
   final bool isStream;
   final bool isPrivate;


 }

 class _PaymentPageState extends State<PaymentPage>{

   void _pay(){
     InAppPayments.setSquareApplicationId('***REMOVED***');
     InAppPayments.startCardEntryFlow(
       onCardNonceRequestSuccess: _onCardNonceRequestSuccess,
       onCardEntryCancel: _onCardEntryCancel,
     );
   }

   void _onCardEntryCancel(){

   }


   void _onCardNonceRequestSuccess(CardDetails result ){
     print('result.nonce');

     InAppPayments.completeCardEntry(
       onCardEntryComplete: _cardEntryComplete,
     );

   }
   void _cardEntryComplete(){

   }

    @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          actions: <Widget>[
            // action button
            IconButton(
              icon: Icon(Icons.arrow_right),
              onPressed: () {
                openVideo();
              },
            ),
          ],
        title: Text('Proceed to Payment',
        style: TextStyle(
          fontStyle: FontStyle.italic
         ),
        )
      ),
      body : Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage('https://www.debt.com/wp-content/uploads/2014/05/Credit-Card-Visa-Master-Card-Background.jpg'),
            fit: BoxFit.cover,
            alignment: Alignment.topCenter
          )
        ),

      ),
      floatingActionButton: FloatingActionButton(
        onPressed:_pay,
        tooltip: 'Enter Card Number',
        child: Icon(Icons.payment),
      ),

    );
  }

   VideoInfo getVidInfoFromDs(DocumentSnapshot ds){
     return VideoInfo(
       videoUrl: ds.data['videoUrl'],
       thumbUrl: ds.data['thumbUrl'],
       coverUrl: ds.data['coverUrl'],
       aspectRatio: ds.data['aspectRatio'],
       videoName: ds.data['videoName'],
       uploadedAt: ds.data['uploadedAt'],
     );
   }

  Future openVideo() async{
     if (widget.isStream){

      Navigator.push(
           context,
           MaterialPageRoute(builder: (context) => StreamPage(role: widget.isPrivate?ClientRole.Broadcaster:ClientRole.Audience,channelName: widget.stream,isTrainer: false,)),
         );
     }
     else{
       final FirebaseUser user = await FirebaseAuth.instance.currentUser();
       final uid = user.uid;

       await Firestore.instance.collection('students').document(uid).collection("videos").document().setData(widget.video.data);

       VideoInfo video = getVidInfoFromDs(widget.video);
       Navigator.push(
         context,
         MaterialPageRoute(
           builder: (context) {
             return Player(
               video: video,
             );
           },
         ),
       );
     }


  }
 }

