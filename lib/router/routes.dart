import 'package:eWallet/views/view.dart';
import 'package:flutter/material.dart';

Map<String,  Widget Function(BuildContext context)> routes = {
  '/': (context) => Homepage(),
  '/login': (context) => LoginPage(),
  '/register': (context) => RegisterPage(),
};