class User {
  String firstName;
  String lastName;
  String email;
  String organisation;
  String phoneNumber;
  String address;
  String id;
  // String agentStatus;
  // String password;

  User({this.address, this.email, this.firstName, this.lastName, this.organisation, this.phoneNumber, this.id});

  factory User.fromJson(Map json) {
    return User(
      address: json['address'] ?? '',
      email: json['email'] ?? '',
      firstName: json['first_name'] ?? '',
      id: json['id'] ?? '',
      lastName: json['last_name'] ?? '',
      organisation: json['organisation'] ?? '',
      phoneNumber: json['phone_no'] ?? ''
    );
  }
}