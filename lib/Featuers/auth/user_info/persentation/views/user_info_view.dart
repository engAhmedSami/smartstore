import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storeapp/Core/Utils/app_name_animated_text.dart';
import 'package:storeapp/Featuers/auth/user_info/persentation/save_info_cubit/profile_cubit.dart';
import 'package:storeapp/Featuers/auth/user_info/persentation/save_info_cubit/profile_state.dart';
import 'package:storeapp/Featuers/auth/user_info/persentation/views/widget/user_info_view_body.dart';

class UserInfoView extends StatelessWidget {
  const UserInfoView({super.key});
  static const String routeName = 'UserInfo';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: const AppNameAnimatedText(
            text: 'User Info',
            fontSize: 20,
          ),
        ),
        body: BlocConsumer<ProfileCubit, ProfileState>(
          listener: (context, state) {},
          builder: (context, state) {
            return const UserInfoViewBody();
          },
        ),
      ),
    );
  }
}
