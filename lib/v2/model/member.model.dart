class Member {
  int id;
  final String firstName;
  final String lastName;
  final int number;
  final int cinNumber;

  Member({
    this.id = 0,
    required this.firstName,
    required this.lastName,
    required this.number,
    required this.cinNumber,
  });

  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'number': number,
      'cinNumber': cinNumber,
    };
  }

  static Member fromMap(Map<String, dynamic> json) {
    return Member(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      number: json['number'],
      cinNumber: json['cinNumber'],
    );
  }
}
