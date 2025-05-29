part of 'cart_bloc.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartUpdated extends CartState {
  final int itemsCount;

  const CartUpdated({required this.itemsCount});

  @override
  List<Object> get props => [itemsCount];
}

class CartLoaded extends CartState {
  final List<CartItem> cartItems;

  const CartLoaded({required this.cartItems});

  @override
  List<Object> get props => [cartItems];
}

class CartError extends CartState {
  final String message;

  const CartError({required this.message});

  @override
  List<Object> get props => [message];
}