
import 'package:helpershop/data/local/local_db.dart';
import 'package:helpershop/data/model.dart';

class ProductRepo {
  Future<ProductModel> addProduct(
      {required ProductModel productModel}) =>
      LocalDatabase.addProduct(productModel);

  Future<List<ProductModel>> getAllProduct() =>
      LocalDatabase.getAllProducts();
}
