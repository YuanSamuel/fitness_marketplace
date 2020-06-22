import 'package:fitnessmarketplace/models/PrivateSession.dart';
***REMOVED***
***REMOVED***

class AddSessionPage extends StatefulWidget {
  AddSessionPage({Key key, this.chosenDate, this.currentTrainer***REMOVED***) : super(key: key);

  final DateTime chosenDate;
  final Trainer currentTrainer;

***REMOVED***
  _AddSessionPageState createState() => _AddSessionPageState();
***REMOVED***

class _AddSessionPageState extends State<AddSessionPage> {
  TextEditingController _lengthController;
  DateTime selectedDate;

***REMOVED***
***REMOVED***
    _lengthController = new TextEditingController();
    selectedDate = widget.chosenDate;
***REMOVED***
  ***REMOVED***

***REMOVED***
***REMOVED***
***REMOVED***
      body: Column(
        children: [
          RaisedButton(
              child: Text('Choose a Date'),
              onPressed: () async {
                DateTime pickedDate = await showDatePicker(
                    context: context,
                    initialDate: selectedDate,
                    firstDate: DateTime(2019, 1),
                    lastDate: DateTime(2100, 12, 31));
                if (pickedDate != null && pickedDate != selectedDate) {
            ***REMOVED***
                    selectedDate = DateTime.utc(pickedDate.year, pickedDate.month, pickedDate.day, selectedDate.hour, selectedDate.minute);;
                  ***REMOVED***);
                ***REMOVED***
              ***REMOVED***),
          RaisedButton(
            child: Text('Choose a Time'),
            onPressed: () async {
              TimeOfDay pickedTime = await showTimePicker(context: context, initialTime: TimeOfDay(hour: 12, minute: 0));
              if (pickedTime != null) {
          ***REMOVED***
                  selectedDate = DateTime.utc(selectedDate.year, selectedDate.month, selectedDate.day, pickedTime.hour, pickedTime.minute);
                ***REMOVED***);
              ***REMOVED***
            ***REMOVED***,
***REMOVED***
          TextField(
            controller: _lengthController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: 'Enter Lesson Length in minutes'
***REMOVED***
***REMOVED***
          RaisedButton(
            child: Text('Submit'),
            onPressed: () async {
              PrivateSession addSession = PrivateSession(
                name: 'Do we need a name?',
                studentName: '',
                trainerName: widget.currentTrainer.firstName + ' ' + widget.currentTrainer.lastName,
                photoUrl: '',
                trainerUid: widget.currentTrainer.uid,
                available: true,
                length: int.parse(_lengthController.text),
                date: selectedDate.millisecondsSinceEpoch,
          ***REMOVED***
              await widget.currentTrainer.reference.collection('privateSessions').add(addSession.toJson());
              _lengthController.clear();
              Navigator.pop(context);
            ***REMOVED***,
          )
        ],
***REMOVED***
***REMOVED***
  ***REMOVED***
***REMOVED***
