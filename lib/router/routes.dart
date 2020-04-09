import 'package:eWallet/screens/homepage.dart';
import 'package:eWallet/screens/login.dart';
import 'package:eWallet/screens/register.dart';
import 'package:flutter/material.dart';

Map<String,  Widget Function(BuildContext context)> routes = {
  '/': (context) => HomepageScreen(),
  '/login': (context) => LoginScreen(),
  '/register': (context) => RegisterScreen(),
};