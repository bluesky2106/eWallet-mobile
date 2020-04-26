import 'package:dio/dio.dart';
import 'package:eWallet/config/config.dart';

class API {
  // Below codes are used to create a singleton instance of API class
  static final API _singleton = new API._internal();

  factory API() {
    return _singleton;
  }

  API._internal() {
    _dio = Dio();
    _dio.options.baseUrl = Config().baseURL;
    _dio.options.connectTimeout = 5000; //5s
    _dio.options.receiveTimeout = 3000;
    _dio.options.responseType = ResponseType.json;

    _dio.interceptors.add(_logging());
  }

  // Variables
  Dio _dio;

  _logging() {
    return InterceptorsWrapper(
      onRequest: (RequestOptions options) async {
        print("DIO: ${options.path}");
        return options;
      }, onResponse: (Response response) async {
        print("DIO: ${response.request.path} ${response.statusCode} [OK]");
        return response;
      }, onError: (DioError e) async {
        print("DIO: ${e.request.path} [FAILED]\ndata: ${e.request.data}");
        return e;
      }
    );
  }

  /// Call auth with [email], [password]
  ///
  /// Response jwt if success. Otherwise throw error
  Future<Response> auth(String email, password) async {
    return await _dio.post("/auth/login", data: {"Email": email, "Password": password});
  }

  /// Call register with [email], [password], and [confirm password]
  ///
  /// Response user object if success
  Future<Response> register({String email, password, confirmPassword}) async {
    return await _dio.post("/auth/register", data: {
      "Email": email,
      "Password": password,
      "ConfirmPassword": confirmPassword
    });
  }

  /// get user info by [token]
  ///
  /// Response user object if any
  Future<Response> userInfo(String token) async {
    _dio.options.headers['Authorization'] = 'Bearer ' + token;
    return await _dio.get("/auth/user-profile");
  }

  /// [GET] /check-email-exist?email={email}
  ///
  /// params: [token], [email]
  /// result: true/false
  Future<Response> checkEmailExist(String email) async {
    return await _dio.get("/check-email-exist?email=$email");
  }

  /// [POST] /forgot-pwd
  ///
  /// params: [email], [resend]
  /// result: true/false
  Future<Response> sendAuthenticationCode(String email, bool resend) async {
    return await _dio
        .post("/forgot-pwd", data: {"Email": email, "Resend": resend});
  }

  /// [POST] /check-authentication-code
  ///
  /// params: [email], [code]
  /// result: true/false
  Future<Response> checkAuthenticationCode(String email, String authenticationCode) async {
    return await _dio.post("/check-authentication-code",
        data: {"Email": email, "Code": authenticationCode});
  }

  /// [POST] /reset-pwd
  ///
  /// params: [email], [code], [new password], [confirm new password]
  /// result: true/false
  Future<Response> resetPwd(String email, String authenticationCode, String newPassword, String confirmNewPassword) async {
    return await _dio.post("/reset-pwd", data: {
      "Email": email,
      "Code": authenticationCode,
      "NewPassword": newPassword,
      "ConfirmNewPassword": confirmNewPassword
    });
  }
}