import 'package:equatable/equatable.dart';
import 'package:eWallet/models/user.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

// AppStarted : event to notify the bloc that it needs to check if the user is currently authenticated or not
class AppStarted extends AuthenticationEvent {
  @override
  String toString() => 'AppStarted';
}

// LoggedIn : event to notify the bloc that the user has successfully logged in.
class LoggedIn extends AuthenticationEvent {
  final User user;

  LoggedIn({this.user});

  @override
  String toString() => 'LoggedIn: ${user.fullName}';

  @override
  List<Object> get props => [user];
}

// LoggedOut : event to notify the bloc that the user has successfully logged out.
class LoggedOut extends AuthenticationEvent {
  @override
  String toString() => 'LoggedOut';
}
