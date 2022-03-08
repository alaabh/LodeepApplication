class LoanedBook {
  int id;
  String firstName;
  String lastName;
  int number;
  int cinNumber;
  String name;
  int bookId;
  int quantity;

  LoanedBook({
    this.id = 0,
    required this.firstName,
    required this.lastName,
    required this.number,
    required this.cinNumber,
    required this.name,
    required this.bookId,
    required this.quantity,
  });

  static LoanedBook fromMap(Map<String, dynamic> json) {
    return LoanedBook(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      number: json['number'],
      cinNumber: json['cinNumber'],
      name: json['name'],
      bookId: json['bookId'],
      quantity: json['quantity'],
    );
  }
}
