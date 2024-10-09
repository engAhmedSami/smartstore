import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:storeapp/Core/Services/custom_block_observer.dart';
import 'package:storeapp/Core/Services/shared_preferences_sengleton.dart';
import 'package:storeapp/Featuers/Nav_Bar_Pages/Presentation/Views/Widget/inner_widget/orders.dart';
import 'package:storeapp/Featuers/Nav_Bar_Pages/Presentation/Views/Widget/inner_widget/product_details.dart';
import 'package:storeapp/Featuers/Nav_Bar_Pages/Presentation/Views/Widget/inner_widget/viewed_recently.dart';
import 'package:storeapp/Featuers/Nav_Bar_Pages/Presentation/Views/Widget/inner_widget/wishlist.dart';
import 'package:storeapp/Core/Utils/theme_data.dart';
import 'package:storeapp/Core/Widget/nav_bar.dart';
import 'package:storeapp/Featuers/Nav_Bar_Pages/Presentation/Views/Widget/search/search_view.dart';

import 'package:storeapp/Featuers/authUseingProvider/forgot_password.dart';
import 'package:storeapp/Featuers/authUseingProvider/forgot_password_view.dart';
import 'package:storeapp/Featuers/authUseingProvider/login.dart';
import 'package:storeapp/Featuers/authUseingProvider/register.dart';
import 'package:storeapp/firebase_options.dart';
import 'package:storeapp/providers/cart_provider.dart';
import 'package:storeapp/providers/product_provider.dart';
import 'package:storeapp/providers/theme_provider.dart';
import 'package:storeapp/providers/user_provider.dart';
import 'package:storeapp/providers/viewed_prod_provider.dart';
import 'package:storeapp/providers/wishlist_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = CustomBlockObserver();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Prefs.init();
  // setupGetit();
  runApp(const SmartStore());
}

class SmartStore extends StatelessWidget {
  const SmartStore({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ThemeProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ProductProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => CartProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => WishlistProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ViewedProdProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
      ],
      child: Consumer<ThemeProvider>(builder: (
        context,
        themeProvider,
        child,
      ) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: Styles.themeData(
              isDarkTheme: themeProvider.getIsDarkTheme, context: context),
          home: const NavBar(),
          routes: {
            ProductDetails.routeName: (context) => const ProductDetails(),
            Wishlist.routeName: (context) => const Wishlist(),
            ViewedRecently.routeName: (context) => const ViewedRecently(),
            // SignupView.routeName: (context) => const SignupView(),
            // SignInView.routeName: (context) => const SignInView(),
            Orders.routeName: (context) => const Orders(),
            ForgotPasswordView.routeName: (context) =>
                const ForgotPasswordView(),
            SearchView.routeName: (context) => const SearchView(),
            NavBar.routeName: (context) => const NavBar(),
            ForgotPasswordScreen.routeName: (context) =>
                const ForgotPasswordScreen(),
            LoginScreen.routeName: (context) => const LoginScreen(),
            RegisterScreen.routeName: (context) => const RegisterScreen(),
          },
        );
      }),
    );
  }
}
