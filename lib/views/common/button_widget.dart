import 'package:flutter/material.dart';

const _DEFAULT_BACKGROUND_COLOR = Colors.blue;
const _DISABLED_BACKGROUND_COLOR = Colors.black45;
const _DEFAULT_HEIGHT = 45.0;
const _DEFAULT_BORDER_WIDTH = 1.0;
const _DEFAULT_BORDER_RADIUS = BorderRadius.all(Radius.circular(24.0));

class ButtonWidget extends StatefulWidget {
  final Function onPressed;
  final String title;
  final double height;
  

  const ButtonWidget({
    Key key,
    @required this.onPressed,
    @required this.title,
    this.height = _DEFAULT_HEIGHT,
  }) : super(key: key);

  @override
  _ButtonWidgetState createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = TextStyle(fontSize: 20.0);
    return Container(
      height: widget.height,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.transparent,
          width: _DEFAULT_BORDER_WIDTH
        ),
        borderRadius: _DEFAULT_BORDER_RADIUS,
        color: widget.onPressed != null ? _DEFAULT_BACKGROUND_COLOR : _DISABLED_BACKGROUND_COLOR,
      ),
      child: FlatButton(
        onPressed: widget.onPressed,
        child: Center(
          child: Text(
            widget.title,
            style: textStyle,
          ),            
        ),
      ),
    );
  }
}
