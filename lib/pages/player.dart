***REMOVED***
import 'package:video_player/video_player.dart';
import '../models/video_info.dart';

class Player extends StatefulWidget {
  final VideoInfo video;

  const Player({Key key, @required this.video***REMOVED***) : super(key: key);

***REMOVED***
  State<StatefulWidget> createState() => _PlayerState();
***REMOVED***

class _PlayerState extends State<Player> {
  String _error;


***REMOVED***
***REMOVED***
***REMOVED***
      backgroundColor: Colors.black,
      body: Stack(
        children: <Widget>[
          _error == null
              ? NetworkPlayerLifeCycle(
                  widget.video.videoUrl,
                  (BuildContext context, VideoPlayerController controller) =>
                      AspectRatioVideo(controller),
  ***REMOVED***
              : Center(
                  child: Text(_error),
  ***REMOVED***,
          Container(
            padding: EdgeInsets.all(16.0),
            child: IconButton(
              icon: Icon(Icons.close, color: Colors.white),
              onPressed: () => Navigator.pop(context),
***REMOVED***
***REMOVED***
        ],
***REMOVED***
***REMOVED***
  ***REMOVED***
***REMOVED***

class VideoPlayPause extends StatefulWidget {
  VideoPlayPause(this.controller);

  final VideoPlayerController controller;

***REMOVED***
  State createState() {
    return _VideoPlayPauseState();
  ***REMOVED***
***REMOVED***

class _VideoPlayPauseState extends State<VideoPlayPause> {
  _VideoPlayPauseState() {
    listener = () {
      if (mounted) {
  ***REMOVED******REMOVED***);
      ***REMOVED***
    ***REMOVED***;
  ***REMOVED***

  FadeAnimation imageFadeAnim =
      FadeAnimation(child: const Icon(Icons.play_arrow, size: 100.0));
  VoidCallback listener;

  VideoPlayerController get controller => widget.controller;

***REMOVED***
***REMOVED***
***REMOVED***
    controller.addListener(listener);
    controller.setVolume(1.0);
    controller.play();
  ***REMOVED***

***REMOVED***
  void deactivate() {
    controller.setVolume(0.0);
    controller.removeListener(listener);
    super.deactivate();
  ***REMOVED***

***REMOVED***
***REMOVED***
    final List<Widget> children = <Widget>[
      GestureDetector(
        child: VideoPlayer(controller),
        onTap: () {
          if (!controller.value.initialized) {
            return;
          ***REMOVED***
          if (controller.value.isPlaying) {
            imageFadeAnim =
                FadeAnimation(child: const Icon(Icons.pause, size: 100.0));
            controller.pause();
          ***REMOVED*** else {
            imageFadeAnim =
                FadeAnimation(child: const Icon(Icons.play_arrow, size: 100.0));
            controller.play();
          ***REMOVED***
        ***REMOVED***,
***REMOVED***
      Align(
        alignment: Alignment.bottomCenter,
        child: VideoProgressIndicator(
          controller,
          allowScrubbing: true,
***REMOVED***
***REMOVED***
      Center(child: imageFadeAnim),
      Center(
          child: controller.value.isBuffering
              ? const CircularProgressIndicator()
              : null),
    ];

    return Stack(
      fit: StackFit.passthrough,
      children: children,
***REMOVED***
  ***REMOVED***
***REMOVED***

class FadeAnimation extends StatefulWidget {
  FadeAnimation(
      {this.child, this.duration = const Duration(milliseconds: 500)***REMOVED***);

  final Widget child;
  final Duration duration;

***REMOVED***
  _FadeAnimationState createState() => _FadeAnimationState();
***REMOVED***

class _FadeAnimationState extends State<FadeAnimation>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;

***REMOVED***
***REMOVED***
***REMOVED***
    animationController =
        AnimationController(duration: widget.duration, vsync: this);
    animationController.addListener(() {
      if (mounted) {
  ***REMOVED******REMOVED***);
      ***REMOVED***
    ***REMOVED***);
    animationController.forward(from: 0.0);
  ***REMOVED***

***REMOVED***
  void deactivate() {
    animationController.stop();
    super.deactivate();
  ***REMOVED***

***REMOVED***
  void didUpdateWidget(FadeAnimation oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.child != widget.child) {
      animationController.forward(from: 0.0);
    ***REMOVED***
  ***REMOVED***

***REMOVED***
  void dispose() {
    if (animationController != null) animationController.dispose();
    super.dispose();
  ***REMOVED***

***REMOVED***
***REMOVED***
    return animationController.isAnimating
        ? Opacity(
            opacity: 1.0 - animationController.value,
            child: widget.child,
          )
        : Container();
  ***REMOVED***
***REMOVED***

typedef Widget VideoWidgetBuilder(
    BuildContext context, VideoPlayerController controller);

abstract class PlayerLifeCycle extends StatefulWidget {
  PlayerLifeCycle(this.dataSource, this.childBuilder);

  final VideoWidgetBuilder childBuilder;
  final String dataSource;
***REMOVED***

/// A widget connecting its life cycle to a [VideoPlayerController] using
/// a data source from the network.
class NetworkPlayerLifeCycle extends PlayerLifeCycle {
  NetworkPlayerLifeCycle(String dataSource, VideoWidgetBuilder childBuilder)
      : super(dataSource, childBuilder);

***REMOVED***
  _NetworkPlayerLifeCycleState createState() => _NetworkPlayerLifeCycleState();
***REMOVED***

abstract class _PlayerLifeCycleState extends State<PlayerLifeCycle> {
  VideoPlayerController controller;

***REMOVED***

  /// Subclasses should implement [createVideoPlayerController], which is used
  /// by this method.
***REMOVED***
***REMOVED***
    controller = createVideoPlayerController();
    controller.addListener(() {
      if (controller.value.hasError) {
  ***REMOVED******REMOVED***);
      ***REMOVED***
    ***REMOVED***);
    controller.initialize();
    controller.setLooping(false);
    controller.play();
  ***REMOVED***

***REMOVED***
  void deactivate() {
    super.deactivate();
  ***REMOVED***

***REMOVED***
  void dispose() {
    if (controller != null) controller.dispose();
    super.dispose();
  ***REMOVED***

***REMOVED***
***REMOVED***
    return widget.childBuilder(context, controller);
  ***REMOVED***

  VideoPlayerController createVideoPlayerController();
***REMOVED***

class _NetworkPlayerLifeCycleState extends _PlayerLifeCycleState {
***REMOVED***
  VideoPlayerController createVideoPlayerController() {
    return VideoPlayerController.network(widget.dataSource);
  ***REMOVED***
***REMOVED***

class AspectRatioVideo extends StatefulWidget {
  AspectRatioVideo(this.controller);

  final VideoPlayerController controller;

***REMOVED***
  AspectRatioVideoState createState() => AspectRatioVideoState();
***REMOVED***

class AspectRatioVideoState extends State<AspectRatioVideo> {
  VideoPlayerController get controller => widget.controller;
  bool initialized = false;

  VoidCallback listener;

***REMOVED***
***REMOVED***
***REMOVED***
    listener = () {
      if (!mounted) {
        return;
      ***REMOVED***
      if (initialized != controller.value.initialized) {
        initialized = controller.value.initialized;
        if (mounted) {
    ***REMOVED******REMOVED***);
        ***REMOVED***
      ***REMOVED***
    ***REMOVED***;
    controller.addListener(listener);
  ***REMOVED***

***REMOVED***
***REMOVED***
    if (controller.value.hasError) {
      return Center(
***REMOVED***
          padding: const EdgeInsets.all(20),
          child: Text(controller.value.errorDescription,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold)),
***REMOVED***
  ***REMOVED***
    ***REMOVED***

    if (initialized) {
      return Center(
        child: AspectRatio(
          aspectRatio: controller.value.aspectRatio,
          child: VideoPlayPause(controller),
***REMOVED***
  ***REMOVED***
    ***REMOVED*** else {
      return Center(child: CircularProgressIndicator());
    ***REMOVED***
  ***REMOVED***
***REMOVED***
