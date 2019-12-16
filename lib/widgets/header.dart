import 'package:flutter/material.dart';

AppBar header(BuildContext context,
    {bool isAppTitle = false, String titleText, removeBackButton = false}) {
  return AppBar(
    automaticallyImplyLeading: removeBackButton ? false : true,
    title: Text(
      isAppTitle ? 'SocialShare' : titleText,
      style: TextStyle(
        color: Colors.white,
        fontFamily: isAppTitle ? 'Signatra' : '',
        fontSize: isAppTitle ? 45.0 : 25.0,
      ),
      overflow: TextOverflow.ellipsis,
    ),
    centerTitle: true,
    backgroundColor: Theme.of(context).accentColor,
  );
}
