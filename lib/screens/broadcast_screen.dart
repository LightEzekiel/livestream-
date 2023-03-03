import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:live_stream_app/provider/user_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../config/appId.dart';

class BroadCastScreen extends StatefulWidget {
  final bool isBroadcaster;
  final String channelId;
  const BroadCastScreen(
      {super.key, required this.isBroadcaster, required this.channelId});

  @override
  State<BroadCastScreen> createState() => _BroadCastScreenState();
}

class _BroadCastScreenState extends State<BroadCastScreen> {
  late final RtcEngine _engine;
  List<int> remoteUid = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initEngine();
  }

  void _initEngine() async {
    _engine = await RtcEngine.createWithContext(RtcEngineContext(appId));
    _addListeners();
    await _engine.enableVideo();
    await _engine.startPreview();
    await _engine.setChannelProfile(ChannelProfile.LiveBroadcasting);
    if (widget.isBroadcaster) {
      _engine.setClientRole(ClientRole.Broadcaster);
    } else {
      _engine.setClientRole(ClientRole.Audience);
    }
    _joinChannel();
  }

  void _addListeners() {
    _engine.setEventHandler(
      RtcEngineEventHandler(joinChannelSuccess: (channel, uid, elapsed) {
        debugPrint('joinChannelSuccess $channel $uid $elapsed');
      }, userJoined: (uid, elapsed) {
        debugPrint('userJoined $uid $elapsed');
        setState(() {
          remoteUid.add(uid);
        });
      }, userOffline: (uid, reason) {
        debugPrint('userOffline $uid $reason');
        setState(() {
          remoteUid.removeWhere((e) => e == uid);
        });
      }, leaveChannel: (stats) {
        debugPrint('leaveChannel $stats');
        setState(() {
          remoteUid.clear();
        });
      }),
    );
  }

  void _joinChannel() async {
    if (defaultTargetPlatform == TargetPlatform.android) {
      await [Permission.microphone, Permission.camera].request();
    }
    await _engine.joinChannelWithUserAccount(
      tempToken,
      'testing123',
      Provider.of<UserProvider>(context, listen: false).user.uid,
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            _renderVideo(user),
          ],
        ),
      ),
    );
  }
_renderVideo(user){
  return AspectRatio(aspectRatio: 16/9,child:
  '${user.uid}${user.username}' == widget.channelId ? ,);
}

}
