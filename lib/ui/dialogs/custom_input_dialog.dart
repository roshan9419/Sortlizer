import 'package:flutter/material.dart';
import 'package:sorting_visualization/ui/ui_theme.dart';
import 'package:sorting_visualization/ui/widgets/neumorphic_rect_btn.dart';
import 'package:stacked_services/stacked_services.dart';

class CustomInputDialog extends StatefulWidget {
  final DialogRequest dialogRequest;
  final Function(DialogResponse) onDialogTap;

  const CustomInputDialog({Key key, this.dialogRequest, this.onDialogTap})
      : super(key: key);

  @override
  _CustomInputDialogState createState() => _CustomInputDialogState();
}

class _CustomInputDialogState extends State<CustomInputDialog> {
  var _controller = new TextEditingController();

  String validInput = "0123456789, ";
  String errorMessage = "Invalid Input";
  bool showError = false;

  validateField(String value) {
    showError = false;
    setState(() {
      for (var ch in value.characters) {
        if (!validInput.contains(ch)) {
          print(errorMessage);
          showError = true;
          break;
        }
      }
    });
  }

  onSubmit() {
    if (showError) return;
    widget.onDialogTap(
        DialogResponse(confirmed: true, responseData: _controller.text));
  }

  dismissDialog() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [darkBackgroundStart, darkBackgroundFinish])),
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            widget.dialogRequest.title,
            style: theme.textTheme.subtitle2.copyWith(color: lightGrayColor),
          ),
          SizedBox(height: 10),
          Text(
            widget.dialogRequest.description,
            style: theme.textTheme.caption
                .copyWith(color: mediumGrayColor, fontFamily: 'Arial'),
          ),
          SizedBox(height: 20),
          if (showError)
            Text(errorMessage, style: theme.textTheme.caption.copyWith(color: Colors.redAccent)),
          if (showError)
            SizedBox(height: 5),
          Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                color: darkBackgroundFinish,
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  border: Border.all(color: Color(0xffafafaf))),
              child: TextField(
                maxLines: 1,
                keyboardType: TextInputType.numberWithOptions(signed: true),
                controller: _controller,
                style:
                    theme.textTheme.subtitle2.copyWith(color: lightGrayColor),
                decoration: InputDecoration(
                  hintText: 'Type the values separated by ( , )',
                  hintStyle: theme.textTheme.caption
                      .copyWith(color: Color(0xff9B9B9B)),
                  focusedBorder: InputBorder.none,
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none
                ),
                onChanged: (value) {
                  validateField(value);
                },
              )),
          SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: NeumorphicRectButton(
                  labelText: widget.dialogRequest.secondaryButtonTitle,
                  onTap: dismissDialog,
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: NeumorphicRectButton(
                  labelText: widget.dialogRequest.mainButtonTitle,
                  btnColor: (showError || _controller.text.toString().isEmpty) ? theme.primaryColor.withOpacity(0.5) : theme.primaryColor,
                  onTap: onSubmit,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
