import 'package:flutter/material.dart';

const DEFAULT_HEIGHT = 50.0;

class InputWidget extends StatefulWidget {
  final String title;
  final bool isPwd;

  const InputWidget({Key key,  @required this.title, this.isPwd = false}) : super(key: key);

  @override
  _InputWidgetState createState() => _InputWidgetState();
}

class _InputWidgetState extends State<InputWidget> {
  // state
  bool _isShowPwd;

  @override
  void initState() {
    _isShowPwd = false;
    super.initState();
  }

  final OutlineInputBorder outlineBorder = OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blue, width: 1.3),
    borderRadius: BorderRadius.all(Radius.circular(24)),
  );

  _showPwd() {
    if (widget.isPwd) {
      return InkWell(
        onTap: () {
          setState(() {
            _isShowPwd = !_isShowPwd;
          });
        },
        child: _isShowPwd
            ? Icon(Icons.visibility_off, color: Colors.blue, size: DEFAULT_HEIGHT * 3/4,)
            : Icon(Icons.visibility, color: Colors.grey, size: DEFAULT_HEIGHT * 3/4,),
      );
    }
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: DEFAULT_HEIGHT,
      child: Stack(
        children: [
          TextFormField(
            key: Key(widget.title),
            obscureText: widget.isPwd && !_isShowPwd,
            style: TextStyle(fontSize: 20.0),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              border: InputBorder.none,
              errorBorder: outlineBorder,
              focusedErrorBorder: outlineBorder,
              focusedBorder: outlineBorder,
              enabledBorder: outlineBorder,
              labelText: widget.title,
              labelStyle: TextStyle(color: Colors.blue),
            ),
            keyboardType: TextInputType.emailAddress,
          ),

          Positioned(
            bottom: DEFAULT_HEIGHT * 1 / 8,
            right: 10,
            child: _showPwd(),
          ),
        ],
      ),
    );
  }
}