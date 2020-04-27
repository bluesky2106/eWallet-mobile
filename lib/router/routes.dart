import 'package:eWallet/views/homepage.dart';
import 'package:eWallet/views/login/login.page.dart';
import 'package:eWallet/views/register.dart';
import 'package:flutter/material.dart';
import 'package:eWallet/repos/user.repo.dart';

class Router {
  final UserRepository userRepository;

  Router({@required this.userRepository});

  Map<String,  Widget Function(BuildContext context)> routes() {
    return {
      '/home': (context) => Homepage(),
      '/login': (context) => LoginPage(userRepository: userRepository),
      '/register': (context) => RegisterPage(),
    };
  } 
}
