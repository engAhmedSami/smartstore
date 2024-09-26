import 'package:storeapp/Featuers/Nav_Bar_Pages/Models/categories_model.dart';
import 'package:storeapp/Core/Utils/assets.dart';

const kHorizintalPadding = 12.0;

class AppConstans {
  static const String product1mageUr1 =
      'https://upload.wikimedia.org/wikipedia/commons/9/9c/Choose_an_option.jpg';

  static List<String> bannerslmages = [
    Assets.users_imagesBannersBanner1,
    Assets.users_imagesBannersBanner2
  ];

  static List<CategoriesModel> categoriesListModel = [
    CategoriesModel(
      image: Assets.users_imagesCategoriesMobiles,
      name: 'Phones',
      id: Assets.users_imagesCategoriesMobiles,
    ),
    CategoriesModel(
      image: Assets.users_imagesCategoriesPc,
      name: 'Laptops',
      id: Assets.users_imagesCategoriesPc,
    ),
    CategoriesModel(
      image: Assets.users_imagesCategoriesElectronics,
      name: 'Electronics',
      id: Assets.users_imagesCategoriesElectronics,
    ),
    CategoriesModel(
      image: Assets.users_imagesCategoriesWatch,
      name: 'Watches',
      id: Assets.users_imagesCategoriesWatch,
    ),
    CategoriesModel(
      image: Assets.users_imagesCategoriesFashion,
      name: 'Clothes',
      id: Assets.users_imagesCategoriesFashion,
    ),
    CategoriesModel(
      image: Assets.users_imagesCategoriesShoes,
      name: 'Shoes',
      id: Assets.users_imagesCategoriesShoes,
    ),
    CategoriesModel(
      image: Assets.users_imagesCategoriesBookImg,
      name: 'Books',
      id: Assets.users_imagesCategoriesBookImg,
    ),
    CategoriesModel(
      image: Assets.users_imagesCategoriesCosmetics,
      name: 'Cosmetics',
      id: Assets.users_imagesCategoriesCosmetics,
    ),
  ];
}

class MyValidators {
  static String? displayNamevalidator(String? displayName) {
    if (displayName == null || displayName.isEmpty) {
      return 'Display name cannot be empty';
    }
    if (displayName.length < 3 || displayName.length > 20) {
      return 'Display name must be between 3 and 20 characters';
    }

    return null; // Return null if display name is valid
  }

  static String? emailValidator(String? value) {
    if (value!.isEmpty) {
      return 'Please enter an email';
    }
    if (!RegExp(r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b')
        .hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  static String? passwordValidator(String? value) {
    if (value!.isEmpty) {
      return 'Please enter a password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }

  static String? repeatPasswordValidator({String? value, String? password}) {
    if (value != password) {
      return 'Passwords do not match';
    }
    if (value!.isEmpty) {
      return 'Please confirm your password';
    }
    return null;
  }
}

const kUserData = 'userData';
