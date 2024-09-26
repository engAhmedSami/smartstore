import 'package:flutter/material.dart';
import 'package:storeapp/Featuers/Nav_Bar_Pages/Presentation/Views/Widget/home/home_view_body.dart';
import 'package:storeapp/Core/Utils/app_name_animated_text.dart';
import 'package:storeapp/Core/Utils/assets.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppNameAnimatedText(
          text: 'Shop Smart',
          fontSize: 24,
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Image.asset(Assets.admin_imagesShoppingCart),
        ),
      ),
      body: const HomeViewBody(),
    );
  }
}
