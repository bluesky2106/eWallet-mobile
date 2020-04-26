class Resp {
  dynamic result;
  dynamic error;

  Map<String, dynamic> toMap() {
    return {
      'Result': result,
      'Error': error,
    };
  }

  Resp.fromMap(Map<String, dynamic> map) {
    result = map['Result'];
    error = map['Error'];
  }

  @override
  String toString() {
    return ('Resp(result: ${this.result} - error: ${this.error})');
  }
}