import 'dart:async';
import 'dart:ui';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
***REMOVED***
import 'package:fitnessmarketplace/widgets/curretnexericse_widget.dart';
***REMOVED***

import '../utils/settings.dart';

class StreamPage extends StatefulWidget {
  /// non-modifiable channel name of the page
  final String channelName;

  /// non-modifiable client role of the page
  final ClientRole role;

  final bool isTrainer;

  /// Creates a call page with given channel name.
  const StreamPage({Key key, this.channelName, this.role, this.isTrainer***REMOVED***) : super(key: key);

***REMOVED***
  _StreamPageState createState() => _StreamPageState();
***REMOVED***

class _StreamPageState extends State<StreamPage> {
  static final _users = <int>[];
  final _infoStrings = <String>[];
  bool muted = false;


  List<DocumentSnapshot> actions = [];

  bool addAction = false;
***REMOVED***
  void dispose() {
    // clear users
    _users.clear();
    // destroy sdk
    AgoraRtcEngine.leaveChannel();
    AgoraRtcEngine.destroy();
    super.dispose();
  ***REMOVED***

***REMOVED***
***REMOVED***

***REMOVED***

    scrollController = new ScrollController();
    addTextController = new TextEditingController();


    // initialize agora sdk
    initialize();




  ***REMOVED***

  Future<void> initialize() async {
    if (APP_ID.isEmpty) {
***REMOVED***
        _infoStrings.add(
          'APP_ID missing, please provide your APP_ID in settings.dart',
    ***REMOVED***
        _infoStrings.add('Agora Engine is not starting');
      ***REMOVED***);
      return;
    ***REMOVED***

    await _initAgoraRtcEngine();
    _addAgoraEventHandlers();
    await AgoraRtcEngine.enableWebSdkInteroperability(true);
    VideoEncoderConfiguration configuration = VideoEncoderConfiguration();
    configuration.dimensions = Size(1920, 1080);
    await AgoraRtcEngine.setVideoEncoderConfiguration(configuration);
    await AgoraRtcEngine.joinChannel(null, widget.channelName, null, 0);

    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 300),
***REMOVED***
  ***REMOVED***

  /// Create agora sdk instance and initialize
  Future<void> _initAgoraRtcEngine() async {
    await AgoraRtcEngine.create(APP_ID);
    await AgoraRtcEngine.enableVideo();
    print("VIDEO ENABLED");
    await AgoraRtcEngine.setChannelProfile(ChannelProfile.LiveBroadcasting);
    await AgoraRtcEngine.setClientRole(widget.role);
  ***REMOVED***

  /// Add agora event handlers
  void _addAgoraEventHandlers() {
    AgoraRtcEngine.onError = (dynamic code) {
***REMOVED***
        final info = 'onError: $code';
        _infoStrings.add(info);
      ***REMOVED***);
    ***REMOVED***;

    AgoraRtcEngine.onJoinChannelSuccess = (
      String channel,
      int uid,
      int elapsed,
    ) {
***REMOVED***
        final info = 'onJoinChannel: $channel, uid: $uid';
        _infoStrings.add(info);
      ***REMOVED***);
    ***REMOVED***;

    AgoraRtcEngine.onLeaveChannel = () {
***REMOVED***
        _infoStrings.add('onLeaveChannel');
        _users.clear();
      ***REMOVED***);
    ***REMOVED***;

    AgoraRtcEngine.onUserJoined = (int uid, int elapsed) {
***REMOVED***
        final info = 'userJoined: $uid';
        _infoStrings.add(info);
        _users.add(uid);
      ***REMOVED***);
    ***REMOVED***;

    AgoraRtcEngine.onUserOffline = (int uid, int reason) {
***REMOVED***
        final info = 'userOffline: $uid';
        _infoStrings.add(info);
        _users.remove(uid);
      ***REMOVED***);
    ***REMOVED***;

    AgoraRtcEngine.onFirstRemoteVideoFrame = (
      int uid,
      int width,
      int height,
      int elapsed,
    ) {
***REMOVED***
        final info = 'firstRemoteVideo: $uid ${width***REMOVED***x $height';
        _infoStrings.add(info);
      ***REMOVED***);
    ***REMOVED***;
  ***REMOVED***

  /// Helper function to get list of native views
  List<Widget> _getRenderViews() {
    final List<AgoraRenderWidget> list = [];
    if (widget.role == ClientRole.Broadcaster) {
      list.add(AgoraRenderWidget(0, local: true, preview: true));
    ***REMOVED***
    _users.forEach((int uid) => list.add(AgoraRenderWidget(uid)));
    return list;
  ***REMOVED***

  /// Video view wrapper
  Widget _videoView(view) {
    return Expanded(child: Container(child: view));
  ***REMOVED***

  /// Video view row wrapper
  Widget _expandedVideoRow(List<Widget> views) {
    final wrappedViews = views.map<Widget>(_videoView).toList();
    return Expanded(
      child: Row(
        children: wrappedViews,
***REMOVED***
***REMOVED***
  ***REMOVED***

  /// Video layout wrapper
  Widget _viewRows() {
    final views = _getRenderViews();
    switch (views.length) {
      case 1:
        return Container(
  ***REMOVED***
          children: <Widget>[_videoView(views[0])],
        ));
      case 2:
        return Container(
  ***REMOVED***
          children: <Widget>[
            _expandedVideoRow([views[0]]),
            _expandedVideoRow([views[1]])
          ],
        ));
      case 3:
        return Container(
  ***REMOVED***
          children: <Widget>[
            _expandedVideoRow(views.sublist(0, 2)),
            _expandedVideoRow(views.sublist(2, 3))
          ],
        ));
      case 4:
        return Container(
  ***REMOVED***
          children: <Widget>[
            _expandedVideoRow(views.sublist(0, 2)),
            _expandedVideoRow(views.sublist(2, 4))
          ],
        ));
      default:
    ***REMOVED***
    return Container();
  ***REMOVED***


  ScrollController scrollController = new ScrollController();

  TextEditingController addTextController = new TextEditingController();

  int reps = 1;
  int mins = 1;

  /// Toolbar layout
  Widget _addview() {
    if (widget.role == ClientRole.Audience) return Container();
    return Container(
      width: 350.0,
      height: 200.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          color: Colors.black54
***REMOVED***
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: TextField(
                controller: addTextController,
***REMOVED***color: Colors.white),
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  hintText: 'Enter Exercise Name',
                  enabledBorder: UnderlineInputBorder(
***REMOVED*** BorderSide(
                        color: Colors.white
      ***REMOVED***,
    ***REMOVED***,
                  focusColor: Colors.white,
  ***REMOVED***,
***REMOVED***,
***REMOVED***
            Text('Reps', style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w400, color: Colors.white),),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
  ***REMOVED***
                IconButton(
                  icon: Icon(Icons.chevron_left, color: Colors.white,),
                  onPressed: (){
              ***REMOVED***
                      reps-=1;
                    ***REMOVED***);
                  ***REMOVED***,
  ***REMOVED***,
                Text(reps.toString(), style: TextStyle(color: Colors.white),),
                IconButton(
                  icon: Icon(Icons.chevron_right, color: Colors.white,),
                  onPressed: (){
              ***REMOVED***
                      reps+=1;
                    ***REMOVED***);
                  ***REMOVED***,
  ***REMOVED***,
  ***REMOVED***
***REMOVED***
            Text('Minutes', style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w400, color: Colors.white),),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
  ***REMOVED***
                IconButton(
                  icon: Icon(Icons.chevron_left, color: Colors.white,),
                  onPressed: (){
              ***REMOVED***
                      mins-=1;
                    ***REMOVED***);
                  ***REMOVED***,
  ***REMOVED***,
                Text(mins.toString(), style: TextStyle(color: Colors.white),),
                IconButton(
                  icon: Icon(Icons.chevron_right, color: Colors.white,),
                  onPressed: (){
              ***REMOVED***
                      mins+=1;
                    ***REMOVED***);
                  ***REMOVED***,
  ***REMOVED***,
  ***REMOVED***
***REMOVED***
          ],
***REMOVED***
***REMOVED***
***REMOVED***
  ***REMOVED***


  /// Toolbar layout
  Widget _topview() {
    return SingleChildScrollView(
      controller: scrollController,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          height: 100,
          alignment: Alignment.center,
          child: Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: Firestore.instance
                    .collection("streamactions")
                    .document(widget.channelName)
                    .collection("actions")
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
                        messages.add(CurrentExerciseWidget(name: d.data['exercise'],mins: d.data["mins"],reps: d.data["reps"],));
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

  /// Toolbar layout
  Widget _toolbar() {
    if (widget.role == ClientRole.Audience) return Container();
    return Container(
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.symmetric(vertical: 48),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RawMaterialButton(
            onPressed: _onToggleMute,
            child: Icon(
              muted ? Icons.mic_off : Icons.mic,
              color: muted ? Colors.white : Colors.blueAccent,
              size: 20.0,
***REMOVED***
            shape: CircleBorder(),
            elevation: 2.0,
            fillColor: muted ? Colors.blueAccent : Colors.white,
            padding: const EdgeInsets.all(12.0),
***REMOVED***
          RawMaterialButton(
            onPressed: () => _onCallEnd(context),
            child: Icon(
              Icons.call_end,
              color: Colors.white,
              size: 35.0,
***REMOVED***
            shape: CircleBorder(),
            elevation: 2.0,
            fillColor: Colors.redAccent,
            padding: const EdgeInsets.all(15.0),
***REMOVED***
          RawMaterialButton(
            onPressed: _onSwitchCamera,
            child: Icon(
              Icons.switch_camera,
              color: Colors.blueAccent,
              size: 20.0,
***REMOVED***
            shape: CircleBorder(),
            elevation: 2.0,
            fillColor: Colors.white,
            padding: const EdgeInsets.all(12.0),
***REMOVED***
          widget.isTrainer?RawMaterialButton(
            onPressed: (){
        ***REMOVED***
                if (addAction)
                  addActiontoFB();
                else
                  addAction=!addAction;
              ***REMOVED***);
            ***REMOVED***,
            child: Icon(
              Icons.add,
              color: Colors.blueAccent,
              size: 20.0,
***REMOVED***
            shape: CircleBorder(),
            elevation: 2.0,
            fillColor: Colors.white,
            padding: const EdgeInsets.all(12.0),
          ):Container(height: 0,width: 0,)
        ],
***REMOVED***
***REMOVED***
  ***REMOVED***


  Future addActiontoFB() async{
    await Firestore.instance.collection("streamactions")
        .document(widget.channelName)
        .collection("actions").document().setData({
      'exercise':addTextController.text.toString(),
      'date':DateTime.now().millisecondsSinceEpoch,
      'mins':mins,
      'reps':reps
    ***REMOVED***);

    addTextController.clear();



    setState(() {
      mins =1;
      reps = 1;
      addAction=!addAction;

    ***REMOVED***);

    setState(() {

    ***REMOVED***);

    scrollController.animateTo(
      scrollController.position.minScrollExtent,
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 300),
***REMOVED***





  ***REMOVED***

  /// Info panel to show logs
  Widget _panel() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 48),
      alignment: Alignment.bottomCenter,
      child: FractionallySizedBox(
        heightFactor: 0.5,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 48),
          child: ListView.builder(
            reverse: true,
            itemCount: _infoStrings.length,
            itemBuilder: (BuildContext context, int index) {
              if (_infoStrings.isEmpty) {
                return null;
              ***REMOVED***
              return Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 3,
                  horizontal: 10,
  ***REMOVED***,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
      ***REMOVED***
                    Flexible(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 2,
                          horizontal: 5,
          ***REMOVED***,
            ***REMOVED***
                          color: Colors.yellowAccent,
                          borderRadius: BorderRadius.circular(5),
          ***REMOVED***,
    ***REMOVED***
                          _infoStrings[index],
      ***REMOVED***color: Colors.blueGrey),
          ***REMOVED***,
        ***REMOVED***,
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

  void _onCallEnd(BuildContext context) {
    Navigator.pop(context);
  ***REMOVED***

  void _onToggleMute() {
    setState(() {
      muted = !muted;
    ***REMOVED***);
    AgoraRtcEngine.muteLocalAudioStream(muted);
  ***REMOVED***

  void _onSwitchCamera() {
    AgoraRtcEngine.switchCamera();
  ***REMOVED***

***REMOVED***
***REMOVED***
***REMOVED***
      appBar: AppBar(
        title: Text('Agora Flutter QuickStart'),
***REMOVED***
      backgroundColor: Colors.black,
      body: Center(
        child: Stack(
          children: <Widget>[
            _viewRows(),
            _panel(),
            addAction?_addview():_topview(),
            _toolbar(),
          ],
***REMOVED***
***REMOVED***
***REMOVED***
  ***REMOVED***
***REMOVED***
