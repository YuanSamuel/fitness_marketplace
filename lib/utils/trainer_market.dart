***REMOVED***
***REMOVED***
import 'package:fitnessmarketplace/utils/trainer_widget.dart';
***REMOVED***

class TrainerMarket extends StatefulWidget {
  TrainerMarket({Key key, this.allTrainers, this.type***REMOVED***) : super(key: key);

  final List<Trainer> allTrainers;
  final String type;

***REMOVED***
  _TrainerMarketState createState() => _TrainerMarketState();
***REMOVED***

class _TrainerMarketState extends State<TrainerMarket> {
  List<Trainer> trainers;

***REMOVED***
***REMOVED***
    filterTrainers();
***REMOVED***
  ***REMOVED***

  void filterTrainers() {
    trainers = new List<Trainer>();
    for (int i = 0; i < widget.allTrainers.length; i++) {
      if (widget.allTrainers[i].trainingTypes.contains(widget.type)) {
        trainers.add(widget.allTrainers[i]);
      ***REMOVED***
    ***REMOVED***
  ***REMOVED***

***REMOVED***
***REMOVED***
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: trainers.length,
          itemBuilder: (BuildContext context, int i) {
            return FadeAnimationDown(1.8, makeTrainer(trainers[i]));
          ***REMOVED***),
***REMOVED***
  ***REMOVED***

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
        ***REMOVED***));
        ***REMOVED***,
        child: Container(
          width: MediaQuery.of(context).size.width / 2,
          height: MediaQuery.of(context).size.height / 3,
          margin: EdgeInsets.only(right: 20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
***REMOVED***
                image: NetworkImage(trainer.profileUrl),
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
                    alignment: Alignment.bottomRight,
                    child: Icon(
                      Icons.more_vert,
                      color: Colors.white,
      ***REMOVED***,
    ***REMOVED***,
                  Column(
        ***REMOVED***
        ***REMOVED***
***REMOVED***
                        trainerName,
    ***REMOVED***
  ***REMOVED***
  ***REMOVED***
    ***REMOVED***,
          ***REMOVED***,
        ***REMOVED***,
***REMOVED***
                        height: 5,
        ***REMOVED***,
***REMOVED***
                        "\$ADDTODB each session",
    ***REMOVED***color: Colors.white, fontSize: 15),
        ***REMOVED***
    ***REMOVED***
    ***REMOVED***,
***REMOVED***
***REMOVED***,
***REMOVED***
***REMOVED***
***REMOVED***
***REMOVED***
***REMOVED***
  ***REMOVED***
***REMOVED***
