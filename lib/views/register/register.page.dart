import 'package:eWallet/views/register/register.form.dart';
import 'package:flutter/material.dart';
import 'package:eWallet/repos/user.repo.dart';

class RegisterPage extends StatelessWidget {
  final UserRepository userRepository;

  RegisterPage({Key key, @required this.userRepository})
      : assert(userRepository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RegisterForm(),
    );
  }
}