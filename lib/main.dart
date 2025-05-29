import 'package:ecommerce_app/features/ecommerce/presentation/bloc/cart_bloc.dart/cart_bloc.dart';
import 'package:ecommerce_app/features/ecommerce/presentation/bloc/favorite_bloc.dart/favorites_bloc.dart';
import 'package:ecommerce_app/features/ecommerce/presentation/bloc/product_bloc/product_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'injection_container.dart' as di;
import 'features/ecommerce/presentation/pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => di.sl<ProductBloc>()..add(FetchProducts()),
        ),
        BlocProvider(
          create: (context) => di.sl<CartBloc>(),
        ),
            BlocProvider(create: (context) => FavoritesBloc()),

      ],
      child: MaterialApp(
        title: 'Tech Haven',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: const HomePage(),
      ),
    );
  }
}