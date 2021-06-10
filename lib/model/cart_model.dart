class CartModel {
  final String image;
  final String name;
  int quantity;
  final double price;
  final String id;

  factory CartModel.fromMap(Map<String, dynamic> map) {
    return new CartModel(
      image: map['image'] as String,
      name: map['name'] as String,
      quantity: map['quantity'] as int,
      price: map['price'] as double,
      id: map['id'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'image': this.image,
      'name': this.name,
      'quantity': this.quantity,
      'price': this.price,
      'id': this.id,
    } as Map<String, dynamic>;
  }

  CartModel(
      {required this.image,
      required this.price,
      required this.name,
      required this.quantity,
      required this.id});
}
