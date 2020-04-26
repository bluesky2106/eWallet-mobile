class UserLoginResp {
  // variables
  String token;
  String expired;

  Map<String, dynamic> toMap() {
    return {
      'Token': token,
      'Expired': expired,
    };
  }

  UserLoginResp.fromMap(Map<String, dynamic> map) {
    token = map['Token'] as String;
    expired = map['Expired'] as String;
  }

  @override
  String toString() {
    return ('UserLoginResp(token: ${this.token} - expired: ${this.expired})');
  }
}

