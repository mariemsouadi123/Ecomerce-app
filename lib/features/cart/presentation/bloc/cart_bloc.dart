// features/cart/presentation/bloc/cart_bloc.dart
import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/features/cart/domain/usecases/remove_from_cart.dart';
import 'package:equatable/equatable.dart';
import 'package:ecommerce_app/core/errors/failures.dart';
import 'package:ecommerce_app/features/cart/domain/entities/cart_item.dart';
import 'package:ecommerce_app/features/cart/domain/usecases/add_to_cart.dart';
import 'package:ecommerce_app/features/cart/domain/usecases/get_cart_items.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final AddToCart addToCart;
  final GetCartItems getCartItems;
  final RemoveFromCart removeFromCart;

  CartBloc({
    required this.addToCart,
    required this.getCartItems,
    required this.removeFromCart,
  }) : super(CartInitial()) {
    on<AddItemToCart>(_onAddItemToCart);
    on<RemoveItemFromCart>(_onRemoveItemFromCart);
    on<LoadCartItems>(_onLoadCartItems);
  }

  Future<void> _onAddItemToCart(
    AddItemToCart event,
    Emitter<CartState> emit,
  ) async {
    emit(CartLoading());
    final result = await addToCart(event.item);
    result.fold(
      (failure) => emit(CartError(_mapFailureToMessage(failure))),
      (_) => add(LoadCartItems()),
    );
  }

  Future<void> _onRemoveItemFromCart(
    RemoveItemFromCart event,
    Emitter<CartState> emit,
  ) async {
    emit(CartLoading());
    final result = await removeFromCart(event.productId);
    result.fold(
      (failure) => emit(CartError(_mapFailureToMessage(failure))),
      (_) => add(LoadCartItems()),
    );
  }

  Future<void> _onLoadCartItems(
    LoadCartItems event,
    Emitter<CartState> emit,
  ) async {
    emit(CartLoading());
    final result = await getCartItems();
    result.fold(
      (failure) => emit(CartError(_mapFailureToMessage(failure))),
      (items) => emit(CartLoaded(items)),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case CacheFailure:
        return 'Cache Error: ${failure.message}';
      default:
        return 'Unexpected Error';
    }
  }
}