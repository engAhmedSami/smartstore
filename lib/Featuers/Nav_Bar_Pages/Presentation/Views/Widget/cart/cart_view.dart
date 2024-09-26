import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:storeapp/Featuers/Nav_Bar_Pages/Presentation/Views/Widget/cart/cart_view_body.dart';
import 'package:storeapp/Featuers/Nav_Bar_Pages/Presentation/Views/Widget/cart/chechout.dart';
import 'package:storeapp/Core/Utils/app_name_animated_text.dart';
import 'package:storeapp/Core/Utils/assets.dart';
import 'package:storeapp/Core/Utils/show_dialog.dart';

import 'package:storeapp/providers/cart_provider.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      bottomSheet: const Checkout(),
      appBar: AppBar(
        title: AppNameAnimatedText(
          text: 'Shopping basket (${cartProvider.cartItems.length})',
          fontSize: 20,
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Image.asset(Assets.admin_imagesShoppingCart),
        ),
        actions: [
          IconButton(
            onPressed: () {
              ShowDialogClass.showDialogClass(
                context: context,
                text: 'Remove all items ?',
                function: () {
                  cartProvider.clearLocalCart();
                },
              );
            },
            icon: const Icon(
              IconlyLight.delete,
            ),
          ),
        ],
      ),
      body: const CartViewBody(),
    );
  }
}
