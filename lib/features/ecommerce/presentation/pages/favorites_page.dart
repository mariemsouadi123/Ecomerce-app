import 'package:ecommerce_app/features/ecommerce/domain/entities/product.dart';
import 'package:ecommerce_app/features/ecommerce/presentation/bloc/favorite_bloc.dart/favorites_bloc.dart';
import 'package:ecommerce_app/features/ecommerce/presentation/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesBloc, FavoritesState>(
      builder: (context, state) {
        if (state is FavoritesUpdated) {
          if (state.favorites.isEmpty) {
            return const Center(
              child: Text('Aucun favoris pour le moment'),
            );
          }

          return GridView.builder(
            padding: const EdgeInsets.all(8.0),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.75,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
            ),
            itemCount: state.favorites.length,
            itemBuilder: (context, index) {
              return ProductCard(product: state.favorites[index]);
            },
          );
        }
        return const Center(child: Text('Chargement des favoris...'));
      },
    );
  }
}