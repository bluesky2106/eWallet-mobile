import 'package:meta/meta.dart';

class User {
  int id;
  String fullName;
  String email;

  User({this.id,
    this.fullName,
    @required this.email,
  });

  Map<String, dynamic> toMap() {
    return {
      'ID': id,
      'FullName': fullName,
      'Email': email,
    };
  }

  User.fromMap(Map<String, dynamic> map) {
    id = map['ID'] as int;
    fullName = map['FullName'] as String;
    email = map['Email'] as String;
  }

  @override
  String toString() {
    return ('id: ${this.id} - full name: ${this.fullName} - email: ${this.email}');
  }
}