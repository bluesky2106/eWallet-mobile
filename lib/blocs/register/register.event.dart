import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();
}

class RegisterButtonPressed extends RegisterEvent {
  final String fullName;
  final String email;
  final String password;
  final String confirmPassword;
  final bool checkTermAndAgreement;

  const RegisterButtonPressed({
    @required this.fullName,
    @required this.email,
    @required this.password,
    @required this.confirmPassword,
    @required this.checkTermAndAgreement,
  });

  @override
  List<Object> get props => [fullName, email, password, confirmPassword, checkTermAndAgreement];

  @override
  String toString() =>
      'RegisterButtonPressed { fullName: $fullName, email: $email, password: $password, confirmPassword: $confirmPassword, checkTermAndAgreement: $checkTermAndAgreement }';
}