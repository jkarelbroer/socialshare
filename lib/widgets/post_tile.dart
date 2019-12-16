import 'package:flutter/material.dart';
import 'package:fluttershare/widgets/custom_image.dart';
import 'package:fluttershare/widgets/post.dart';

import 'package:fluttershare/functions/navigation.dart';

class PostTile extends StatelessWidget {
  final Post post;

  PostTile(this.post);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          showPost(context, postId: post.postId, ownerId: post.ownerId),
      child: customCachedNetworkImage(post.mediaUrl),
    );
  }
}
