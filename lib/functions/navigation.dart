import 'package:flutter/material.dart';
import 'package:fluttershare/pages/profile.dart';
import 'package:fluttershare/pages/post_screen.dart';

void showProfile(BuildContext context, {String profileId}) {
  Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => Profile(
                profileId: profileId,
              )));
}

void showPost(context, {String postId, String ownerId}) {
  Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => PostScreen(
                postId: postId,
                userId: ownerId,
              )));
}
