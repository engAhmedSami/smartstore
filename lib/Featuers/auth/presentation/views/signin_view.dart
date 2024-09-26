import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storeapp/Featuers/auth/domain/repos/auth_repo.dart';
import 'package:storeapp/Featuers/auth/presentation/cubits/signin_cubit/signin_cubit.dart';
import 'package:storeapp/Featuers/auth/presentation/views/widget/signin_view_body_bloc_consumer.dart';

import '../../../../core/services/get_it_service.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});
  static const routeName = 'login';
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SigninCubit(
        getIt.get<AuthRepo>(),
      ),
      child: const Scaffold(
        body: SignInViewBodyBlocConsumer(),
      ),
    );
  }
}
