class Category {
  int id;
  String name;

  Category({
    this.id = 0,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
    };
  }

  static Category fromMap(Map<String, dynamic> json) {
    return Category(
      name: json['name'].toString(),
      id: json['id'],
    );
  }
}
