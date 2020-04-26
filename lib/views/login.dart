import 'package:flutter/material.dart';
import 'package:eWallet/views/common/common.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
        InputWidget(title: "Email"),
        SizedBox(height: 15.0),
        InputWidget(title: "Password", isPwd: true,),
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
          onPressed: () {
            
          },
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
    Navigator.pushNamed(context, '/register');
  }

  @override
  Widget build(BuildContext context) {
    print(_formKey);

    return Scaffold(
      body: Center(
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
      ),
    );
  }
}