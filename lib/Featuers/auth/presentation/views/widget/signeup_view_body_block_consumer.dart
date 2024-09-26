import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storeapp/Core/Helper_Functions/failuer_top_snak_bar.dart';
import 'package:storeapp/Core/Helper_Functions/scccess_top_snak_bar.dart';
import 'package:storeapp/Core/Utils/custom_progrss_hud.dart';
import 'package:storeapp/Featuers/Nav_Bar_Pages/Presentation/Views/Widget/search/search_view.dart';
import 'package:storeapp/Featuers/auth/presentation/cubits/signup_cubit/signup_cubit.dart';
import 'package:storeapp/Featuers/auth/presentation/views/widget/signup_view_body.dart';

class SigneupViewBodyBlockConsumer extends StatelessWidget {
  const SigneupViewBodyBlockConsumer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignupCubit, SignupState>(
      listener: (context, state) {
        if (state is SignupSuccess) {
          succesTopSnackBar(context, 'Loged in successfully');
          Navigator.pushNamed(
            context,
            SearchView.routeName,
          );
        }
        if (state is SignupFailure) {
          failuerTopSnackBar(context, state.message);
        }
      },
      builder: (context, state) {
        return CustomProgrssHud(
          isLoading: state is SignupLoding,
          child: const SignupViewBody(),
        );
      },
    );
  }
}
