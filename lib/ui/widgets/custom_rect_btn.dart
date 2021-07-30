import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sorting_visualization/ui/ui_theme.dart';

class CustomRectButton extends StatelessWidget {
  final String labelText;
  final Color labelTextColor;
  final Color btnColor;
  final Color btnBorderColor;
  final double btnWidth;
  final double btnHeight;
  final double btnRadius;
  final Widget child;
  final Function onTap;

  const CustomRectButton(
      {Key key,
      this.labelText,
      this.labelTextColor,
      this.btnColor,
      this.btnWidth,
      this.btnHeight,
      this.btnRadius,
      this.child,
      this.onTap, this.btnBorderColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: btnWidth == null
          ? (labelText != null && labelText.isNotEmpty)
              ? labelText.length * 20.0
              : 50.0
          : btnWidth,
      child: ElevatedButton(
        onPressed: onTap,
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
        style: ElevatedButton.styleFrom(
            elevation: 10,
            primary: btnColor ?? darkBtnColor2,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5))),
            // onPrimary: Theme.of(context).primaryColor,
            side: BorderSide(
              color: btnBorderColor ?? Colors.transparent,
            ),
            textStyle: Theme.of(context).textTheme.caption.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor)),
      ),
    );
  }
}
