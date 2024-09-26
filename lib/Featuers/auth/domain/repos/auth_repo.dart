import 'package:dartz/dartz.dart';
import 'package:storeapp/Core/errors/failures.dart';
import 'package:storeapp/Featuers/auth/domain/entites/user_entity.dart';

abstract class AuthRepo {
  Future<Either<Failures, UserEntity>> createUserWithEmailAndPassword(
      String email, String password, String name);

  Future<Either<Failures, UserEntity>> signInWithEmailAndPassword(
      String email, String password);

  Future<Either<Failures, UserEntity>> signInWithGoogle();

  Future addUserData({required UserEntity user});
  Future<UserEntity> getUserData({required String uid});
}
