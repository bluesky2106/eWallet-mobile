class UserRegisterReq {
  // variables
  String fullName;
  String email;
  String password;
  String confirmPassword;

  UserRegisterReq({this.fullName, this.email, this.password, this.confirmPassword});

  Map<String, dynamic> toMap() {
    return {
      'FullName': fullName,
      'Email': email,
      'Password': password,
      'ConfirmPassword': confirmPassword,
    };
  }

  void fromMap(Map<String, dynamic> map) {
    fullName = map['FullName'] as String;
    email = map['Email'] as String;
    password = map['Password'] as String;
    confirmPassword = map['ConfirmPassword'] as String;
  }

  @override
  String toString() {
    return ('UserRegisterReq(fullName: ${this.fullName} - email: ${this.email})');
  }
}
