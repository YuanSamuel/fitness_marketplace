import 'package:fitnessmarketplace/pages/profile_picture.dart';
***REMOVED***
import 'package:select_dialog/select_dialog.dart';
***REMOVED***
***REMOVED***
***REMOVED***

class TrainerRegister extends StatefulWidget {
***REMOVED***
  _TrainerRegisterState createState() => _TrainerRegisterState();
***REMOVED***

class _TrainerRegisterState extends State<TrainerRegister> {
  Trainer currentTrainer;

  double _privateSessionPrice;

  TypeOfExercise(String type) {
    return Container(
      height: 30,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          color: Colors.black12,
          border: Border.all(color: Colors.grey)),
      child: FlatButton(
***REMOVED***
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
          child: Text(
            type,
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black),
***REMOVED***
***REMOVED***
        onPressed: () {
          _type.remove(type);
    ***REMOVED***
            TrainerRegister();
          ***REMOVED***);
        ***REMOVED***,
***REMOVED***
***REMOVED***
  ***REMOVED***

  TextEditingController _desc = new TextEditingController();
  List _type = new List();

***REMOVED***
***REMOVED***
    _privateSessionPrice = 0;
    getCurrentTrainer();
***REMOVED***
  ***REMOVED***

  void getCurrentTrainer() async {
    FirebaseUser getUser = await FirebaseAuth.instance.currentUser();
    DocumentSnapshot trainerData = await Firestore.instance
        .collection('trainers')
        .document(getUser.uid)
        .get();
    currentTrainer = Trainer.fromSnapshot(trainerData);
    setState(() {***REMOVED***);
  ***REMOVED***

***REMOVED***
***REMOVED***
    if (currentTrainer == null) {
      TrainerRegister();
  ***REMOVED***
        backgroundColor: Colors.white,
        body: Center(
          child: Container(
            width: 50,
            height: 50,
            child: CircularProgressIndicator(),
***REMOVED***
***REMOVED***
  ***REMOVED***
    ***REMOVED*** else {
      _type = currentTrainer.trainingTypes;
  ***REMOVED***
        appBar: AppBar(
          backgroundColor: Colors.white,
***REMOVED***
        body: ListView(
          children: [
            Container(
    ***REMOVED***
    ***REMOVED***
    ***REMOVED***
                    height: 20,
    ***REMOVED***,
    ***REMOVED***
                    child: Container(
              ***REMOVED***
                        padding: EdgeInsets.all(5),
                        child: ListView(
              ***REMOVED***
                            TextField(
                              controller: _desc,
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(top: -20),
                                  hintText: 'Tell us about yourself',
                                  border: InputBorder.none),
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
              ***REMOVED***,
          ***REMOVED***
                          scrollDirection: Axis.vertical,
          ***REMOVED***,
        ***REMOVED***,
          ***REMOVED***
                        border: Border.all(
                          width: 3,
                          color: Colors.blue,
          ***REMOVED***,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
        ***REMOVED***,
      ***REMOVED***,
                    width: MediaQuery.of(context).size.width - 20,
                    height: 400,
    ***REMOVED***,
    ***REMOVED***
    ***REMOVED***
    ***REMOVED***,
                  Container(
                    height: 30,
            ***REMOVED***
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: ListView(
            ***REMOVED***
                          for (int i = 0; i < _type.length; i++)
                            Padding(
                              padding: EdgeInsets.only(right: 10),
                              child: TypeOfExercise(_type[i]),
              ***REMOVED***,
        ***REMOVED***
                        scrollDirection: Axis.horizontal,
        ***REMOVED***,
      ***REMOVED***,
    ***REMOVED***,
                  Container(
                    height: 5,
    ***REMOVED***,
                  FlatButton(
                    color: Colors.blue,
***REMOVED***
                      showDialog(
                          context: context,
                          builder: (_) => Scaffold(
                                body: SelectDialog(
                                  itemsList: [
                                    'Running',
                                    'Martial Arts',
                                    'Cardio',
                                    'Weight Lifting'
                  ***REMOVED***
                                  onChange: (String selected) {
                              ***REMOVED***
                                      bool hasSelected = false;
                                      for (int i = 0; i < _type.length; i++) {
                                        if (selected == _type[i]) {
                                          hasSelected = true;
                                        ***REMOVED***
                                      ***REMOVED***
                                      if (!hasSelected) {
                                        _type.add(selected);
                                      ***REMOVED***
                                    ***REMOVED***);
                                  ***REMOVED***,
                  ***REMOVED***,
                ***REMOVED***);
                    ***REMOVED***,
***REMOVED***'Select Type of Exercise'),
    ***REMOVED***,
                  Text(
                    'Private Session Price (per hour): ${double.parse(_privateSessionPrice.toStringAsFixed(2))***REMOVED***',
    ***REMOVED***,
                  Container(
                    width: 300,
                    child: Slider(
                      value: _privateSessionPrice,
                      onChanged: (_input) {
                  ***REMOVED***
                          _privateSessionPrice = _input;
                        ***REMOVED***);
                      ***REMOVED***,
                      min: 0,
                      max: 150,
      ***REMOVED***,
    ***REMOVED***,
                  FlatButton(
                    color: Colors.blue,
***REMOVED***'Continue'),
                    onPressed: () async {
                      final _user = await FirebaseAuth.instance.currentUser();
                      String _uid = _user.uid;
                      if (_type != null && _desc != null) {
                        if (_desc.text == '' || _desc.text == null) {
                          _desc = TextEditingController(
                              text: currentTrainer.description);
                        ***REMOVED***
                        Firestore.instance
                            .collection('trainers')
                            .document(_uid)
                            .updateData({
                          'trainingTypes': _type,
                          'rating': 0,
                          'description': _desc.text,
                          'oneOnOnePrice': _privateSessionPrice,
                        ***REMOVED***);
                        if (currentTrainer.description != '') {
                          Navigator.pop(context);
                        ***REMOVED*** else {
    ***REMOVED***
  ***REMOVED***
  ***REMOVED***
                                builder: (context) => ProfilePic()),
                      ***REMOVED***
                        ***REMOVED***
                      ***REMOVED***
                    ***REMOVED***,
    ***REMOVED***
***REMOVED***
***REMOVED***,
***REMOVED***
          ],
          scrollDirection: Axis.vertical,
***REMOVED***
  ***REMOVED***
    ***REMOVED***
  ***REMOVED***
***REMOVED***
