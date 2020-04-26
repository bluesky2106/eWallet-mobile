import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:eWallet/models/user.dart';
import 'package:eWallet/repos/user.repo.dart';
import 'package:eWallet/blocs/auth/auth.events.dart';
import 'package:eWallet/blocs/auth/auth.states.dart';

class AuthBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository userRepository;

  AuthBloc({@required this.userRepository}) : assert(userRepository != null);

  @override
  AuthenticationState get initialState => AuthenticationUninitialized();

  @override
  Stream<AuthenticationState> mapEventToState(AuthenticationEvent event) async* {
    if (event is AppStarted) {
      User user = await userRepository.currentUser();
      if (user != null) {
        yield AuthenticationAuthenticated(user: user);
      } else {
        yield AuthenticationUnauthenticated();
      }
    } else if (event is LoggedIn) {
      yield AuthenticationAuthenticated(user: event.user);
    } else if (event is LoggedOut) {
      bool result = await userRepository.logout();
      if (result) {
        yield AuthenticationUnauthenticated();
      } else {
        yield AuthenticationError();
      }
    }
  }
}
