import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storeapp/Core/Utils/app_styles.dart';
import 'package:storeapp/Core/Widget/latest_arrival.dart';
import 'package:storeapp/constans.dart';
import 'package:storeapp/providers/product_provider.dart';

class HomeCardSwiper extends StatelessWidget {
  const HomeCardSwiper({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: size.height * 0.2,
          child: Swiper(
            itemBuilder: (BuildContext context, int index) {
              return Image.asset(
                AppConstans.bannerslmages[index],
                fit: BoxFit.fill,
              );
            },
            autoplay: true,
            itemCount: AppConstans.bannerslmages.length,
            pagination: const SwiperPagination(
              alignment: Alignment.bottomCenter,
              builder: DotSwiperPaginationBuilder(
                color: Colors.white,
                activeColor: Colors.red,
              ),
            ),
          ),
        ),
        const SizedBox(height: 32),
        const Text(
          'Latest Arrival',
          style: AppStyles.styleSemiBold24,
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: size.height * 0.2,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 10,
            itemBuilder: (context, index) {
              return ChangeNotifierProvider.value(
                  value: productProvider.getProducts[index],
                  child: const LatestArrival());
            },
          ),
        )
      ],
    );
  }
}
