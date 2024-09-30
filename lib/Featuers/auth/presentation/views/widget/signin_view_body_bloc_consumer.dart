import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storeapp/Core/Helper_Functions/failuer_top_snak_bar.dart';
import 'package:storeapp/Core/Helper_Functions/scccess_top_snak_bar.dart';
import 'package:storeapp/Core/Utils/custom_progrss_hud.dart';
import 'package:storeapp/Core/Widget/nav_bar.dart';
import 'package:storeapp/Featuers/auth/presentation/cubits/signin_cubit/signin_cubit.dart';
import 'package:storeapp/Featuers/auth/presentation/views/widget/signin_view_body.dart';

class SignInViewBodyBlocConsumer extends StatelessWidget {
  const SignInViewBodyBlocConsumer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SigninCubit, SigninState>(
      listener: (context, state) {
        if (state is SigninSuccess) {
          succesTopSnackBar(context, 'signin successfully');
          Navigator.pushNamed(
            context,
            NavBar.routeName,
          );
        }
        if (state is SigninFailure) {
          failuerTopSnackBar(context, state.message);
        }
      },
      builder: (context, state) {
        return CustomProgrssHud(
          isLoading: state is SigninLoding,
          child: const SignInViewBody(),
        );
      },
    );
  }
}
