import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:eWallet/models/user.dart';

abstract class AuthenticationState extends Equatable {
  @override
  List<Object> get props => [];
}

// uninitialized : waiting to see if the user is authenticated or not on app start.
class AuthenticationUninitialized extends AuthenticationState {
  @override
  String toString() => 'AuthenticationUninitialized';
}

// authenticated : successfully authenticated
class AuthenticationAuthenticated extends AuthenticationState {
  final User user;

  AuthenticationAuthenticated({@required this.user});

  @override
  String toString() => 'AuthenticationAuthenticated $user';

  @override
  List<Object> get props => [user];
}

// unauthenticated : not authenticated
class AuthenticationUnauthenticated extends AuthenticationState {
  @override
  String toString() => 'AuthenticationUnauthenticated';
}

// error - authenticate failed
class AuthenticationError extends AuthenticationState {
  @override
  String toString() => 'AuthenticationError';
}