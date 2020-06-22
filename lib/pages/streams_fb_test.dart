/*
MIT License

Copyright (c) 2019 Qianze Zhang

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
*/


import 'dart:async';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './stream_page.dart';

class StreamsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => StreamsState();
}

class StreamsState extends State<StreamsPage> {
  /// create a channelController to retrieve text value
  final _channelController = TextEditingController();

  /// if channel textField is validated to have error
  bool _validateError = false;

  ClientRole _role = ClientRole.Broadcaster;
  String selected = "";

  final Firestore _firestore = Firestore.instance;


  @override
  void dispose() {
    // dispose input controller
    _channelController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agora Flutter QuickStart'),
      ),
      floatingActionButton: FloatingActionButton(
        child: IconButton(
          onPressed: addStream,
          icon: Icon(Icons.add),
        ),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          height: 400,
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                      child: TextField(
                        controller: _channelController,
                        decoration: InputDecoration(
                          errorText:
                          _validateError ? 'Channel name is mandatory' : null,
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(width: 1),
                          ),
                          hintText: 'Channel name',
                        ),
                      ))
                ],
              ),
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
                        );

                      List<DocumentSnapshot> docs = snapshot.data.documents;

                      List<Widget> messages = new List<Widget>();

                      for (DocumentSnapshot d in docs) {
                        messages.add(
                            FlatButton(
                              onPressed: (){
                                selected= d.data['name'];
                                onJoinStream();
                              },
                              child: Text(d.data['name'])
                            )
                        );
                      }
                      return ListView(
                        children: messages,
                      );
                    },
                  )),
            ],
          ),
        ),
      ),
    );
  }

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
          ),
        ),
      );
    }
    else{
      print("YOU MUST CREATE STREAM");
    }
  }

  Future addStream() async{
    await _firestore.collection('streams').add({
      'trainer':"Test",
      'limit':30,
      'name':_channelController.text,
      'date':DateTime.now().millisecondsSinceEpoch
    });
    _channelController.clear();
  }

  Future<void> _handleCameraAndMic() async {
    await Permission.camera.request();
    await Permission.microphone.request();
  }
}
