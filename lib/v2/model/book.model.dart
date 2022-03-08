class Book {
  int? id;
  final String name;
  final int quantity;
  final String addedAt;
  final int category;

  Book({
    this.id,
    required this.name,
    required this.addedAt,
    required this.quantity,
    required this.category,
  });
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'addedAt': addedAt,
      'quantity': quantity,
      'category': category,
    };
  }

  static Book fromMap(Map<String, dynamic> json) {
    return Book(
        id: json['id'],
        name: json['name'],
        addedAt: json['addedAt'].toString(),
        quantity: json['quantity'],
        category: json['category']);
  }
}
