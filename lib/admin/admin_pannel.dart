import 'package:flutter/material.dart';
import 'view_order.dart';
import 'add_product.dart';
import '../shared/widgets/custom_circle_button.dart';

class AdminPannel extends StatelessWidget {
  static const String route = '/admin pannel';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          CustomCircleButton(
            label: 'Add Produt',
            color: Colors.lightBlue.shade900,
            onpress: () => Navigator.of(context).pushNamed(
              AddProduct.route,
            ),
            horizontal: 16,
            vertical: 20,
          ),
          CustomCircleButton(
            label: 'View Orders',
            color: Colors.deepOrange,
            onpress: () => Navigator.of(context).pushNamed(
              ViewOrders.route,
            ),
            horizontal: 16,
            vertical: 20,
          ),
        ],
      ),
    );
  }
}
