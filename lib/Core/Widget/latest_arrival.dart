import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storeapp/Featuers/Nav_Bar_Pages/Models/product_model.dart';
import 'package:storeapp/Featuers/Nav_Bar_Pages/Presentation/Views/Widget/inner_widget/product_details.dart';
import 'package:storeapp/Core/Utils/app_styles.dart';
import 'package:storeapp/Core/Widget/heart_botton.dart';

import 'package:storeapp/providers/cart_provider.dart';
import 'package:storeapp/providers/product_provider.dart';
import 'package:storeapp/providers/viewed_prod_provider.dart';

class LatestArrival extends StatelessWidget {
  const LatestArrival({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final viewedRecently = Provider.of<ViewedProdProvider>(context);

    final productModel = Provider.of<ProductModel>(context);
    final getCurrProduct = productProvider.findByProdId(
      productModel.productId,
    );
    final cartProvider = Provider.of<CartProvider>(context);
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () async {
        viewedRecently.addProductToHistory(
          productId: productModel.productId,
        );
        await Navigator.pushNamed(context, ProductDetails.routeName,
            arguments: getCurrProduct.productId);
      },
      child: SizedBox(
        width: size.width * 0.45,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: FancyShimmerImage(
                  imageUrl: productModel.productImage,
                  width: size.width * 0.28,
                  height: size.width * 0.28,
                ),
              ),
            ),
            const SizedBox(
              width: 7,
            ),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    productModel.productTitle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppStyles.styleMedium16,
                  ),
                  FittedBox(
                    child: Row(
                      children: [
                        HeartBottom(
                          productId: getCurrProduct!.productId,
                        ),
                        IconButton(
                          onPressed: () {
                            if (cartProvider.isProductInCart(
                                productId: getCurrProduct.productId)) {
                              return;
                            }
                            cartProvider.addItemsToCart(
                                productId: getCurrProduct.productId);
                          },
                          icon: Icon(
                            cartProvider.isProductInCart(
                                    productId: getCurrProduct.productId)
                                ? Icons.check
                                : Icons.add_shopping_cart_rounded,
                            size: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                  FittedBox(
                    child: Text(
                      "${productModel.productPrice} \$",
                      style: AppStyles.styleMedium16.copyWith(
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: size.width * 0.03,
            )
          ],
        ),
      ),
    );
  }
}
