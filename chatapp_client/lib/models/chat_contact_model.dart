import 'package:flutter/cupertino.dart';

class ChatContactModel {
  String id;
  String name;
  String recentMessage;
  int notificationCount;
  String recentMessageTime;
  String publicKey;
  bool seen;
  String email;
  String profilePic;
  String profile_pic;

  ChatContactModel(
      {this.id,
      this.name,
      this.recentMessage,
      this.notificationCount,
      this.recentMessageTime,
      this.publicKey,
      this.seen,
      this.email,
      this.profilePic,
      this.profile_pic});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'recentMessage': recentMessage,
      'notificationCount': notificationCount,
      'recentMessageTime': recentMessageTime,
      'publicKey': publicKey,
      'seen': seen,
      'email': email,
      'profilePic': profilePic,
      'profile_pic': profile_pic
    };
  }
}
