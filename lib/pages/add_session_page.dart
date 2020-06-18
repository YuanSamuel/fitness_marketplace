import 'package:fitnessmarketplace/models/PrivateSession.dart';
import 'package:fitnessmarketplace/models/Trainer.dart';
import 'package:flutter/material.dart';

class AddSessionPage extends StatefulWidget {
  AddSessionPage({Key key, this.chosenDate, this.currentTrainer}) : super(key: key);

  final DateTime chosenDate;
  final Trainer currentTrainer;

  @override
  _AddSessionPageState createState() => _AddSessionPageState();
}

class _AddSessionPageState extends State<AddSessionPage> {
  TextEditingController _lengthController;
  DateTime selectedDate;

  @override
  void initState() {
    _lengthController = new TextEditingController();
    selectedDate = widget.chosenDate;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  setState(() {
                    selectedDate = DateTime.utc(pickedDate.year, pickedDate.month, pickedDate.day, selectedDate.hour, selectedDate.minute);;
                  });
                }
              }),
          RaisedButton(
            child: Text('Choose a Time'),
            onPressed: () async {
              TimeOfDay pickedTime = await showTimePicker(context: context, initialTime: TimeOfDay(hour: 12, minute: 0));
              if (pickedTime != null) {
                setState(() {
                  selectedDate = DateTime.utc(selectedDate.year, selectedDate.month, selectedDate.day, pickedTime.hour, pickedTime.minute);
                });
              }
            },
          ),
          TextField(
            controller: _lengthController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: 'Enter Lesson Length in minutes'
            ),
          ),
          RaisedButton(

            child: Text('Submit'),
            onPressed: () async {
              _lengthController.clear();
              PrivateSession addSession = PrivateSession(
                name: 'Do we need a name?',
                length: int.parse(_lengthController.text),
                date: selectedDate.millisecondsSinceEpoch,
                available: true,
                studentName: '',
                photoUrl: '',
                trainerName: widget.currentTrainer.firstName + ' ' + widget.currentTrainer.lastName,
              );
              await widget.currentTrainer.reference.collection('privateSessions').add(addSession.toJson());
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }
}
