import 'package:flutter/material.dart';
import 'package:storeapp/Featuers/Nav_Bar_Pages/Models/cart_model.dart';
import 'package:storeapp/Featuers/Nav_Bar_Pages/Models/product_model.dart';

import 'package:storeapp/providers/product_provider.dart';
import 'package:uuid/uuid.dart';

class CartProvider with ChangeNotifier {
  final Map<String, CartModel> cartItems = {};

  Map<String, CartModel> get getCartItems {
    return cartItems;
  }

  bool isProductInCart({
    required String productId,
  }) {
    return cartItems.containsKey(productId);
  }

  void addItemsToCart({
    required String productId,
  }) {
    cartItems.putIfAbsent(
      productId,
      () => CartModel(
        productId: productId,
        quantity: 1,
        cartId: const Uuid().v4(),
      ),
    );

    notifyListeners();
  }

  void updataQuantity({
    required String productId,
    required int quantity,
  }) {
    cartItems.update(
      productId,
      (item) => CartModel(
        productId: productId,
        quantity: quantity,
        cartId: item.cartId,
      ),
    );

    notifyListeners();
  }

  num totalAmount({required ProductProvider productProvider}) {
    num total = 0.0;
    cartItems.forEach(
      (key, value) {
        final ProductModel? getCurrProduct = productProvider.findByProdId(
          value.productId,
        );
        if (getCurrProduct == null) {
          total += 0;
        } else {
          total += num.parse(getCurrProduct.productPrice) * value.quantity;
        }
      },
    );
    return total;
  }

  void removeOneItem({
    required String productId,
  }) {
    cartItems.remove(
      productId,
    );

    notifyListeners();
  }

  void clearLocalCart() {
    cartItems.clear();

    notifyListeners();
  }

  int getQty() {
    int total = 0;
    cartItems.forEach(
      (key, value) {
        total += value.quantity;
      },
    );
    return total;
  }
}
