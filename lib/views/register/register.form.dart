import 'package:eWallet/views/loading.indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/gestures.dart';
import 'package:eWallet/blocs/register/register.dart';
import 'package:eWallet/router/router.dart';
import 'package:eWallet/views/common/common.dart';

class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();  
  TapGestureRecognizer _tapTermOfUseGestureRecognizer, _tapPrivacyPolicyGestureRecognizer;
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isCheck;

  @override
  void initState() {  
    _isCheck = false;
    super.initState();

    _tapTermOfUseGestureRecognizer = TapGestureRecognizer()
    ..onTap = () {
      print("Tap term of use");
      // Navigator.pushNamed(context, ScreenRouter.TNC);
    };

    _tapPrivacyPolicyGestureRecognizer = TapGestureRecognizer()
    ..onTap = () {
      print("Tap policy");
      // Navigator.pushNamed(context, ScreenRouter.POLICY);
    };
  }

  Widget _buildTop() {
    return Column(
      children: [
          SizedBox(
          height: 150.0,
          child: Image.asset('assets/itv.jpg'),
        ),
        SizedBox(height: 15.0),
        Text(
          'Create your account',
          style: TextStyle(fontSize: 25.0, color: Colors.blueGrey),
        ),
        SizedBox(height: 30.0),
      ],
    );
  }

  Widget _buildRegisterInfo() {
    return Column(
      children: [
        InputWidget(title: "Name", controller: _fullNameController,),
        SizedBox(height: 15.0),
        InputWidget(title: "Email", controller: _emailController,),
        SizedBox(height: 15.0),
        InputWidget(title: "Password", isPwd: true, controller: _passwordController,),
        SizedBox(height: 15.0),
        InputWidget(title: "Confirm Password", isPwd: true, controller: _confirmPasswordController,),
        SizedBox(height: 5.0,),
      ],
    );
  }

  Widget _buildRegisterBtn(RegisterState state) {
    return Column(
      children: [
        (state == RegisterLoading())
        ? LoadingIndicator()
        : ButtonWidget(
          key: Key('BtnRegister'),
          onPressed: _handleRegister,
          title: 'Register',
        ),
        SizedBox(height: 20),
      ],
    );
  }

  Widget _buildPrivacyPolicy() {
    return Column(
      children: [
        Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Checkbox(
                value: _isCheck,
                materialTapTargetSize: MaterialTapTargetSize.padded,
                onChanged: (bool x) {
                  setState(() {
                    _isCheck = !_isCheck;    
                  });
                },
              ),
            ),
            Expanded(
              flex: 9,
              child: Padding(
                padding: const EdgeInsets.only(left: 5),
                child: RichText(
                  text: TextSpan(
                    text: 'I understand and agree to dantrisoft ',
                    style: TextStyle(fontSize: 13, color: Colors.black),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Term of Use', 
                        style: TextStyle(fontWeight: FontWeight.w500, color: Colors.purple, fontSize: 13),
                        recognizer: _tapTermOfUseGestureRecognizer,
                      ),
                      TextSpan(
                        text: ' and ', 
                        style: TextStyle(fontSize: 13, color: Colors.black),
                      ),
                      TextSpan(
                        text: 'Privacy Policy', 
                        style: TextStyle(fontWeight: FontWeight.w500, color: Colors.purple, fontSize: 13),
                        recognizer: _tapPrivacyPolicyGestureRecognizer,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 15),
      ],
    );    
  }

  Widget _buildBottom() {
    return InkWell(
      child: RichText(
        text: TextSpan(
          text: 'Back to ',
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w700,color: Colors.blue),
          children: <TextSpan>[
            TextSpan(
              text: 'Log in',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w700, color: Colors.purple),
            ),
          ],
        ),
      ),
      onTap: _handleBackToLogin,
    );
  }

  Widget _buildContent(RegisterState state) {
    if (state is RegisterSuccess) {
      return Container();
    }

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
              _buildRegisterInfo(),
              _buildPrivacyPolicy(),
              _buildRegisterBtn(state),
              _buildBottom(),
            ],
          ),
        ),
      ),
    );
  }

  void _handleBackToLogin() {
    Navigator.pushNamed(context, Router.loginDir);
  }

  void _handleRegister() {
    BlocProvider.of<RegisterBloc>(context).add(
      RegisterButtonPressed(
        fullName: _fullNameController.text,
        email: _emailController.text,
        password: _passwordController.text,
        confirmPassword: _confirmPasswordController.text,
        checkTermAndAgreement: _isCheck,
      ),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state is RegisterFailure) {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text('${state.error}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: BlocBuilder<RegisterBloc, RegisterState>(
        builder: (context, state) {
          return _buildContent(state);
        },
      ),
    );
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}