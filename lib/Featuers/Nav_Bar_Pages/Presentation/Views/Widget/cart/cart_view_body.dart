import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storeapp/Featuers/Nav_Bar_Pages/Presentation/Views/Widget/cart/cart_list_view.dart';
import 'package:storeapp/Core/Utils/assets.dart';
import 'package:storeapp/Core/Widget/empty_widget.dart';
import 'package:storeapp/providers/cart_provider.dart';

class CartViewBody extends StatelessWidget {
  const CartViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final cartProvider = Provider.of<CartProvider>(context);

    return cartProvider.getCartItems.isEmpty
        ? EmptyWidget(
            size: size,
            image: Assets.admin_imagesShoppingCart,
            title: 'Your cart is empty',
            subtitle:
                'Looks like you haven\'t added anything in your cart yet.',
            texButoon: 'Shop Now',
          )
        : const CartListView();
  }
}
