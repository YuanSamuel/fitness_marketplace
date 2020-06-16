***REMOVED***
***REMOVED***

class FirebaseProvider {
  static saveVideo(VideoInfo video) async {
    await Firestore.instance.collection('videos').document().setData({
        'videoUrl': video.videoUrl,
        'thumbUrl': video.thumbUrl,
        'coverUrl': video.coverUrl,
        'aspectRatio': video.aspectRatio,
        'uploadedAt': video.uploadedAt,
        'videoName': video.videoName,
      ***REMOVED***);
  ***REMOVED***

  static listenToVideos(callback) async {
    Firestore.instance.collection('videos').snapshots().listen((qs) {
      final videos = mapQueryToVideoInfo(qs);
      callback(videos);
    ***REMOVED***);
  ***REMOVED***

  static mapQueryToVideoInfo(QuerySnapshot qs) {
    return qs.documents.map((DocumentSnapshot ds) {
      return VideoInfo(
        videoUrl: ds.data['videoUrl'],
        thumbUrl: ds.data['thumbUrl'],
        coverUrl: ds.data['coverUrl'],
        aspectRatio: ds.data['aspectRatio'],
        videoName: ds.data['videoName'],
        uploadedAt: ds.data['uploadedAt'],
  ***REMOVED***
    ***REMOVED***).toList();
  ***REMOVED***
***REMOVED***