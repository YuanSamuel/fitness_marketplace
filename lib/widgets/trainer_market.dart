import 'package:fitnessmarketplace/animations/FadeAnimationDown.dart';
import 'package:fitnessmarketplace/models/Trainer.dart';
import 'package:fitnessmarketplace/widgets//trainer_widget.dart';
import 'package:flutter/material.dart';

class TrainerMarket extends StatefulWidget {
  TrainerMarket({Key key, this.allTrainers, this.type}) : super(key: key);

  final List<Trainer> allTrainers;
  final String type;

  @override
  _TrainerMarketState createState() => _TrainerMarketState();
}

class _TrainerMarketState extends State<TrainerMarket> {
  List<Trainer> trainers;

  @override
  void initState() {
    filterTrainers();
    super.initState();
  }

  void filterTrainers() {
    trainers = new List<Trainer>();
    for (int i = 0; i < widget.allTrainers.length; i++) {
      if (widget.allTrainers[i].trainingTypes.contains(widget.type)) {
        trainers.add(widget.allTrainers[i]);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: trainers.length,
          itemBuilder: (BuildContext context, int i) {
            return FadeAnimationDown(1.8, makeTrainer(trainers[i]));
          }),
    );
  }

  Widget makeTrainer(Trainer trainer) {
    String trainerName = trainer.firstName + ' ' + trainer.lastName;
    return Hero(
      tag: trainerName + 'new',
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => TrainerWidget(
                        trainer: trainer,
                      )));
        },
        child: Container(
          width: MediaQuery.of(context).size.width / 2,
          height: MediaQuery.of(context).size.height / 3,
          margin: EdgeInsets.only(right: 20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                image: NetworkImage(trainer.profileUrl),
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
                    alignment: Alignment.bottomRight,
                    child: Icon(
                      Icons.more_vert,
                      color: Colors.white,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        trainerName,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "\$" + trainer.livePrice.toString(),
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
