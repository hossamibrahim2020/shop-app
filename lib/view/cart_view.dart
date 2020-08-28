import 'package:flutter/material.dart';
import '../model/product_model.dart';
import 'package:toast/toast.dart';
import '../shared/widgets/single_item_cart.dart';
import '../controller/cart_provider.dart';
import 'package:provider/provider.dart';
import '../shared/widgets/custom_circle_button.dart';

class CartVeiw extends StatefulWidget {
  @override
  _CartVeiwState createState() => _CartVeiwState();
}

class _CartVeiwState extends State<CartVeiw> {
  @override
  Widget build(BuildContext context) {
    CartProvider _cart = Provider.of<CartProvider>(context);
    return _cart.cartArray.length == 0 || _cart.cartArray == null
        ? _emptyCart(context)
        : _fullCart(_cart, context);
  }

  Scaffold _emptyCart(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Icon(
              Icons.remove_shopping_cart,
              size: 90,
              color: Theme.of(context).accentColor,
            ),
          ),
        ],
      ),
    );
  }

  Scaffold _fullCart(CartProvider _cart, BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          bottom: 100,
        ),
        child: ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            ProductModel data = _cart.cartArray[index];
            int quantity = data.quantity;
            int tax = int.parse(data.ptax) * quantity;
            int price = int.parse(data.pprice) * quantity;
            return Card(
              child: Column(
                children: [
                  SingleCartItem(
                    title: '${data.pname}',
                    tax: '$tax',
                    price: '$price',
                    image: '${data.pimage}',
                    onPress: () {
                      _cart.removeFromCart(
                        ProductModel(
                          data.padminName,
                          data.pname,
                          data.pdescirption,
                          data.pprice,
                          data.ptax,
                          data.psize,
                          data.pimage,
                          data.quantity,
                        ),
                      );
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          setState(() {
                            data.quantity++;
                          });
                        },
                      ),
                      Text('${data.quantity}'),
                      IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: () {
                          if (data.quantity > 1) {
                            setState(() {
                              data.quantity--;
                            });
                          } else {
                            Toast.show('cann\'t order zero products', context);
                          }
                        },
                      ),
                    ],
                  )
                ],
              ),
            );
          },
          itemCount: _cart.cartArray.length,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _buyButton(context),
    );
  }

  Widget _buyButton(BuildContext context) {
    return CustomCircleButton(
      label: 'Order now',
      color: Theme.of(context).accentColor,
      onpress: () {},
      horizontal: 0,
      vertical: 20,
    );
  }
}
