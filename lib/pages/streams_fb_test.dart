

import 'dart:async';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
***REMOVED***
***REMOVED***
***REMOVED***
import './stream_page.dart';

class StreamsPage extends StatefulWidget {
***REMOVED***
  State<StatefulWidget> createState() => StreamsState();
***REMOVED***

class StreamsState extends State<StreamsPage> {
  /// create a channelController to retrieve text value
  final _channelController = TextEditingController();

  /// if channel textField is validated to have error
  bool _validateError = false;

  ClientRole _role = ClientRole.Broadcaster;
  String selected = "";

  final Firestore _firestore = Firestore.instance;


***REMOVED***
  void dispose() {
    // dispose input controller
    _channelController.dispose();
    super.dispose();
  ***REMOVED***

***REMOVED***
***REMOVED***
***REMOVED***
      appBar: AppBar(
        title: Text('Agora Flutter QuickStart'),
***REMOVED***
      floatingActionButton: FloatingActionButton(
        child: IconButton(
          onPressed: addStream,
          icon: Icon(Icons.add),
***REMOVED***
***REMOVED***
      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          height: 400,
***REMOVED***
            children: <Widget>[
***REMOVED***
***REMOVED***
                  Expanded(
                      child: TextField(
                        controller: _channelController,
                        decoration: InputDecoration(
                          errorText:
                          _validateError ? 'Channel name is mandatory' : null,
                          border: UnderlineInputBorder(
        ***REMOVED*** BorderSide(width: 1),
            ***REMOVED***,
                          hintText: 'Channel name',
          ***REMOVED***,
        ***REMOVED***)
***REMOVED***
***REMOVED***,
              Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: Firestore.instance
                        .collection("streams")
                        .orderBy("date")
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData)
                        return Center(
                          child: CircularProgressIndicator(),
                    ***REMOVED***

                      List<DocumentSnapshot> docs = snapshot.data.documents;

                      List<Widget> messages = new List<Widget>();

                      for (DocumentSnapshot d in docs) {
                        messages.add(
                            FlatButton(
                              onPressed: (){
                                selected= d.data['name'];
                                onJoinStream();
                              ***REMOVED***,
          ***REMOVED***d.data['name'])
              ***REMOVED***
                    ***REMOVED***
                      ***REMOVED***
                      return ListView(
                        children: messages,
                  ***REMOVED***
                    ***REMOVED***,
    ***REMOVED***),
***REMOVED***
***REMOVED***
***REMOVED***
***REMOVED***
***REMOVED***
  ***REMOVED***

  Future<void> onJoinStream() async {
    // update input validation
    await _handleCameraAndMic();
    // push video page with given channel name
    if(selected!=""){
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => StreamPage(
            channelName:selected,
            role: _role,
***REMOVED***
***REMOVED***
  ***REMOVED***
    ***REMOVED***
***REMOVED***
      print("YOU MUST CREATE STREAM");
    ***REMOVED***
  ***REMOVED***

  Future addStream() async{
    await _firestore.collection('streams').add({
      'trainer':"Test",
      'limit':30,
      'name':_channelController.text,
      'date':DateTime.now().millisecondsSinceEpoch
    ***REMOVED***);
    _channelController.clear();
  ***REMOVED***

***REMOVED***
    await PermissionHandler().requestPermissions(
      [PermissionGroup.camera, PermissionGroup.microphone],
***REMOVED***
  ***REMOVED***
***REMOVED***
