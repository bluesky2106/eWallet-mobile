import 'dart:convert';
import 'package:flutter/services.dart';

enum Page { Wallet, Event, Program, Setting }

enum Environment { Local, Dev, Prod }

class Config {
  // Below codes are used to create a singleton instance of API class
  static final _singleton = new Config._internal();

  Config._internal();

  factory Config() {
    return _singleton;
  }

  // Variables
  String baseURL;
  String infuraURL;
  String infuraWsURL;
  String blockCypherURL;
  String etherTxURL;
  String btcTxURL;

  void setEnvironment(Environment env) {
    switch (env) {
      case Environment.Local:
        _parseJson("assets/config-local.json");
        break;
      case Environment.Dev:
        _parseJson("assets/config-dev.json");
        break;
      case Environment.Prod:
        _parseJson("assets/config-prod.json");
        break;
    }
  }

  void _parseJson(String path) async {
    String data = await rootBundle.loadString(path);
    final jsonResult = json.decode(data);

    baseURL = jsonResult['baseURL'];
    infuraURL = jsonResult['infuraURL'];
    infuraWsURL = jsonResult['infuraWsURL'];
    blockCypherURL = jsonResult['blockCypherURL'];
    btcTxURL = jsonResult['btcTxURL'];
  }

  @override
  String toString() {
    return 'Config {baseURL: $baseURL, infuraURL: $infuraURL, infuraWsURL: $infuraWsURL, blockCypherURL: $blockCypherURL, btcTxURL: $btcTxURL}';
  }
}