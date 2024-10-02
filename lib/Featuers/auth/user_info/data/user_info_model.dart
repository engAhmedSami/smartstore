// class UserInfoModel {
//   final String name;
//   final String email;
//   final String bio;
//   final String profilePic;
//   final String createdAt;
//   final String phoneNumber;
//   final String uid;

//   UserInfoModel(
//       {required this.name,
//       required this.email,
//       required this.bio,
//       required this.profilePic,
//       required this.createdAt,
//       required this.phoneNumber,
//       required this.uid});

//   factory UserInfoModel.frommap(Map<String, dynamic> map) {
//     return UserInfoModel(
//       name: map['name'] ?? '',
//       email: map['email'] ?? '',
//       bio: map['bio'] ?? '',
//       profilePic: map['profilePic'] ?? '',
//       createdAt: map['createdAt'] ?? '',
//       phoneNumber: map['phoneNumber'] ?? '',
//       uid: map['uid'] ?? '',
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'name': name,
//       'email': email,
//       'bio': bio,
//       'profilePic': profilePic,
//       'createdAt': createdAt,
//       'phoneNumber': phoneNumber,
//       'uid': uid,
//     };
//   }
// }
class UserInfoModel {
  final String? name;
  final String? email;
  final String? bio;
  final String? profilePic;
  final String? createdAt;
  final String? phoneNumber;
  final String? uid;

  UserInfoModel({
    this.name,
    this.email,
    this.bio,
    this.profilePic,
    this.createdAt,
    this.phoneNumber,
    this.uid,
  });

  factory UserInfoModel.fromMap(Map<String, dynamic> map) {
    return UserInfoModel(
      name: map['name'],
      email: map['email'],
      bio: map['bio'],
      profilePic: map['profilePic'],
      createdAt: map['createdAt'],
      phoneNumber: map['phoneNumber'],
      uid: map['uid'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'bio': bio,
      'profilePic': profilePic,
      'createdAt': createdAt,
      'phoneNumber': phoneNumber,
      'uid': uid,
    };
  }
}
