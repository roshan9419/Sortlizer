import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sorting_visualization/ui/ui_theme.dart';

class NeumorphicRectButton extends StatelessWidget {
  final String labelText;
  final Color labelTextColor;
  final Color btnColor;
  final double btnWidth;
  final double btnHeight;
  final double btnRadius;
  final Widget child;
  final Function onTap;

  const NeumorphicRectButton(
      {Key key,
      this.labelText,
      this.labelTextColor,
      this.btnColor,
      this.btnWidth,
      this.btnHeight,
      this.btnRadius,
      this.child,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(btnRadius ?? 5),
      child: Container(
        width: btnWidth == null
            ? (labelText != null && labelText.isNotEmpty)
                ? labelText.length * 20.0
                : 50.0
            : btnWidth,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: btnColor ?? darkBtnColor2,
            borderRadius: BorderRadius.circular(btnRadius ?? 5),
            boxShadow: [
              BoxShadow(
                  color: Color(0xff2f2f2f), offset: Offset(4, 4), blurRadius: 10),
              BoxShadow(
                  color: Color(0xff2f2f2f),
                  offset: Offset(-4, -4),
                  blurRadius: 10),
            ]),
        child: child == null
            ? Text(
                (labelText != null && labelText.isNotEmpty) ? labelText : "",
                style: Theme.of(context)
                    .textTheme
                    .subtitle2
                    .copyWith(color: labelTextColor ?? Colors.white),
                textAlign: TextAlign.center,
              )
            : child,
      ),
    );
  }
}
