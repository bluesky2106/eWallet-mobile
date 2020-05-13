import 'package:eWallet/views/common/button_widget.dart';
import 'package:eWallet/views/home/home.page.dart';
import 'package:eWallet/views/login/login.page.dart';
import 'package:eWallet/views/register/register.page.dart';
import 'package:eWallet/views/root.dart';
import 'package:flutter/material.dart';
import 'package:eWallet/repos/user.repo.dart';

class Router {
  static const rootDir = '/';
  static const homeDir = 'home';
  static const loginDir = 'login';
  static const registerDir = 'register';

  final UserRepository userRepository;

  Router({@required this.userRepository});

  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case rootDir:
        return MaterialPageRoute(
          builder: (context) => Root(userRepository: userRepository),
        );

      case homeDir:
        return MaterialPageRoute(
          builder: (context) => Homepage(),
        );

      case loginDir:
        return MaterialPageRoute(
          builder: (context) => LoginPage(userRepository: userRepository),
        );

      case registerDir:
        return MaterialPageRoute(
          builder: (context) => RegisterPage(userRepository: userRepository),
        );

      default:
        return unknownRoute(settings);
    }
  }

  Route<dynamic> unknownRoute(RouteSettings settings) {
    var unknownRouteText = "No such screen for ${settings.name}";

    return PageRouteBuilder(pageBuilder: (context, animation, secondaryAnimation) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(unknownRouteText),
          Padding(padding: const EdgeInsets.all(10.0)),
          ButtonWidget(
            title: 'Back',
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    });
  }
}
