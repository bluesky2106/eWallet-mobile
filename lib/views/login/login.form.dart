import 'package:eWallet/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eWallet/blocs/login/login.dart';
import 'package:eWallet/views/common/common.dart';

class LoginForm extends StatefulWidget {
  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Widget _buildTop() {
    return Column(
      children: [
        SizedBox(
          height: 150.0,
          child: Image.asset('assets/itv.jpg'),
        ),
        SizedBox(height: 15.0),
        Text(
          'Sign in to your account',
          style: TextStyle(fontSize: 25.0, color: Colors.blueGrey),
        ),
        SizedBox(height: 50.0),
      ],
    );
  }

  Widget _buildEmailAndPwd() {
    return Column(
      children: [
        InputWidget(title: "Email", controller: _emailController),
        SizedBox(height: 15.0),
        InputWidget(title: "Password", isPwd: true, controller: _passwordController),
        SizedBox(height: 25.0),
      ],
    );
  }

  Widget _buildForgotPwd() {
    return Column(
      children: [
        InkWell(
          child: Text(
            'Forgot Password',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w700, color: Colors.blue),
          ),
          onTap: () {

          },
        ),
        SizedBox(height: 20.0,)
      ],
    );
  }

  Widget _buildLoginBtn() {
    return Column(
      children: [
        ButtonWidget(
          key: Key('BtnLogin'),
          onPressed: _handleLoginButtonPress,
          title: 'Login',
        ),
        SizedBox(height: 20),
      ],
    );
  }

  Widget _buildBottom() {
    return InkWell(
      child: RichText(
        text: TextSpan(
          text: 'No account yet? ',
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w700,color: Colors.blue),
          children: <TextSpan>[
            TextSpan(
              text: 'Register!',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w700, color: Colors.purple),
            ),
          ],
        ),
      ),
      onTap: _handleRegister,
    );
  }

  void _handleRegister() {
    Navigator.pushNamed(context, Router.registerDir);
  }

  void _handleLoginButtonPress() {
    BlocProvider.of<LoginBloc>(context).add(
      LoginButtonPressed(
        email: _emailController.text,
        password: _passwordController.text,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginFailure) {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text('${state.error}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildTop(),
                      _buildEmailAndPwd(),
                      _buildForgotPwd(),
                      _buildLoginBtn(),
                      _buildBottom(),
                    ],
                  ),
                ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}