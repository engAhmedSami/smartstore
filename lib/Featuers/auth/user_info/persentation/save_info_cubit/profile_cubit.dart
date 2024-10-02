import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:storeapp/Featuers/auth/user_info/data/user_info_model.dart';
import 'package:storeapp/Featuers/auth/user_info/persentation/save_info_cubit/profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  Future<void> saveUserInfo({
    required String name,
    required String email,
    required String bio,
    required String profilePic,
  }) async {
    try {
      emit(ProfileLoading());

      User? currentUser = FirebaseAuth.instance.currentUser;

      if (currentUser != null) {
        String uid = currentUser.uid;

        UserInfoModel userInfo = UserInfoModel(
          name: name,
          email: email,
          bio: bio,
          profilePic: profilePic,
          createdAt: DateTime.now().toIso8601String(),
          phoneNumber: currentUser.phoneNumber ?? '1234567890',
          uid: uid,
        );

        await FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .set(userInfo.toMap());

        emit(ProfileSuccess());
      } else {
        emit(ProfileError("User is not authenticated"));
      }
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }
}
