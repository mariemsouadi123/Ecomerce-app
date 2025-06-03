import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce_app/injection_container.dart';
import 'package:ecommerce_app/features/cart/presentation/bloc/cart_bloc.dart';

class CartProviderWidget extends StatelessWidget {
  final Widget child;

  const CartProviderWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<CartBloc>()..add(LoadCartItems()),
      child: child,
    );
  }
}