class Loan {
  int? id;
  final int quantity;
  final int member;
  final int bookId;
  bool isReturned;
  String? returnedAt;
  String? state;

  Loan({
    id,
    required this.quantity,
    required this.member,
    required this.bookId,
    this.isReturned = false,
    this.returnedAt = "",
    this.state = "intact",
  });

  Map<String, dynamic> toMap() {
    return {
      'quantity': quantity,
      'member': member,
      'returnedAt': returnedAt,
      'state': state,
      'isReturned': isReturned,
      'bookId': bookId,
    };
  }

  static Loan fromMap(Map<String, dynamic> json) {
    return Loan(
        id: json['id'],
        quantity: json['quantity'],
        member: json['member'],
        returnedAt: json['returnedAt'],
        state: json['state'],
        bookId: json['bookId'],
        isReturned: json['isReturned']);
  }
}
