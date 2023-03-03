import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/livestream.dart';
import '../provider/user_provider.dart';
import '../resources/storage_method.dart';
import '../utils/utils.dart';
import 'package:provider/provider.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final StorageMethods _storageMethods = StorageMethods();

  startLiveStream(BuildContext context, String title, Uint8List? image) async {
    final user = Provider.of<UserProvider>(context, listen: false);
    String channelId = '';
    try {
      if (title.isNotEmpty && image != null) {
        if (!((await _firestore
                .collection('livestream')
                .doc('${user.user.uid}${user.user.username}')
                .get())
            .exists)) {
          String thumbnailUrl = await _storageMethods.uploadImageToStorage(
            'Livestream-thumbnails',
            image,
            user.user.uid,
          );
          channelId = '${user.user.uid}${user.user.username}';
          LiveStream liveStream = LiveStream(
              title: title,
              image: thumbnailUrl,
              uid: user.user.uid,
              username: user.user.username,
              channelid: channelId,
              startAt: DateTime.now(),
              viewers: 0);

          _firestore
              .collection('livestream')
              .doc(channelId)
              .set(liveStream.toMap());
        } else {
          showSnackBar(context, 'Two livestreams cannot start at same time!');
        }
      } else {
        showSnackBar(context, 'Please fill all fields');
      }
    } on FirebaseException catch (e) {
      showSnackBar(context, e.message!);
    }
    return channelId;
  }
}
