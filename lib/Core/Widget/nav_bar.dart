import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:storeapp/Featuers/Nav_Bar_Pages/Presentation/Views/Widget/cart/cart_view.dart';
import 'package:storeapp/Featuers/Nav_Bar_Pages/Presentation/Views/Widget/home/home_view.dart';
import 'package:storeapp/Featuers/Nav_Bar_Pages/Presentation/Views/Widget/profile/profile_view.dart';
import 'package:storeapp/Featuers/Nav_Bar_Pages/Presentation/Views/Widget/search/search_view.dart';

import 'package:storeapp/providers/cart_provider.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  List<Widget> pages = const [
    HomeView(),
    SearchView(),
    CartView(),
    ProfileView(),
  ];
  late PageController? controller;
  int currentPage = 0;

  @override
  void initState() {
    controller = PageController(
      initialPage: currentPage,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: controller,
        children: pages,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentPage,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 2,
        height: kBottomNavigationBarHeight,
        destinations: [
          const NavigationDestination(
            selectedIcon: Icon(IconlyBold.home),
            icon: Icon(IconlyLight.home),
            label: 'Home',
          ),
          const NavigationDestination(
            selectedIcon: Icon(IconlyBold.search),
            icon: Icon(IconlyLight.search),
            label: 'Search',
          ),
          NavigationDestination(
            selectedIcon: const Icon(IconlyBold.bag2),
            icon: Badge(
                label: Text('${cartProvider.getCartItems.length}'),
                child: const Icon(IconlyLight.bag2)),
            label: 'Cart',
          ),
          const NavigationDestination(
            selectedIcon: Icon(IconlyBold.profile),
            icon: Icon(IconlyLight.profile),
            label: 'Profile',
          ),
        ],
        onDestinationSelected: (index) {
          setState(() {
            currentPage = index;
          });
          controller?.jumpToPage(currentPage);
        },
      ),
    );
  }
}
