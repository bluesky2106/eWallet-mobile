import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eWallet/blocs/auth/auth.dart';
import 'package:eWallet/repos/user.repo.dart';
import 'package:eWallet/views/home/home.page.dart';
import 'package:eWallet/views/login/login.page.dart';
import 'package:eWallet/views/loading.indicator.dart';
import 'package:eWallet/views/splash.page.dart';

class Root extends StatelessWidget {
  final UserRepository userRepository;

  Root({Key key, @required this.userRepository})
      : assert(userRepository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    // userRepository.db.deleteAllUsers();
    return BlocBuilder<AuthBloc, AuthenticationState>(
      builder: (context, state) {
        if (state is AuthenticationAuthenticated) {
          return Homepage();
        }
        if (state is AuthenticationUnauthenticated) {
          return LoginPage(userRepository: userRepository);
        }
        if (state is AuthenticationLoading) {
          return LoadingIndicator();
        }
        return SplashPage();
      },
    );
  }
}