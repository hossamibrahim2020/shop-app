import 'package:flutter/material.dart';
import '../constants.dart';

class SingleCartItem extends StatelessWidget {
  final String title, price, image, tax;
  final Function onPress;
  const SingleCartItem({
    @required this.title,
    @required this.price,
    @required this.tax,
    @required this.image,
    this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: kPriceStyle.copyWith(fontWeight: FontWeight.w600),
      ),
      trailing: IconButton(
        icon: Icon(Icons.close),
        onPressed: onPress,
      ),
      subtitle: Text(
        '$price \$ tax: $tax',
        style: kPriceStyle,
      ),
      leading: CircleAvatar(
        backgroundImage: AssetImage('assets/$image'),
        radius: 30,
      ),
    );
  }
}
