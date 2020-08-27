import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../shared/constants.dart';
import '../model/product_model.dart';
import '../shared/widgets/custom_circle_button.dart';
import '../shared/widgets/custom_text_form_field.dart';

class AddProduct extends StatefulWidget {
  static const String route = '/addProduct';
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final AddProductToFireStore _store = AddProductToFireStore();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _adminName = TextEditingController();
  TextEditingController _name = TextEditingController();
  TextEditingController _descirption = TextEditingController();
  TextEditingController _price = TextEditingController();
  TextEditingController _tax = TextEditingController();
  TextEditingController _size = TextEditingController();
  TextEditingController _image = TextEditingController();

  @override
  void dispose() {
    this._adminName.dispose();
    this._name.dispose();
    this._descirption.dispose();
    this._price.dispose();
    this._tax.dispose();
    this._size.dispose();
    this._image.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: bodyForm(context),
        ),
      ),
    );
  }

  Form bodyForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          adminForm(),
          nameForm(),
          descriptionForm(),
          priceForm(),
          taxFrom(),
          sizeForm(),
          imageForm(),
          addProductButton(),
        ],
      ),
    );
  }

  CustomCircleButton addProductButton() {
    return CustomCircleButton(
      label: 'Add To Data base',
      color: Colors.lightBlue.shade900,
      onpress: () {
        if (_formKey.currentState.validate()) {
          final ProductModel product = ProductModel(
            _adminName.text,
            _name.text,
            _descirption.text,
            _price.text,
            _tax.text,
            _size.text,
            _image.text,
          );
          _store.addToStore(product);
        }
      },
    );
  }

  CustomTextFormField imageForm() {
    return CustomTextFormField(
      label: 'image',
      icon: Icons.image,
      textInputType: TextInputType.text,
      obscure: false,
      validat: (String value) {
        return value.length < 2 ? 'please enter name of product' : null;
      },
      controller: _image,
    );
  }

  CustomTextFormField sizeForm() {
    return CustomTextFormField(
      label: 'Size Of Product',
      icon: Icons.person,
      textInputType: TextInputType.text,
      obscure: false,
      validat: (String value) {
        return value.length < 2 ? 'please enter name of product' : null;
      },
      controller: _size,
    );
  }

  CustomTextFormField taxFrom() {
    return CustomTextFormField(
      label: 'Tax',
      icon: Icons.monetization_on,
      textInputType: TextInputType.text,
      obscure: false,
      validat: (String value) {
        return value.length < 2 ? 'please enter name of product' : null;
      },
      controller: _tax,
    );
  }

  CustomTextFormField priceForm() {
    return CustomTextFormField(
      label: 'price',
      icon: Icons.monetization_on,
      textInputType: TextInputType.number,
      obscure: false,
      validat: (String value) {
        return value.length < 2 ? 'please enter name of product' : null;
      },
      controller: _price,
    );
  }

  CustomTextFormField descriptionForm() {
    return CustomTextFormField(
      label: 'Description',
      icon: Icons.description,
      textInputType: TextInputType.text,
      obscure: false,
      validat: (String value) {
        return value.length < 2 ? 'please enter description of product' : null;
      },
      controller: _descirption,
    );
  }

  CustomTextFormField nameForm() {
    return CustomTextFormField(
      label: 'name',
      icon: Icons.description,
      textInputType: TextInputType.text,
      obscure: false,
      validat: (String value) {
        return value.length < 2 ? 'please enter name of product' : null;
      },
      controller: _name,
    );
  }

  CustomTextFormField adminForm() {
    return CustomTextFormField(
      label: 'admin name',
      icon: Icons.person,
      textInputType: TextInputType.text,
      obscure: false,
      validat: (String value) {
        return value.length < 2 ? 'please enter name of product' : null;
      },
      controller: _adminName,
    );
  }
}

abstract class Add {
  void addToStore(ProductModel product);
}

class AddProductToFireStore implements Add {
  final Firestore _firestore = Firestore.instance;
  @override
  void addToStore(ProductModel product) {
    _firestore.collection(ProductStrings.kCollection).add({
      ProductStrings.kAdminName: product.padminName,
      ProductStrings.kName: product.pname,
      ProductStrings.kDescirption: product.pdescirption,
      ProductStrings.kPrice: product.pprice,
      ProductStrings.kTax: product.ptax,
      ProductStrings.kSize: product.psize,
      ProductStrings.kimage: product.pimage,
    });
  }
}
