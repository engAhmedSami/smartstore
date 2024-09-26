import 'package:flutter/material.dart';
import 'package:storeapp/Featuers/Nav_Bar_Pages/Models/wishlist_model.dart';
import 'package:uuid/uuid.dart';

class WishlistProvider with ChangeNotifier {
  final Map<String, WishlistModel> wishlistItems = {};

  Map<String, WishlistModel> get getwishlistItems {
    return wishlistItems;
  }

  bool isProductInWishlist({
    required String productId,
  }) {
    return wishlistItems.containsKey(productId);
  }

  void addOrRemoveFromWishlist({
    required String productId,
  }) {
    if (wishlistItems.containsKey(productId)) {
      wishlistItems.remove(productId);
    } else {
      wishlistItems.putIfAbsent(
        productId,
        () => WishlistModel(
          productId: productId,
          id: const Uuid().v4(),
        ),
      );
    }

    notifyListeners();
  }

  void clearLocalWishlist() {
    wishlistItems.clear();

    notifyListeners();
  }
}
