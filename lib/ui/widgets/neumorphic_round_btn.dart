import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sorting_visualization/ui/ui_theme.dart';

class NeumorphicButton extends StatefulWidget {
  final Icon icon;
  final Color btnColor;
  final Function onTap;
  final double btnSize;
  final String labelText;
  final bool isPressed;

  const NeumorphicButton(
      {Key key,
      @required this.icon,
      this.btnColor,
      this.onTap,
      this.btnSize,
      this.labelText,
      this.isPressed = false})
      : super(key: key);

  @override
  _NeumorphicButtonState createState() =>
      _NeumorphicButtonState(btnSize: btnSize ?? 40);
}

class _NeumorphicButtonState extends State<NeumorphicButton> {
  double btnSize;

  _NeumorphicButtonState({this.btnSize});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      borderRadius: BorderRadius.circular(btnSize / 2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (widget.labelText != null && widget.labelText.isNotEmpty)
            Text(widget.labelText,
                style: Theme.of(context)
                    .textTheme
                    .overline
                    .copyWith(color: mediumGrayColor)),
          if (widget.labelText != null && widget.labelText.isNotEmpty)
            SizedBox(height: 15),
          !widget.isPressed
              ? Container(
                  width: btnSize,
                  height: btnSize,
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                      color: widget.btnColor ?? darkBtnColor1,
                      borderRadius: BorderRadius.circular(btnSize / 2),
                      boxShadow: [
                        BoxShadow(
                            color: shadowColor1,
                            offset: Offset(4, 4),
                            blurRadius: 12),
                        BoxShadow(
                            color: Color(0xff4d4e57),
                            offset: Offset(-4, -4),
                            blurRadius: 12),
                      ]),
                  child: widget.icon,
                )
              : Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: btnSize,
                      height: btnSize,
                      decoration: BoxDecoration(
                          color: widget.btnColor ?? darkBtnColor1,
                          borderRadius: BorderRadius.circular(btnSize / 2),
                          boxShadow: [
                            BoxShadow(
                                color: shadowColor1,
                                offset: Offset(4, 4),
                                blurRadius: 12),
                            BoxShadow(
                                color: Color(0xff4d4e57),
                                offset: Offset(-4, -4),
                                blurRadius: 12),
                          ]),
                    ),
                    Container(
                      width: btnSize - (15 * btnSize / 100),
                      height: btnSize - (15 * btnSize / 100),
                      padding: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              tileMode: TileMode.clamp,
                              colors: [
                                darkGrayColor.withOpacity(0.4),
                                widget.btnColor.withOpacity(0) ??
                                    darkBtnColor1.withOpacity(0)
                              ]),
                          borderRadius: BorderRadius.circular(btnSize / 2)),
                      child: widget.icon,
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}
