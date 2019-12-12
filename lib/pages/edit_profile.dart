import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import 'package:fluttershare/models/user.dart';
import 'package:fluttershare/pages/home.dart';
import 'package:fluttershare/widgets/progress.dart';

class EditProfile extends StatefulWidget {
  final String currentUserId;
  EditProfile({this.currentUserId});

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController displayNameController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  bool isLoading = false;
  User user;
  bool _bioValid = true;
  bool _displaynameValid = true;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    getUser();
  }

  getUser() async {
    setState(() {
      isLoading = true;
    });
    DocumentSnapshot doc = await usersRef.document(widget.currentUserId).get();
    user = User.fromDocument(doc);
    displayNameController.text = user.displayName;
    bioController.text = user.bio;
    setState(() {
      isLoading = false;
    });
  }

  Column buildDisplaynameField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
            padding: EdgeInsets.only(top: 12.0),
            child: Text(
              'Display name',
              style: TextStyle(color: Colors.grey),
            )),
        TextField(
          controller: displayNameController,
          decoration: InputDecoration(
            hintText: 'Update displayname',
            errorText: _displaynameValid ? null : 'Displayname too short',
          ),
        ),
      ],
    );
  }

  Column buildBioField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
            padding: EdgeInsets.only(top: 12.0),
            child: Text(
              'Bio',
              style: TextStyle(color: Colors.grey),
            )),
        TextField(
          controller: bioController,
          minLines: 3,
          maxLines: 5,
          decoration: InputDecoration(
            hintText: 'Write something interesting about you.',
            errorText: _bioValid ? null : '200 characters maximum allowed',
          ),
        ),
      ],
    );
  }

  logout() async {
    await googleSignIn.signOut();
    Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
  }

  updateProfileData() {
    setState(() {
      displayNameController.text.trim().length < 4 ||
              displayNameController.text.isEmpty
          ? _displaynameValid = false
          : _displaynameValid = true;
      bioController.text.trim().length > 200
          ? _bioValid = false
          : _bioValid = true;
    });

    if (_displaynameValid && _bioValid) {
      usersRef.document(widget.currentUserId).updateData({
        'displayName': displayNameController.text,
        'bio': bioController.text
      });

      //TIP: Quick snackbar code
      SnackBar snackbar = SnackBar(content: Text('Profile updated'));
      _scaffoldKey.currentState.showSnackBar(snackbar);
    }
  }

  @override
  Scaffold build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      floatingActionButton: FloatingActionButton(
        onPressed: logout,
        child: Icon(Icons.exit_to_app),
      ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Edit profile',
          style: TextStyle(color: Colors.black),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.done),
            iconSize: 30.0,
            color: Colors.green,
          ),
        ],
      ),
      body: isLoading
          ? circularProgress()
          : ListView(
              children: <Widget>[
                Container(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 16.0, bottom: 8.0),
                        child: CircleAvatar(
                          backgroundImage:
                              CachedNetworkImageProvider(user.photoUrl),
                          radius: 50.0,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          children: <Widget>[
                            buildDisplaynameField(),
                            buildBioField(),
                          ],
                        ),
                      ),
                      RaisedButton(
                        onPressed: updateProfileData,
                        child: Text(
                          'Update profile',
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
    );
  }
}
