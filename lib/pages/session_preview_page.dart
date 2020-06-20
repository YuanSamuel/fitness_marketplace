***REMOVED***
***REMOVED***
***REMOVED***
***REMOVED***
***REMOVED***
***REMOVED***
import 'package:fitnessmarketplace/pages/payment_page.dart';
***REMOVED***
***REMOVED***
***REMOVED***
***REMOVED***


***REMOVED***
  //final String image;

***REMOVED***
***REMOVED***
***REMOVED***
***REMOVED***
  const SessionPreview({Key key, this.stream, this.isStream, this.video, this.trainer,***REMOVED***) : super(key: key);

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
***REMOVED***
***REMOVED***
***REMOVED***
***REMOVED***
***REMOVED***
***REMOVED***
***REMOVED***
***REMOVED***
***REMOVED***
      ***REMOVED***);
    ***REMOVED***);
  ***REMOVED***

***REMOVED***

***REMOVED***
    final uid = user.uid;

    print(uid);

    await Firestore.instance.collection('students').document(uid).collection('transactions').add({
***REMOVED***
***REMOVED***
***REMOVED***
***REMOVED***
      'date': DateTime.now().millisecondsSinceEpoch,
    ***REMOVED***);


    await Firestore.instance.collection('trainers').document(widget.isStream?widget.stream.trainer:widget.trainer.reference.documentID).collection("transactions").add({
***REMOVED***
***REMOVED***
***REMOVED***
***REMOVED***
      'date': DateTime.now().millisecondsSinceEpoch,
    ***REMOVED***);

    await _handleCameraAndMic();

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PaymentPage(isStream: widget.isStream, video: widget.video, stream: widget.stream.trainer,)),
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
***REMOVED***
    ***REMOVED***,),
***REMOVED***
***REMOVED***,
***REMOVED***
***REMOVED***
***REMOVED***
***REMOVED***
***REMOVED***
    ***REMOVED***),),

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
        ***REMOVED***,
***REMOVED***
***REMOVED***
    ***REMOVED***
***REMOVED***
***REMOVED***
***REMOVED***
        ***REMOVED***,
***REMOVED***
***REMOVED***
        ***REMOVED***,
***REMOVED***
***REMOVED***
    ***REMOVED***
***REMOVED***
***REMOVED***
    ***REMOVED***
        ***REMOVED***,
    ***REMOVED***
    ***REMOVED***,),
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
        ***REMOVED***,
      ***REMOVED***,
***REMOVED***
***REMOVED***
***REMOVED***
***REMOVED***
***REMOVED***
***REMOVED***
                ***REMOVED***));
***REMOVED***
                    ***REMOVED***,
    ***REMOVED***),
***REMOVED***
***REMOVED***,
***REMOVED***
***REMOVED***
***REMOVED***
***REMOVED***,),
***REMOVED***
***REMOVED***
***REMOVED***
***REMOVED***
***REMOVED***
***REMOVED***
***REMOVED***
***REMOVED***,),
***REMOVED***
***REMOVED***
***REMOVED***
***REMOVED***color: Colors.grey, height: 1.5,
***REMOVED***
***REMOVED***,),
***REMOVED***
***REMOVED***
***REMOVED***
***REMOVED***,),
***REMOVED***
***REMOVED***
***REMOVED***,
***REMOVED***
***REMOVED***
***REMOVED***
***REMOVED***
***REMOVED***"Cost: "+(widget.isStream?widget.stream.price.round():widget.video.data["price"].round()).toString(), style: TextStyle(
  ***REMOVED***
***REMOVED***
***REMOVED***
      ***REMOVED***,)
    ***REMOVED***,),
***REMOVED***
***REMOVED***
***REMOVED***
***REMOVED***
***REMOVED***
                    ***REMOVED***,
***REMOVED***
***REMOVED***
***REMOVED***
        ***REMOVED***,),
***REMOVED***
  ***REMOVED***borderRadius: BorderRadius.circular(20)),
    ***REMOVED***,),),
***REMOVED***
***REMOVED***
***REMOVED***
***REMOVED***
***REMOVED***
***REMOVED***
***REMOVED***
  ***REMOVED***
***REMOVED***
