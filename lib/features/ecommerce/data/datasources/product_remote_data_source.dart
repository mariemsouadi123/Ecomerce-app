import '../../domain/entities/product.dart';

abstract class ProductRemoteDataSource {
  Future<List<Product>> getProducts();
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  @override
  Future<List<Product>> getProducts() async {
    await Future.delayed(const Duration(seconds: 1));
    
    return [
      Product(
        id: 1,
        title: 'Samsung S16',
        price: 999.00,
        description: 'The most advanced iPhone camera system ever. Super Retina XDR display with ProMotion. A15 Bionic chip. Durable design.',
        category: 'Electronics',
        image: 'https://www.samsungtunisie.tn/11100-large_default/samsung-galaxy-a16-prix-tunisie.jpg',
        rating: Rating(rate: 4.5, count: 120),
      ),
      Product(
        id: 2,
        title: "samsung s23",
        price: 29.99,
        description: "Description for product 2",
        category: "Category 2",
        image: 'https://images.unsplash.com/photo-1590658268037-6bf12165a8df?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1000&q=80',
        rating: Rating(rate: 4.0, count: 80),
      ),
       Product(
        id: 3,
        title: "Iphone13 pro max ",
        price: 29.99,
        description: 'Industry-leading noise canceling with Dual Noise Sensor technology. Up to 30-hour battery life.',
        category: "Category 2",
        image: 'https://i5.walmartimages.com/seo/Restored-Apple-iPhone-13-Pro-Max-256GB-Sierra-Blue-LTE-Cellular-MLJD3VC-A-Refurbished_1a8217bb-9dab-4eeb-8aae-9b8ded70c372.36c80b6f47a30a23ef90f990dbb5cec0.jpeg',
        rating: Rating(rate: 4.0, count: 80),
      ),

       Product(
        id: 4,
        title: "Iphone 16 pro max  ",
        price: 29.99,
        description: 'Industry-leading noise canceling with Dual Noise Sensor technology. Up to 30-hour battery life.',
        category: "Category 2",
        image: 'https://itechstore.tn/9240-thickbox_default/iphone-16-pro-max-512gb-desert-titanium.jpg',
        rating: Rating(rate: 4.0, count: 80),
      ),
    ];
  }
}