import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class RegisterState extends Equatable{
  @override
  List<Object> get props => [];
}

class RegisterInitial extends RegisterState {
  @override
  String toString() => 'RegisterInitial';
}

class RegisterLoading extends RegisterState {
  @override
  String toString() => 'RegisterLoading';
}

class RegisterFailure extends RegisterState {
  final String error;

  RegisterFailure({@required this.error});

  @override
  String toString() => 'RegisterFailure { error: $error }';

  List<Object> get props => [error];
}

class RegisterSuccess extends RegisterState {
  @override
  String toString() => 'RegisterSuccess';
}