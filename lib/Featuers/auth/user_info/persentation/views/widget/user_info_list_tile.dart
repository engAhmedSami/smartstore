import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:storeapp/Featuers/auth/user_info/data/user_info_model.dart';
import 'package:storeapp/Featuers/auth/user_info/persentation/views/widget/edit_profile_body.dart';

class UserInfoListTile extends StatefulWidget {
  final String uid;

  const UserInfoListTile({super.key, required this.uid});

  @override
  UserInfoListTileState createState() => UserInfoListTileState();
}

class UserInfoListTileState extends State<UserInfoListTile> {
  late Future<UserInfoModel> _userInfoFuture;

  @override
  void initState() {
    super.initState();
    _userInfoFuture = fetchUserInfo();
  }

  Future<UserInfoModel> fetchUserInfo() async {
    final docSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.uid)
        .get();

    if (docSnapshot.exists) {
      return UserInfoModel.fromMap(docSnapshot.data()!);
    } else {
      throw Exception("User data not found");
    }
  }

  void _updateUserInfo() {
    setState(() {
      _userInfoFuture =
          fetchUserInfo(); // Reload user info when data is updated
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserInfoModel>(
      future: _userInfoFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const ListTile(
            title: Text("Error loading user data"),
          );
        } else if (!snapshot.hasData) {
          return const ListTile(
            title: Text("User data not found"),
          );
        } else {
          final userInfoModel = snapshot.data!;
          String profilePicUrl = userInfoModel.profilePic ?? '';

          if (profilePicUrl.isEmpty) {
            profilePicUrl =
                'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png';
          }

          return ListTile(
            leading: CircleAvatar(
              backgroundImage: profilePicUrl.startsWith('/')
                  ? FileImage(File(profilePicUrl))
                  : NetworkImage(profilePicUrl) as ImageProvider,
              radius: 30,
            ),
            title: Text(userInfoModel.name ?? ''),
            subtitle: Text(userInfoModel.email ?? ''),
            onTap: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditUserInfoView(
                    uid: widget.uid,
                    userInfo: userInfoModel,
                    onUserInfoUpdated: _updateUserInfo,
                  ),
                ),
              );

              if (result == true) {
                _updateUserInfo();
              }
            },
          );
        }
      },
    );
  }
}
