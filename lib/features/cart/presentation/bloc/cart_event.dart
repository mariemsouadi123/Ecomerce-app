part of 'cart_bloc.dart';

sealed class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class AddItemToCart extends CartEvent {
  final CartItem item;

  const AddItemToCart(this.item);

  @override
  List<Object> get props => [item];
}

class RemoveItemFromCart extends CartEvent {
  final String productId;

  const RemoveItemFromCart(this.productId);

  @override
  List<Object> get props => [productId];
}

class LoadCartItems extends CartEvent {}