import 'package:flutter/material.dart';
import '../shared/constants.dart';
import '../shared/widgets/custom_circle_button.dart';

class CartVeiw extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            bottom: 100,
          ),
          child: Column(
            children: [
              SingleCartItem(
                title: 'product naem',
                pieces: '4312',
                price: '23',
                image: 'assets/shoe2.jpg',
              ),
              SingleCartItem(
                title: 'product naem',
                pieces: '4312',
                price: '23',
                image: 'assets/shoe2.jpg',
              ),
              SingleCartItem(
                title: 'product naem',
                pieces: '4312',
                price: '23',
                image: 'assets/shoe2.jpg',
              ),
              SingleCartItem(
                title: 'product naem',
                pieces: '4312',
                price: '23',
                image: 'assets/shoe2.jpg',
              ),
              SingleCartItem(
                title: 'product naem',
                pieces: '4312',
                price: '23',
                image: 'assets/shoe2.jpg',
              ),
              SingleCartItem(
                title: 'product naem',
                pieces: '4312',
                price: '23',
                image: 'assets/shoe2.jpg',
              ),
              SingleCartItem(
                title: 'product naem',
                pieces: '4312',
                price: '23',
                image: 'assets/shoe2.jpg',
              ),
              SingleCartItem(
                title: 'product naem',
                pieces: '4312',
                price: '23',
                image: 'assets/shoe2.jpg',
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _buyButton(context),
    );
  }

  CustomCircleButton _buyButton(BuildContext context) {
    return CustomCircleButton(
      label: 'total 123 \$',
      color: Theme.of(context).accentColor,
      onpress: () {},
    );
  }
}

class SingleCartItem extends StatelessWidget {
  final String title, pieces, price, image;
  final Function onPress;
  const SingleCartItem(
      {@required this.title,
      @required this.pieces,
      @required this.price,
      @required this.image,
      this.onPress});

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
        '$pieces piece : $price \$',
        style: kPriceStyle,
      ),
      leading: CircleAvatar(
        backgroundImage: AssetImage(image),
      ),
    );
  }
}
