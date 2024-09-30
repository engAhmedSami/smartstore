import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:storeapp/Core/Services/data_service.dart';
import 'package:storeapp/Core/Services/firebase_auth_service.dart';
import 'package:storeapp/Core/Services/shared_preferences_sengleton.dart';
import 'package:storeapp/Featuers/auth/data/models/user_model.dart';
import 'package:storeapp/Featuers/auth/domain/entites/user_entity.dart';
import 'package:storeapp/Featuers/auth/domain/repos/auth_repo.dart';

import 'package:storeapp/Core/Utils/backend_endpoint.dart';
import 'package:storeapp/Core/errors/exceptions.dart';
import 'package:storeapp/Core/errors/failures.dart';
import 'package:storeapp/constans.dart';

class AuthRepoImpl extends AuthRepo {
  final FirebaseAuthService firebaseAuthService;
  final DatabaseService databaseService;

  AuthRepoImpl({
    required this.firebaseAuthService,
    required this.databaseService,
  });
  @override
  Future<Either<Failures, UserEntity>> createUserWithEmailAndPassword(
    String email,
    String password,
    String name,
  ) async {
    User? user;
    try {
      user = await firebaseAuthService.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      var userEntity = UserEntity(
        name: name,
        email: email,
        uId: user.uid,
      );
      await addUserData(user: userEntity);
      return right(
        userEntity,
      );
    } on CustomExceptions catch (e) {
      await deleteUser(user);
      return left(ServerFailure(e.message));
    } catch (e) {
      await deleteUser(user);
      log(
        'Exception in AuthRepoImpl.createUserWithEmailAndPassword :${e.toString()}',
      );
      return left(
        ServerFailure('Something went wrong. Please try again'),
      );
    }
  }

  Future<void> deleteUser(User? user) async {
    if (user != null) {
      await firebaseAuthService.deleteUser();
    }
  }

  @override
  Future<Either<Failures, UserEntity>> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      var user = await firebaseAuthService.signInWithEmailAndPassword(
          email: email, password: password);
      var userEntity = await getUserData(uid: user.uid);
      await saveUserData(user: userEntity);

      return right(
        userEntity,
      );
    } on CustomExceptions catch (e) {
      return left(ServerFailure(e.message));
    } catch (e) {
      log(
        'Exception in AuthRepoImpl.signInWithEmailAndPassword :${e.toString()}',
      );
      return left(
        ServerFailure('Something went wrong. Please try again'),
      );
    }
  }

  @override
  Future<Either<Failures, UserEntity>> signInWithGoogle() async {
    User? user;
    try {
      user = await firebaseAuthService.signInWithGoogle();

      var userEntity = UserModel.fromFirebaseUser(user);
      var isUserExist = await databaseService.checkIfDatatExists(
        path: BackendEndpoint.isUserExists,
        docuementId: user.uid,
      );
      if (isUserExist) {
        await getUserData(uid: user.uid);
        await saveUserData(user: userEntity);
      } else {
        await addUserData(user: userEntity);
      }
      return right(
        userEntity,
      );
    } catch (e) {
      await deleteUser(user);
      log(
        'Exception in AuthRepoImpl.signInWithGoogle :${e.toString()}',
      );
      return left(
        ServerFailure(
          'Something went wrong. Please try again',
        ),
      );
    }
  }

  @override
  @override
  Future addUserData({required UserEntity user}) {
    return databaseService.addData(
        path: BackendEndpoint.addUserData,
        data: user.toMap(),
        docuementId: user.uId);
  }

  @override
  Future<UserEntity> getUserData({required String uid}) async {
    var userData = await databaseService.getData(
        path: BackendEndpoint.getUserData, docuementId: uid);

    return UserModel.fromJson(userData);
  }

  Future<void> saveUserData({required UserEntity user}) async {
    var jsonData = jsonEncode(UserModel.fromEntity(user).toMap());
    await Prefs.setString(kUserData, jsonData);
  }
}
