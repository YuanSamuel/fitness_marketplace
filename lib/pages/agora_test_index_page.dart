import 'dart:async';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
***REMOVED***
***REMOVED***

import './stream_page.dart';

class IndexPage extends StatefulWidget {
***REMOVED***
  State<StatefulWidget> createState() => IndexState();
***REMOVED***

class IndexState extends State<IndexPage> {
  /// create a channelController to retrieve text value
  final _channelController = TextEditingController();

  /// if channel textField is validated to have error
  bool _validateError = false;

  ClientRole _role = ClientRole.Broadcaster;

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
              Column(
    ***REMOVED***
                  ListTile(
                    title: Text(ClientRole.Broadcaster.toString()),
                    leading: Radio(
                      value: ClientRole.Broadcaster,
                      groupValue: _role,
                      onChanged: (ClientRole value) {
                  ***REMOVED***
                          _role = value;
                        ***REMOVED***);
                      ***REMOVED***,
      ***REMOVED***,
    ***REMOVED***,
                  ListTile(
                    title: Text(ClientRole.Audience.toString()),
                    leading: Radio(
                      value: ClientRole.Audience,
                      groupValue: _role,
                      onChanged: (ClientRole value) {
                  ***REMOVED***
                          _role = value;
                        ***REMOVED***);
                      ***REMOVED***,
      ***REMOVED***,
    ***REMOVED***
***REMOVED***
***REMOVED***,
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Row(
  ***REMOVED***
                    Expanded(
                      child: RaisedButton(
                        onPressed: onJoin,
    ***REMOVED***'Join'),
                        color: Colors.blueAccent,
                        textColor: Colors.white,
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
  ***REMOVED***

  Future<void> onJoin() async {
    // update input validation
    setState(() {
      _channelController.text.isEmpty
          ? _validateError = true
          : _validateError = false;
    ***REMOVED***);
    if (_channelController.text.isNotEmpty) {
      // await for camera and mic permissions before pushing video page
      await _handleCameraAndMic();
      // push video page with given channel name
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => StreamPage(
            channelName: _channelController.text,
            role: _role,
***REMOVED***
***REMOVED***
  ***REMOVED***
    ***REMOVED***
  ***REMOVED***

***REMOVED***
    await PermissionHandler().requestPermissions(
      [PermissionGroup.camera, PermissionGroup.microphone],
***REMOVED***
  ***REMOVED***
***REMOVED***
