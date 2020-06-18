import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitnessmarketplace/animations/FadeAnimationDown.dart';
import 'package:fitnessmarketplace/pages/payment_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';


class SessionPreview extends StatefulWidget {
  //final String image;

  final DocumentReference trainer;
  const SessionPreview({Key key, this.trainer,}) : super(key: key);

  @override
  _SessionPreviewState createState() => _SessionPreviewState();
}

class _SessionPreviewState extends State<SessionPreview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(250),
        child: FadeAnimationDown(1, AppBar(
          shape: RoundedRectangleBorder(borderRadius:  BorderRadius.only(bottomRight: Radius.circular(20), bottomLeft: Radius.circular(20))),
          flexibleSpace: Container(
            height: 600,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(bottomRight: Radius.circular(20), bottomLeft: Radius.circular(20)),
              image: DecorationImage(
                image: NetworkImage("https://cnet1.cbsistatic.com/img/sRejNDr7D67rMcvwI11v6xrJcho=/940x0/2019/11/12/e66cc0f3-c6b8-4f6e-9561-e23e08413ce1/gettyimages-1002863304.jpg",),
                fit: BoxFit.cover,
              )
            ),
          ),
        ),
      ),),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FadeAnimationDown(1.2,Text(
                    "Gigantic Glute Workout",
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.8),
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),),
                ],
              ),
              SizedBox(height: 7,),
              FadeAnimationDown(1.4,Text("with Michael Reeves",
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.black54,
                  )),),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FadeAnimationDown(1.6,Row(
                    children: [
                      Icon(Icons.star, color: Colors.orange.shade700, size: 20),
                      Icon(Icons.star, color: Colors.orange.shade700, size: 20),
                      Icon(Icons.star, color: Colors.orange.shade700, size: 20),
                      Icon(Icons.star, color: Colors.orange.shade700, size: 20),
                      Icon(Icons.star, color: Colors.grey, size: 20),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "4.0",
                        style: TextStyle(
                            color: Colors.orange.shade700,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "(2460)",
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),),
                  FadeAnimationDown(1.8, OutlineButton(
                    highlightedBorderColor: Colors.redAccent,
                    splashColor: Colors.red.withOpacity(0.5),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    borderSide:
                    BorderSide(width: 2, color: Colors.red.shade300),
                    child: Text(
                      "View Trainer",
                      style: TextStyle(
                        color: Colors.redAccent,
                      ),
                    ),
                    onPressed: () {
                      //do something, maybe open up trainer page
                    },
                  )),
                ],
              ),
              SizedBox(height: 8,),
              FadeAnimationDown(2,Divider(
                thickness: 1.5,
              ),),
              SizedBox(height: 8,),
              FadeAnimationDown(2.1,Text(
                "About the session",
                style: TextStyle(
                    color: Colors.red.withOpacity(0.8),
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),),
              SizedBox(height: 8,),
              FadeAnimationDown(2.2,Text(
                "Reeves is back at it again with his classic glutes workout, ready to take you into a new level of satisfaction and fitness. He's ready to twist it, bop it, pull it, anything you think is necessary to get you a rocking hot body. This workout focuses on the glutes, and strecthing them into the curves you have so desperately desired.",
                style: TextStyle(color: Colors.grey, height: 1.5,
                fontSize: 14),
              ),),
              SizedBox(height: 10,),
              FadeAnimationDown(2.3,Divider(
                thickness: 1.5,
              ),),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  FadeAnimationDown(2.5,Container(
                    child: Text("Cost: \$25", style: TextStyle(
                      fontSize: 22,
                      color: Colors.black.withOpacity(0.8),
                      fontWeight: FontWeight.bold
                    ),)
                  ),),
                  FadeAnimationDown(2.6,ButtonTheme(
                    minWidth: 160,
                    height: 45,
                    child: FlatButton.icon(onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PaymentPage()),
                      );
                    },
                      icon: Icon(Icons.shopping_basket),
                      label: Text("PURCHASE", style: TextStyle(
                        color: Colors.white,
                      ),),
                      color: Colors.red,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  ),),),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
