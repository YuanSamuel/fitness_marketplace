
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
  Trainer t = null;

***REMOVED***
***REMOVED***
    // TODO: implement initState
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
        rating = value.data["rating"];
***REMOVED***
***REMOVED***
      ***REMOVED***);
    ***REMOVED***);
  ***REMOVED***

  Future makeTransaction(BuildContext context)async{

***REMOVED***
    final uid = user.uid;

    await Firestore.instance.collection('users').document(uid).collection("transactions").document().setData({
***REMOVED***
***REMOVED***
***REMOVED***
      'trainer': widget.isStream?widget.stream.trainer:widget.trainer.reference.documentID
    ***REMOVED***);




    await Firestore.instance.collection('trainers').document(widget.isStream?widget.stream.trainer:widget.trainer.reference.documentID).collection("transactions").document().setData({
***REMOVED***
***REMOVED***
***REMOVED***
      'trainer': widget.isStream?widget.stream.trainer:widget.trainer.reference.documentID
    ***REMOVED***);

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PaymentPage()),
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