
class Product {
  final String id;
  final String name;
  final String description;
  final String price;
  final String image;
  final String discount;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.image,
    required this.discount, 
    
  });
  factory Product.fromFirebase(Map<String, dynamic> data , String id) {
    return Product(
      id: id,
      name: data['name'] ?? 'N/A',
      description: data['description'] ?? "No description",
      price: data['price'] ?? '0.00',
      image: data['imageUrl'] ?? '',
      discount: data['discount'] ?? '0.00',
    );
  }
}
