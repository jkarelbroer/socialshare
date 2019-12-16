import 'package:cloud_firestore/cloud_firestore.dart';

class ActivityFeedItemObject {
  final String username;
  final String userId;
  final String type; //like, follow, comment
  final String mediaUrl;
  final String postId;
  final String userProfileImg;
  final String commentData;
  final Timestamp timestamp;

  ActivityFeedItemObject({
    this.username,
    this.userId,
    this.type,
    this.mediaUrl,
    this.postId,
    this.userProfileImg,
    this.commentData,
    this.timestamp,
  });

  factory ActivityFeedItemObject.fromDocument(DocumentSnapshot doc) {
    return ActivityFeedItemObject(
      username: doc['username'],
      userId: doc['userId'],
      type: doc['type'],
      mediaUrl: doc['mediaUrl'],
      postId: doc['postId'],
      userProfileImg: doc['userProfileImg'],
      commentData: doc['commentData'],
      timestamp: doc['timestamp'],
    );
  }
}
