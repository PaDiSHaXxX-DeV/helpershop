
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helpershop/arxitecture/product_cubit/product_state.dart';
import 'package:helpershop/data/local/local_db.dart';
import 'package:helpershop/data/model.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(InitialProductState()) {
    getAllProducts();
  }

  getAllProducts() {
    emit(LoadProductProgress());
    LocalDatabase.getAllProducts()
        .asStream()
        .listen((List<ProductModel> product) {
      emit(LoadProductSuccess(product: product));
    });
  }
}
