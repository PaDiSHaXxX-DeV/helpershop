import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helpershop/arxitecture/product_cubit/product_cubit.dart';
import 'package:helpershop/arxitecture/product_cubit/product_state.dart';
import 'package:helpershop/data/Repos/Product_Repo.dart';
import 'package:helpershop/data/model.dart';
import 'package:helpershop/ui/widgets/productWidget.dart';

class RepoPage extends StatefulWidget {
  const RepoPage({super.key});

  @override
  State<RepoPage> createState() => _RepoPageState();
}

class _RepoPageState extends State<RepoPage> {
  String _scanBarcode = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Repo Page'),
        actions: [
          IconButton(
              onPressed: () async {
                await scanBarcodeNormal();
                var currentModel = ProductModel(code: _scanBarcode, count: '1');
                await  context
                    .read<ProductRepo>()
                    .addProduct(productModel: currentModel);
                Navigator.pop(context);
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: BlocConsumer<ProductCubit, ProductState>(
          listener: (context, state) {
            if (state is LoadProductProgress) {
              BlocProvider.of<ProductCubit>(context).getAllProducts();
            }
          },
          builder: (context, state) {
            if (state is LoadProductProgress) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is LoadProductSuccess) {
              return Column(
                children: [
                  Text(state.product.length.toString()),
                  ...List.generate(state.product.length, (index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: productsss(
                          code: state.product[index].code,
                          title: state.product[index].count,
                          desc: state.product[index].id.toString()),
                    );
                  }),
                ],
              );
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.15,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'You don`t have an product',
                  style: TextStyle(),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }
}
