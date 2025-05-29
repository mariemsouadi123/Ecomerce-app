import 'package:ecommerce_app/features/ecommerce/presentation/bloc/cart_bloc.dart/cart_bloc.dart';
import 'package:ecommerce_app/features/ecommerce/presentation/bloc/favorite_bloc.dart/favorites_bloc.dart';
import 'package:ecommerce_app/features/ecommerce/presentation/pages/favorites_page.dart';
import 'package:ecommerce_app/features/ecommerce/presentation/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce_app/features/ecommerce/presentation/pages/cart_page.dart';
import 'package:ecommerce_app/features/ecommerce/presentation/bloc/product_bloc/product_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const _HomeContent(), // Contenu principal de la page d'accueil
    const FavoritesPage(), // Page des favoris
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _currentIndex == 0
          ? AppBar(
              title: const Text('Tech Haven',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              centerTitle: true,
              actions: [
                IconButton(
                  icon: BlocBuilder<CartBloc, CartState>(
                    builder: (context, state) {
                      final count = state is CartUpdated ? state.itemsCount : 0;
                      return Badge(
                        label: Text('$count'),
                        child: const Icon(Icons.shopping_cart),
                      );
                    },
                  ),
                  onPressed: () {
                    context.read<CartBloc>().add(LoadCartItems());
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const CartPage()),
                    );
                  },
                ),
              ],
            )
          : AppBar(
              title: const Text('Favoris'),
              centerTitle: true,
            ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          if (index == 1) {
            // Charger les favoris quand on clique sur l'onglet
            context.read<FavoritesBloc>().add(LoadFavorites());
          }
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Accueil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favoris',
          ),
        ],
        selectedItemColor: Colors.blue.shade800,
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}

class _HomeContent extends StatelessWidget {
  const _HomeContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        if (state is ProductLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ProductError) {
          return Center(child: Text(state.message));
        } else if (state is ProductLoaded) {
          return Column(
            children: [
              // Section de recherche
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Rechercher des produits...',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),
              // Liste des produits
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.all(8.0),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.75,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                  ),
                  itemCount: state.products.length,
                  itemBuilder: (context, index) {
                    return ProductCard(product: state.products[index]);
                  },
                ),
              ),
            ],
          );
        }
        return const Center(child: Text('Aucun produit disponible'));
      },
    );
  }
}