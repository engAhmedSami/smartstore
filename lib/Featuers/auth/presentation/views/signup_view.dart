import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storeapp/Core/Services/get_it_service.dart';
import 'package:storeapp/Featuers/auth/domain/repos/auth_repo.dart';
import 'package:storeapp/Featuers/auth/presentation/cubits/signup_cubit/signup_cubit.dart';
import 'package:storeapp/Featuers/auth/presentation/views/widget/signeup_view_body_block_consumer.dart';

class SignupView extends StatelessWidget {
  const SignupView({super.key});
  static const routeName = 'Signup';
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignupCubit(
        getIt<AuthRepo>(),
      ),
      child: const Scaffold(
        body: SigneupViewBodyBlockConsumer(),
      ),
    );
  }
}
