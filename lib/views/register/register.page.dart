import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eWallet/blocs/auth/auth.bloc.dart';
import 'package:eWallet/blocs/register/register.dart';
import 'package:eWallet/views/register/register.form.dart';
import 'package:eWallet/repos/user.repo.dart';

class RegisterPage extends StatelessWidget {
  final UserRepository userRepository;

  RegisterPage({Key key, @required this.userRepository})
      : assert(userRepository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) {
          return RegisterBloc(
            authBloc: BlocProvider.of<AuthBloc>(context),
            userRepository: userRepository,
          );
        },
        child: RegisterForm(),
      ),
    );
  }
}