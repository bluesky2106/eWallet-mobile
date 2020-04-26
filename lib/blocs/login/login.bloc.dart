import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import 'package:eWallet/blocs/login/login.events.dart';
import 'package:eWallet/blocs/login/login.states.dart';
import 'package:eWallet/repos/user.repo.dart';
import 'package:eWallet/blocs/auth/auth.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepository;
  final AuthBloc authBloc;

  LoginBloc({
    @required this.userRepository,
    @required this.authBloc,
  })  : assert(userRepository != null),
        assert(authBloc != null);

  @override
  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginButtonPressed) {
      yield LoginLoading();

      try {
        final user = await userRepository.authenticate(
          email: event.email,
          password: event.password,
        );

        if (user != null) {
          yield LoginSuccess();
          authBloc.add(LoggedIn(user: user));
        } else {
          yield LoginFailure(error: 'User not found');
        }
      } catch (error) {
        yield LoginFailure(error: error.toString());
      }
    }
  }
}