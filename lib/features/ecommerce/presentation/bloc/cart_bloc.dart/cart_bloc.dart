import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/features/ecommerce/domain/entities/cart_item.dart';
import 'package:ecommerce_app/features/ecommerce/domain/entities/product.dart';
import 'package:ecommerce_app/features/ecommerce/domain/usecases/add_to_cart.dart';
import 'package:ecommerce_app/features/ecommerce/domain/usecases/get_cart_items_count.dart';
import 'package:ecommerce_app/features/ecommerce/domain/usecases/get_class_items.dart';
import 'package:equatable/equatable.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final AddToCart addToCart;
  final GetCartItemsCount getCartItemsCount;
  final GetCartItems getCartItems;

  CartBloc({
    required this.addToCart,
    required this.getCartItemsCount,
    required this.getCartItems,
  }) : super(CartInitial()) {
    on<AddProductToCart>(_onAddProductToCart);
    on<LoadCartItemsCount>(_onLoadCartItemsCount);
    on<LoadCartItems>(_onLoadCartItems); // Handler ajouté
  }

  Future<void> _onAddProductToCart(
    AddProductToCart event,
    Emitter<CartState> emit,
  ) async {
    try {
      await addToCart(event.product);
      final count = await getCartItemsCount();
      emit(CartUpdated(itemsCount: count));
    } catch (e) {
      emit(CartError(message: e.toString()));
    }
  }

  Future<void> _onLoadCartItemsCount(
    LoadCartItemsCount event,
    Emitter<CartState> emit,
  ) async {
    try {
      final count = await getCartItemsCount();
      emit(CartUpdated(itemsCount: count));
    } catch (e) {
      emit(CartError(message: e.toString()));
    }
  }

  Future<void> _onLoadCartItems(
    LoadCartItems event,
    Emitter<CartState> emit,
  ) async {
    emit(CartLoading());
    try {
      final items = await getCartItems();
      emit(CartLoaded(cartItems: items));
    } catch (e) {
      emit(CartError(message: e.toString()));
    }
  }
}