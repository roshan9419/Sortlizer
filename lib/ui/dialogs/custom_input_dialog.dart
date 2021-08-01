import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sorting_visualization/ui/ui_theme.dart';
import 'package:sorting_visualization/ui/widgets/custom_rect_btn.dart';
import 'package:stacked_services/stacked_services.dart';

class CustomInputDialog extends StatefulWidget {
  final DialogRequest dialogRequest;
  final Function(DialogResponse) onDialogTap;

  const CustomInputDialog({Key key, this.dialogRequest, this.onDialogTap})
      : super(key: key);

  @override
  _CustomInputDialogState createState() => _CustomInputDialogState(dialogRequest.customData as int);
}

class _CustomInputDialogState extends State<CustomInputDialog> {
  var _controller = new TextEditingController();

  String errorMessage = "Invalid Input";
  bool showError = false;
  List<int> resultsList = [];
  int egNum = Random().nextInt(400);

  final int maxNumber;
  _CustomInputDialogState(this.maxNumber);

  validateField(String value) {
    showError = false;
    errorMessage = "Invalid Input";

    if (value.isEmpty) {
      showError = false;
      setState(() {});
      return;
    }
    setState(() {
      try {
        int x = int.parse(value);
        if (x > maxNumber) {
          errorMessage = "Number must be less than $maxNumber";
          throw new Exception();
        }
        showError = false;
      } catch (e) {
        showError = true;
      }
    });
  }

  addNumber() {
    setState(() {
      if (!showError && _controller.text.isNotEmpty) {
        resultsList.add(int.parse(_controller.text.toString()));
        _controller.clear();
      }
    });
  }

  removeNumber(int index) {
    setState(() {
      resultsList.removeAt(index);
    });
  }

  onSubmit() {
    widget.onDialogTap(
        DialogResponse(confirmed: true, responseData: resultsList));
  }

  dismissDialog() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return WillPopScope(
      onWillPop: () async => false,
      child: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
              gradient: darkGradient),
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                widget.dialogRequest.title,
                style:
                    theme.textTheme.subtitle2.copyWith(color: lightGrayColor),
              ),
              SizedBox(height: 10),
              Text(
                widget.dialogRequest.description,
                style: theme.textTheme.caption
                    .copyWith(color: mediumGrayColor, fontFamily: 'Arial'),
              ),
              SizedBox(height: 10),
              Wrap(
                  children: List.generate(
                resultsList.length,
                (index) {
                  return NumberBox(
                    index: index,
                    number: resultsList[index],
                    onTap: removeNumber,
                  );
                },
              )),
              if (resultsList.isNotEmpty) SizedBox(height: 5),
              if (resultsList.isNotEmpty)
                Text(
                  '(Tap to remove)',
                  style: theme.textTheme.overline
                      .copyWith(color: mediumGrayColor, fontFamily: 'Arial'),
                ),
              SizedBox(height: 10),
              if (showError)
                Text(errorMessage,
                    style: theme.textTheme.caption
                        .copyWith(color: Colors.redAccent)),
              if (showError) SizedBox(height: 5),
              Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                      color: darkBackgroundFinish,
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      border: Border.all(color: Color(0xffafafaf))),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          maxLines: 1,
                          keyboardType: TextInputType.number,
                          controller: _controller,
                          style: theme.textTheme.subtitle2
                              .copyWith(color: lightGrayColor),
                          decoration: InputDecoration(
                              hintText: 'Eg., $egNum',
                              hintStyle: theme.textTheme.caption
                                  .copyWith(color: Color(0xff9B9B9B)),
                              focusedBorder: InputBorder.none,
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none),
                          onChanged: (value) {
                            validateField(value);
                          },
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          addNumber();
                        },
                        child: Text('Add +'),
                      )
                    ],
                  )),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: CustomRectButton(
                      labelText: widget.dialogRequest.secondaryButtonTitle,
                      onTap: dismissDialog,
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: CustomRectButton(
                      labelText: widget.dialogRequest.mainButtonTitle,
                      btnColor: theme.primaryColor,
                      onTap: onSubmit,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class NumberBox extends StatelessWidget {
  final int index;
  final int number;
  final Function onTap;

  const NumberBox({Key key, this.number, this.onTap, this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap(index);
      },
      child: Container(
          width: 50,
          padding: const EdgeInsets.all(5),
          margin: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3.0),
            color: Theme.of(context).primaryColor,
          ),
          child: Center(
              child: Text(
            number.toString(),
            style: Theme.of(context)
                .textTheme
                .overline
                .copyWith(color: Colors.white, fontFamily: 'Arial'),
          ))),
    );
  }
}
