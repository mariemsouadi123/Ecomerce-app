import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/features/ecommerce/domain/entities/product.dart';
import 'package:equatable/equatable.dart';

part 'favorites_event.dart';
part 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  FavoritesBloc() : super(FavoritesInitial()) {
    on<AddToFavorites>(_onAddToFavorites);
    on<RemoveFromFavorites>(_onRemoveFromFavorites);
    on<LoadFavorites>(_onLoadFavorites);
  }

  final List<Product> _favorites = [];

  void _onAddToFavorites(AddToFavorites event, Emitter<FavoritesState> emit) {
    if (!_favorites.contains(event.product)) {
      _favorites.add(event.product);
      emit(FavoritesUpdated(List.from(_favorites)));
    }
  }

  void _onRemoveFromFavorites(RemoveFromFavorites event, Emitter<FavoritesState> emit) {
    _favorites.remove(event.product);
    emit(FavoritesUpdated(List.from(_favorites)));
  }

  void _onLoadFavorites(LoadFavorites event, Emitter<FavoritesState> emit) {
    emit(FavoritesUpdated(List.from(_favorites)));
  }
}