import 'abstract_product_model.dart';

class ProductModel extends AbstractProductModel {
  final String padminName, pname, pdescirption, pprice, ptax, psize, pimage;
  int quantity; 
  ProductModel(
    this.padminName,
    this.pname,
    this.pdescirption,
    this.pprice,
    this.ptax,
    this.psize,
    this.pimage,
    this.quantity,
  );
}
