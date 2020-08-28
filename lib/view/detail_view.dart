import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../controller/cart_provider.dart';
import '../model/product_model.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import '../shared/constants.dart';

class DetailView extends StatefulWidget {
  final DocumentSnapshot data;
  DetailView(this.data);
  @override
  _DetailViewState createState() => _DetailViewState();
}

class _DetailViewState extends State<DetailView> {
  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              _headerStack(context),
              _body(context, widget.data),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _addToCart(context, widget.data),
    );
  }

  Widget _headerStack(BuildContext context) {
    return Stack(
      children: <Widget>[
        _image(context),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Container(
              height: 40,
              width: 40,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                ),
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).accentColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Container _image(BuildContext context) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      height: MediaQuery.of(context).size.height * .45,
      child: InteractiveViewer(
        child: Image.asset('assets/${widget.data[ProductStrings.kimage]}'),
      ),
    );
  }

  Widget _body(BuildContext context, final DocumentSnapshot data) {
    return Container(
      height: MediaQuery.of(context).size.height * .7,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.blueGrey[50],
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(50),
          topLeft: Radius.circular(50),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  '${data[ProductStrings.kName]}',
                  style: kDetailScreenStyle,
                ),
                Text(
                  'Price: ${data[ProductStrings.kPrice]} \$',
                  style: kDetailScreenStyle,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                'Seller: ${data[ProductStrings.kAdminName]}',
                style: kDetailScreenStyle,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                'Description: ${data[ProductStrings.kDescirption]}',
                style: kDetailScreenStyle,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                'Size: ${data[ProductStrings.kSize]}',
                style: kDetailScreenStyle,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                'Tax: ${data[ProductStrings.kTax]} %',
                style: kDetailScreenStyle,
              ),
            ),
            _numberOfProduct(context),
          ],
        ),
      ),
    );
  }

  Widget _numberOfProduct(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        IconButton(
          icon: Icon(
            Icons.add_circle,
            color: Theme.of(context).accentColor,
            size: 35,
          ),
          onPressed: () => _increment(),
        ),
        Container(
          height: 50,
          width: 50,
          child: Center(
            child: Text(
              _numberOfProductValue.toString(),
              style: kAppBarStyle,
            ),
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).accentColor,
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
        ),
        IconButton(
          icon: Icon(
            Icons.remove_circle,
            color: Theme.of(context).accentColor,
            size: 35,
          ),
          onPressed: () => _decrement(context),
        ),
      ],
    );
  }

  int _numberOfProductValue = 1;
  void _increment() {
    return setState(() {
      _numberOfProductValue++;
    });
  }

  void _decrement(BuildContext context) {
    if (_numberOfProductValue > 1) {
      setState(() {
        _numberOfProductValue--;
      });
    } else {
      Toast.show('cann\'t decrement', context);
    }
  }

  Widget _addToCart(BuildContext context, final DocumentSnapshot data) {
    ProductModel _product = ProductModel(
      '${data[ProductStrings.kAdminName]}',
      '${data[ProductStrings.kName]}',
      '${data[ProductStrings.kDescirption]}',
      '${data[ProductStrings.kPrice]}',
      '${data[ProductStrings.kTax]}',
      '${data[ProductStrings.kSize]}',
      '${data[ProductStrings.kimage]}',
      _numberOfProductValue,
    );
    bool _addedBefore = false;
    return Consumer<CartProvider>(
      builder: (BuildContext context, CartProvider cart, Widget child) {
        return FlatButton(
          padding: const EdgeInsets.all(0.0),
          onPressed: () {
            try {
              List<ProductModel> productsInCart = cart.cartArray;
              for (var productInCart in productsInCart) {
                if (productInCart.pname == _product.pname) {
                  _addedBefore = true;
                }
              }
              if (_addedBefore == true) {
                Toast.show('This product added before', context);
              } else {
                cart.addToCart(_product);
                Navigator.of(context).pop();
                Toast.show('Added To Cart', context);
              }
            } on PlatformException catch (e) {
              Toast.show('${e.message}', context);
            }
          },
          child: Container(
            height: 70,
            width: double.infinity,
            color: Theme.of(context).accentColor,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add_shopping_cart,
                    size: 30,
                    color: Colors.white,
                  ),
                  SizedBox(width: 20),
                  Text(
                    'AddToCart',
                    style: kAppBarStyle.copyWith(fontSize: 30),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
