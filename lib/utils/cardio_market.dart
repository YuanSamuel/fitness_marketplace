import 'package:fitnessmarketplace/animations/FadeAnimationDown.dart';
import 'package:fitnessmarketplace/utils/Trainer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardioMarket extends StatefulWidget {
  @override
  _CardioMarketState createState() => _CardioMarketState();
}

class _CardioMarketState extends State<CardioMarket> {
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          FadeAnimationDown(1.8,makeTrainer(image: 'https://kubexfitness.com/wp-content/uploads/2018/07/Trainer.png',
              name: 'Samuel Yuan',
              pay: 25,
              category: 'Weight Lifting, Cardio',
              languages: 'English, Spanish',
              videoCount :150,
              sessions: 25,
              video: 'https://i.ibb.co/4ZZVV4k/trainer.jpg',
              video2: 'http://www.telegraph.co.uk/content/dam/health-fitness/2017/11/09/TELEMMGLPICT000146072663-xlarge_trans_NvBQzQNjv4Bqek9vKm18v_rkIPH9w2GMNtm3NAjPW-2_OvjCiS6COCU.jpeg',
              description: "Hey there! My name's Samuel, and I'm here to help you find yourself on your workout journey. I've been dedicated to helping others toward their fitness goals since 2002 and I've never backed down from a challenge. Train with me and I'll give you results you never thought possible!"
          ),),
      FadeAnimationDown(2.0,makeTrainer(image: 'https://onnitacademy.imgix.net/2015/07/personalt-trainer.jpg',
              name: 'Lucas Cai',
              pay: 19.99,
              category: 'Yoga, Cardio',
              languages: 'English, Chinese',
              videoCount :100,
              sessions: 18,
              video: 'https://cbsnews1.cbsistatic.com/hub/i/2018/06/01/0e92bb08-8639-465e-a579-d6f4277cbf47/gettyimages-891415940.jpg',
              video2: 'http://www.telegraph.co.uk/content/dam/health-fitness/2017/11/09/TELEMMGLPICT000146072663-xlarge_trans_NvBQzQNjv4Bqek9vKm18v_rkIPH9w2GMNtm3NAjPW-2_OvjCiS6COCU.jpeg',
              description: 'Lucas holds a BS in Physical Education as well as a MS in Exercise Science and Health Promotion. He is a Certified Strength and Conditioning Specialist (CSCS). He has a background in health and fitness as well as athletic performance training with over 20 years of certification and experience in the field.'),
      ),
      FadeAnimationDown(2.2,makeTrainer(image: 'https://www.precor.com/sites/default/files/community/iStock_000022826094Large.jpg',
              name: 'Vincent Do',
              pay: 49.99,
              category: 'Crossfit, Cardio',
              languages: 'English, Vietnamese',
              videoCount :200,
              sessions: 55,
              video: 'https://i.ibb.co/4ZZVV4k/trainer.jpg',
              video2: 'https://cbsnews1.cbsistatic.com/hub/i/2018/06/01/0e92bb08-8639-465e-a579-d6f4277cbf47/gettyimages-891415940.jpg',
              description: 'Vincent is an undergraduate student at Georgetown University. He became a National Academy of Sports Medicine (NASM) Certified Personal Trainer in 2019, and is currently working toward a specialization in corrective exercise. A lifelong dancer, Vincent believes wholeheartedly that movement is a necessary component of physical and mental wellness and personal expression.'),
      ),
        ],
      ),
    );
  }

  Widget makeTrainer({image, name, pay, category, languages, videoCount, sessions, video, video2, description}) {
    return Hero(
      tag: name,
      child: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => Trainer(
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
        child: Container(
          width: MediaQuery.of(context).size.width/2,
          height: MediaQuery.of(context).size.height/3,
          margin: EdgeInsets.only(right: 20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                image: NetworkImage(image),
                fit: BoxFit.cover,
              )
          ),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    stops: [.2,.9],
                    colors: [
                      Colors.black.withOpacity(.9),
                      Colors.black.withOpacity(.3),
                    ]
                )
            ),
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Icon(Icons.more_vert, color: Colors.white,),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(name, style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),),
                      SizedBox(height: 5,),
                      Text("\$"+pay.toString()+" each session", style: TextStyle(
                          color: Colors.white,
                          fontSize: 15
                      ),)
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
}