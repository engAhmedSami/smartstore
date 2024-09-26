import 'package:flutter/material.dart';
import 'package:storeapp/Featuers/Nav_Bar_Pages/Presentation/Views/Widget/inner_widget/orders_widget.dart';
import 'package:storeapp/Core/Utils/app_name_animated_text.dart';
import 'package:storeapp/Core/Utils/assets.dart';
import 'package:storeapp/Core/Widget/empty_widget.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});
  static const routeName = 'Orders';

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  bool isEmptyOrders = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const AppNameAnimatedText(
          text: 'Place Order',
          fontSize: 20,
        ),
      ),
      body: isEmptyOrders
          ? const EmptyWidget(
              size: Size(200, 200),
              image: Assets.users_imagesBagOrder,
              title: 'No Orders has been placed yet',
              subtitle: '',
              texButoon: 'Shop Now',
            )
          : const OrdersWidget(),
    );
  }
}
