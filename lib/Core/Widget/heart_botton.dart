import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:storeapp/providers/wishlist_provider.dart';

class HeartBottom extends StatefulWidget {
  const HeartBottom(
      {super.key,
      this.size = 22,
      this.color = Colors.transparent,
      required this.productId});
  final double size;
  final Color? color;
  final String productId;
  @override
  State<HeartBottom> createState() => _HeartBottomState();
}

class _HeartBottomState extends State<HeartBottom> {
  @override
  Widget build(BuildContext context) {
    final wishlistProvider = Provider.of<WishlistProvider>(context);

    return Material(
      color: widget.color,
      shape: const CircleBorder(),
      child: IconButton(
        onPressed: () {
          wishlistProvider.addOrRemoveFromWishlist(
            productId: widget.productId,
          );
        },
        icon: Icon(
          wishlistProvider.isProductInWishlist(productId: widget.productId)
              ? IconlyBold.heart
              : IconlyLight.heart,
          size: widget.size,
          color:
              wishlistProvider.isProductInWishlist(productId: widget.productId)
                  ? Colors.red
                  : Colors.grey,
        ),
      ),
    );
  }
}
