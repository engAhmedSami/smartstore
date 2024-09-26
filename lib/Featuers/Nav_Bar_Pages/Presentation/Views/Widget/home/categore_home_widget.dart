import 'package:flutter/material.dart';
import 'package:storeapp/Featuers/Nav_Bar_Pages/Presentation/Views/Widget/search/search_view.dart';
import 'package:storeapp/Core/Utils/app_styles.dart';

class CategoreHomeWidget extends StatelessWidget {
  const CategoreHomeWidget(
      {super.key, required this.image, required this.name});
  final String image, name;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await Navigator.pushNamed(
          context,
          SearchView.routeName,
          arguments: name,
        );
      },
      child: Column(
        children: [
          Image.asset(
            image,
            height: 50,
            width: 50,
            fit: BoxFit.fill,
          ),
          Text(
            name,
            style: AppStyles.styleBold16,
          )
        ],
      ),
    );
  }
}
