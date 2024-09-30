// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:storeapp/Core/Utils/show_dialog.dart';
// import 'package:storeapp/Featuers/Nav_Bar_Pages/Presentation/Views/Widget/profile/general.dart';
// import 'package:storeapp/Featuers/Nav_Bar_Pages/Presentation/Views/Widget/profile/general_custom_list_tile.dart';
// import 'package:storeapp/Featuers/Nav_Bar_Pages/Presentation/Views/Widget/profile/user_info.dart';
// import 'package:storeapp/Core/Utils/app_styles.dart';
// import 'package:storeapp/Core/Utils/assets.dart';
// import 'package:storeapp/Featuers/auth/presentation/views/signin_view.dart';

// import 'package:storeapp/providers/theme_provider.dart';

// class ProfileViewBody extends StatefulWidget {
//   const ProfileViewBody({super.key});

//   @override
//   State<ProfileViewBody> createState() => _ProfileViewBodyState();
// }

// class _ProfileViewBodyState extends State<ProfileViewBody> {
//   User? user = FirebaseAuth.instance.currentUser;
//   @override
//   Widget build(BuildContext context) {
//     final themeProvider = Provider.of<ThemeProvider>(context);

//     return SingleChildScrollView(
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 12),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const SizedBox(
//               height: 20,
//             ),
//             const Visibility(
//               visible: false,
//               child: Text('Please Login to have ultimate asccess'),
//             ),
//             const UserInfolisttile(),
//             const SizedBox(
//               height: 16,
//             ),
//             const General(),
//             const SizedBox(
//               height: 16,
//             ),
//             const Divider(
//               height: 2,
//             ),
//             const SizedBox(
//               height: 16,
//             ),
//             const Text(
//               'Settings',
//               style: AppStyles.styleSemiBold18,
//             ),
//             SwitchListTile(
//               secondary: Image.asset(
//                 Assets.users_imagesProfileTheme,
//                 height: 30,
//               ),
//               title: Text(
//                   themeProvider.getIsDarkTheme ? "Dark mode" : "Light mode"),
//               value: themeProvider.getIsDarkTheme,
//               onChanged: (value) {
//                 themeProvider.setDarkTheme(themeValue: value);
//               },
//             ),
//             const SizedBox(
//               height: 16,
//             ),
//             const Divider(
//               height: 2,
//             ),
//             const SizedBox(
//               height: 16,
//             ),
//             const Text(
//               'Others',
//               style: AppStyles.styleSemiBold18,
//             ),
//             GeneralCustomListTile(
//                 onTap: () {},
//                 image: Assets.users_imagesProfilePrivacy,
//                 title: "Privacy & Policy"),
//             const SizedBox(
//               height: 30,
//             ),
//             Center(
//               child: ElevatedButton.icon(
//                 style: ElevatedButton.styleFrom(
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(16),
//                   ),
//                 ),
//                 icon: Icon(user == null ? Icons.login : Icons.logout),
//                 label: Text(
//                   user == null ? 'LogIn' : 'Logout',
//                 ),
//                 onPressed: () async {
//                   if (user == null) {
//                     await Navigator.pushNamed(context, SignInView.routeName);
//                   } else {
//                     await ShowDialogClass.showDialogClass(
//                       context: context,
//                       text: 'Are you sure ?',
//                       function: () async {
//                         await FirebaseAuth.instance.signOut();
//                         if (!mounted) {
//                           return;
//                         } else {
//                           await Navigator.pushNamed(
//                               context, SignInView.routeName);
//                         }
//                       },
//                       isError: false,
//                     );
//                   }
//                 },
//               ),
//             ),
//             // CustomBotton(
//             //   text: user == null ? 'LogIn' : 'Logout',
//             //   onPressed: () async {
//             //     await Navigator.pushNamed(context, SignInView.routeName);
//             //     // await ShowDialogClass.showDialogClass(
//             //     //   context: context,
//             //     //   text: 'Are you sure ?',
//             //     //   function: () {},
//             //     //   isError: true,
//             //     // );
//             //   },
//             // ),
//             const SizedBox(
//               height: 20,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storeapp/Core/Utils/show_dialog.dart';
import 'package:storeapp/Featuers/Nav_Bar_Pages/Presentation/Views/Widget/profile/general.dart';
import 'package:storeapp/Featuers/Nav_Bar_Pages/Presentation/Views/Widget/profile/general_custom_list_tile.dart';
import 'package:storeapp/Featuers/Nav_Bar_Pages/Presentation/Views/Widget/profile/user_info.dart';
import 'package:storeapp/Core/Utils/app_styles.dart';
import 'package:storeapp/Core/Utils/assets.dart';
import 'package:storeapp/Featuers/auth/presentation/views/signin_view.dart';
import 'package:storeapp/providers/theme_provider.dart';

class ProfileViewBody extends StatefulWidget {
  const ProfileViewBody({super.key});

  @override
  State<ProfileViewBody> createState() => _ProfileViewBodyState();
}

class _ProfileViewBodyState extends State<ProfileViewBody> {
  User? user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    // Add the post-frame callback to ensure the context is used safely
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Perform any actions that need the context here
      if (user == null) {
        // Example action: Show a prompt if user is not logged in
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please log in to access all features')),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Visibility(
              visible: false,
              child: Text('Please Login to have ultimate access'),
            ),
            const UserInfolisttile(),
            const SizedBox(height: 16),
            const General(),
            const SizedBox(height: 16),
            const Divider(height: 2),
            const SizedBox(height: 16),
            const Text(
              'Settings',
              style: AppStyles.styleSemiBold18,
            ),
            SwitchListTile(
              secondary: Image.asset(
                Assets.users_imagesProfileTheme,
                height: 30,
              ),
              title: Text(
                  themeProvider.getIsDarkTheme ? "Dark mode" : "Light mode"),
              value: themeProvider.getIsDarkTheme,
              onChanged: (value) {
                themeProvider.setDarkTheme(themeValue: value);
              },
            ),
            const SizedBox(height: 16),
            const Divider(height: 2),
            const SizedBox(height: 16),
            const Text(
              'Others',
              style: AppStyles.styleSemiBold18,
            ),
            GeneralCustomListTile(
              onTap: () {},
              image: Assets.users_imagesProfilePrivacy,
              title: "Privacy & Policy",
            ),
            const SizedBox(height: 30),
            Center(
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                icon: Icon(user == null ? Icons.login : Icons.logout),
                label: Text(user == null ? 'LogIn' : 'Logout'),
                onPressed: () async {
                  if (user == null) {
                    // Navigate immediately, without using context after an async gap
                    await Navigator.pushNamed(context, SignInView.routeName);
                  } else {
                    await ShowDialogClass.showDialogClass(
                      context: context,
                      text: 'Are you sure?',
                      function: () async {
                        await FirebaseAuth.instance.signOut();
                        // Ensure navigation occurs within the addPostFrameCallback
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          Navigator.pushNamed(context, SignInView.routeName);
                        });
                      },
                      isError: false,
                    );
                  }
                },
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
