class LiveStream {
  final String title, image, uid, username, channelid;
  final startAt;
  final int viewers;

  LiveStream({
    required this.title,
    required this.image,
    required this.uid,
    required this.username,
    required this.channelid,
    required this.startAt,
    required this.viewers,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'image': image,
      'uid': uid,
      'username': username,
      'channelid': channelid,
      'startAt': startAt,
      'viewers': viewers,
    };
  }

  factory LiveStream.fromMap(Map<String, dynamic> map) {
    return LiveStream(
      title: map['title'] ?? '',
      image: map['image'] ?? '',
      uid: map['uid'] ?? '',
      username: map['username'] ?? '',
      channelid: map['channelid'] ?? '',
      startAt: map['startAt'] ?? '',
      viewers: map['viewers'] ?? 0,
    );
  }
}
