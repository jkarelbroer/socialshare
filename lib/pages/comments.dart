import 'package:flutter/material.dart';

class Comments extends StatefulWidget {
  final String postId;
  final String postOwnerId;
  final String postMediaUrl;

  Comments({this.postId, this.postOwnerId, this.postMediaUrl});

  @override
  CommentsState createState() => CommentsState();
}

class CommentsState extends State<Comments> {
  @override
  Widget build(BuildContext context) {
    return Text('Comments');
  }
}

class Comment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text('Comment');
  }
}
