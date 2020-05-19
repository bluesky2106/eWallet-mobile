import 'package:eWallet/blocs/auth/auth.dart';
import 'package:eWallet/blocs/register/register.dart';
import 'package:eWallet/models/user.register.dart';
import 'package:eWallet/repos/user.repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final UserRepository userRepository;
  final AuthBloc authBloc;

  RegisterBloc({
    @required this.userRepository,
    @required this.authBloc,
  }) : assert(userRepository != null), assert(authBloc != null);

  @override
  RegisterState get initialState => RegisterInitial();

  @override
  Stream<RegisterState> mapEventToState(RegisterEvent event) async* {
    if (event is RegisterButtonPressed) {
      yield RegisterLoading();
      try {
        if (!event.checkTermAndAgreement) {
          yield RegisterFailure(error: "Terms and Agreement have NOT been checked !!!");

        } else {
          if (event.password != event.confirmPassword) {
            yield RegisterFailure(error: "Password and confirmed password are NOT matched");
          } else {
            UserRegisterReq req = new UserRegisterReq(
              fullName: event.fullName,
              email: event.email,
              password: event.password,
              confirmPassword: event.confirmPassword,
            );
            final user = await userRepository.register(req);
            if (user != null) {
              yield RegisterSuccess();
              authBloc.add(LoggedIn(user: user));
            } else {
              yield RegisterFailure(error: "Cannot register a new account");
            }
          }
        }        
      } catch (error) {
        print(error);
        yield RegisterFailure(error: error.toString());
      }
    }
  }
}