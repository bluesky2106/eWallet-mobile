import 'dart:convert';
import 'package:eWallet/models/response.dart';
import 'package:meta/meta.dart';
import 'package:eWallet/repos/api/api.dart';
import 'package:eWallet/repos/db/db.dart';
import 'package:eWallet/models/user.dart';
import 'package:eWallet/models/user.login.dart';

class UserRepository {
  final DB db;
  final API api;

  UserRepository({@required this.db, @required this.api}) : assert(db != null), assert(api != null);
  
  /// Auth [email], [password]
  ///
  /// Response token if success. Otherwise throw error.
  Future<User> authenticate({
    @required String email,
    @required String password,
  }) async {

    var response = await api.auth(email, password);
    if (response.statusCode != 200) {
      return null;
    }

    UserLoginResp loginResp = UserLoginResp.fromMap(json.decode(response.data));
    String token = loginResp.token;
    if (token.isNotEmpty) {
      response = await api.userInfo(token);
      Resp resp = Resp.fromMap(json.decode(response.data));
      User user = User.fromMap(json.decode(resp.result));
      this.db.insertUser(user);

      // save to keystore
      // await utils.saveSecureData(CONST.JWT_TOKEN, token);
      // await utils.saveSecureData(CONST.CRYPTO_PASSPHASE, 'Toko1n');
      return user;
    }
    
    return null;
  }

  Future<void> deleteToken() async {
    /// delete from keystore/keychain
    await Future.delayed(Duration(seconds: 1));
    return;
  }

  Future<void> persistToken(String token) async {
    /// write to keystore/keychain
    await Future.delayed(Duration(seconds: 1));
    return;
  }

  Future<bool> hasToken() async {
    /// read from keystore/keychain
    await Future.delayed(Duration(seconds: 1));
    return false;
  }

  /// select current [user] inside databse.
  ///
  /// return user object if any.
  Future<User> currentUser() async {
    return await this.db.selectUser();
  }

  /// clean [user] session
  /// 
  /// return true.
  Future<bool> logout() async {
    await this.db.deleteAllUsers();
    return true;
  }
}