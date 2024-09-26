import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storeapp/Featuers/Nav_Bar_Pages/Presentation/Views/Widget/cart/bouttom_checkout.dart';
import 'package:storeapp/providers/cart_provider.dart';

class Checkout extends StatelessWidget {
  const Checkout({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    return cartProvider.getCartItems.isEmpty
        ? const SizedBox.shrink()
        : Container(
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              border: Border(
                  top: BorderSide(
                      color: Theme.of(context).dividerColor, width: 1)),
            ),
            child: const SizedBox(
              height: kBottomNavigationBarHeight + 10,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: BouttomCheckout(),
              ),
            ),
          );
  }
}
