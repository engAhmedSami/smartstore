import 'package:flutter/material.dart';
import 'package:storeapp/Featuers/Nav_Bar_Pages/Presentation/Views/Widget/inner_widget/orders_widget_items.dart';

class OrdersWidget extends StatelessWidget {
  const OrdersWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 15,
      itemBuilder: (context, index) {
        return const OrdersWidgetItems();
      },
      separatorBuilder: (context, index) {
        return const Divider();
      },
    );
  }
}
