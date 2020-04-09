import 'package:eWallet/widgets/button_widget.dart';
import 'package:eWallet/widgets/input_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();  
  TapGestureRecognizer _tapTermOfUseGestureRecognizer, _tapPrivacyPolicyGestureRecognizer;

  bool _isCheck;

  @override
  void initState() {  
    _isCheck = false;
    super.initState();

    _tapTermOfUseGestureRecognizer = TapGestureRecognizer()
    ..onTap = () {
      // Navigator.pushNamed(context, ScreenRouter.TNC);
    };

    _tapPrivacyPolicyGestureRecognizer = TapGestureRecognizer()
    ..onTap = () {
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
        InputWidget(title: "Name"),
        SizedBox(height: 15.0),
        InputWidget(title: "Email"),
        SizedBox(height: 15.0),
        InputWidget(title: "Password", isPwd: true),
        SizedBox(height: 15.0),
        InputWidget(title: "Confirm Password", isPwd: true),
        SizedBox(height: 5.0,),
      ],
    );
  }

  Widget _buildRegisterBtn() {
    return Column(
      children: [
        ButtonWidget(
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

  void _handleBackToLogin() {
    Navigator.pushNamed(context, '/login');
  }

  void _handleRegister() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    print(_formKey);

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 10.0),
          child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildTop(),
                  _buildRegisterInfo(),
                  _buildPrivacyPolicy(),
                  _buildRegisterBtn(),
                  _buildBottom(),
                ],
              ),
            ),
        ),
      ),
    );
  }
}