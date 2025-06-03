// features/products/presentation/pages/product_list_page.dart
import 'package:ecommerce_app/features/cart/presentation/pages/cart_provider_widget.dart';
import 'package:ecommerce_app/features/products/presentation/widgets/product_cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce_app/features/cart/presentation/widgets/cart_badge.dart';
import 'package:ecommerce_app/injection_container.dart';
import 'package:ecommerce_app/features/products/presentation/bloc/product_bloc.dart';

class ProductListPage extends StatelessWidget {
  const ProductListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<ProductBloc>()..add(FetchProducts()),
        ),
      ],
      child: CartProviderWidget(
        child: Scaffold(
          appBar: AppBar(
            title: const Text('E-Commerce'),
            actions: const [
              CartBadge(),
            ],
          ),
          body: BlocBuilder<ProductBloc, ProductState>(
            builder: (context, state) {
              if (state is ProductInitial) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is ProductLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is ProductLoaded) {
                return GridView.builder(
                  padding: const EdgeInsets.all(8),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.7,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemCount: state.products.length,
                  itemBuilder: (context, index) {
                    return ProductCard(product: state.products[index]);
                  },
                );
              } else if (state is ProductError) {
                return Center(child: Text(state.message));
              }
              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }
}