import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sorting_visualization/ui/ui_theme.dart';

class NeumorphicButton extends StatefulWidget {
  final Icon icon;
  final Color btnColor;
  final Function onTap;
  final double btnSize;

  const NeumorphicButton(
      {Key key, @required this.icon, this.btnColor, this.onTap, this.btnSize})
      : super(key: key);

  @override
  _NeumorphicButtonState createState() => _NeumorphicButtonState(btnSize: btnSize ?? 20);
}

class _NeumorphicButtonState extends State<NeumorphicButton> {
  double btnSize;

  _NeumorphicButtonState({this.btnSize});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      borderRadius: BorderRadius.circular(btnSize),
      child: Container(
        width: btnSize * 2,
        height: btnSize * 2,
        padding: EdgeInsets.only(bottom: 2),
        decoration: BoxDecoration(
            color: widget.btnColor ?? blueThemeColor,
            borderRadius: BorderRadius.circular(btnSize),
            boxShadow: [
              BoxShadow(
                  color: shadowColor1, offset: Offset(4, 4), blurRadius: 12),
              BoxShadow(
                  color: Color(0xff4d4e57), offset: Offset(-4, -4), blurRadius: 12),
            ]),
        child: widget.icon,
      ),
    );
  }
}
