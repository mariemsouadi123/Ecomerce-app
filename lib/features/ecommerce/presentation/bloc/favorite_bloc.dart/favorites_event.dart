part of 'favorites_bloc.dart';

abstract class FavoritesEvent extends Equatable {
  const FavoritesEvent();
  @override
  List<Object> get props => [];
}
class AddToFavorites extends FavoritesEvent {
  final Product product;

  const AddToFavorites(this.product);

  @override
  List<Object> get props => [product];
}

class RemoveFromFavorites extends FavoritesEvent {
  final Product product;

  const RemoveFromFavorites(this.product);

  @override
  List<Object> get props => [product];
}

class LoadFavorites extends FavoritesEvent {}