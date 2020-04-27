
import 'package:meta/meta.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eWallet/router/routes.dart';
import 'package:eWallet/blocs/auth/auth.dart';
import 'package:eWallet/repos/user.repo.dart';
import 'package:eWallet/repos/db/db.dart';
import 'package:eWallet/repos/api/api.dart';
import 'package:eWallet/config/config.dart';
import 'package:eWallet/views/loading.indicator.dart';
import 'package:eWallet/views/splash.page.dart';
import 'package:eWallet/views/homepage.dart';
import 'package:eWallet/views/login/login.page.dart';

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onEvent(Bloc bloc, Object event) {
    print(event);
    super.onEvent(bloc, event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    print(transition);
    super.onTransition(bloc, transition);
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stackTrace) {
    print(error);
    super.onError(bloc, error, stackTrace);
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  BlocSupervisor.delegate = SimpleBlocDelegate();

  Config().setEnvironment(Environment.Local);
  final db = DB();
  await db.open();
  final api = API();

  final userRepository = UserRepository(db: db, api: api);
  runApp(
    BlocProvider<AuthBloc>(
      create: (context) {
        return AuthBloc(userRepository: userRepository)
          ..add(AppStarted());
      },
      child: MyApp(userRepository: userRepository),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({@required this.userRepository});
  
  final UserRepository userRepository;
  

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Router router = new Router(userRepository: userRepository);

    return MaterialApp(
      title: 'eWallet App',
      // initialRoute: '/login',
      routes: router.routes(),
      home: BlocBuilder<AuthBloc, AuthenticationState>(
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
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
