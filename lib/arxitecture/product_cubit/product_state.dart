
import 'package:helpershop/data/model.dart';

abstract class ProductState {}

class InitialProductState extends ProductState {}

class LoadProductProgress extends ProductState {}

class LoadProductSuccess extends ProductState {
  LoadProductSuccess({required this.product});

  final List<ProductModel> product;
}

class LoadNProductFailure extends ProductState {}
