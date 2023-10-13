import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helpershop/arxitecture/product_cubit/product_cubit.dart';
import 'package:helpershop/data/Repos/Product_Repo.dart';

import '../main.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
        providers: [
          RepositoryProvider(create: (context) => ProductRepo()),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => ProductCubit(),
            ),
          ],
          child: MyApp(),
        ));
  }
}
