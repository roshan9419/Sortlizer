import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sorting_visualization/ui/ui_theme.dart';
import 'package:sorting_visualization/ui/widgets/dropDownWidget.dart';
import 'package:sorting_visualization/ui/widgets/custom_rect_btn.dart';
import 'package:stacked_services/stacked_services.dart';

class CustomArraySizeDialog extends StatefulWidget {
  final DialogRequest dialogRequest;
  final Function(DialogResponse) onDialogTap;

  const CustomArraySizeDialog({Key key, this.dialogRequest, this.onDialogTap})
      : super(key: key);

  @override
  _CustomArraySizeDialogState createState() => _CustomArraySizeDialogState();
}

class _CustomArraySizeDialogState extends State<CustomArraySizeDialog> {
  var _controller = new TextEditingController();

  bool isDisabled = true;
  int maxArraySize = 1000;

  List<String> sizeList = ["Choose", "50", "100", "200", "300", "400", "500", "1000"];
  String _selectedSize;
  String errorMessage = "Invalid Size";

  onSubmit() {
    if (isDisabled) return;
    widget.onDialogTap(DialogResponse(
        confirmed: true,
        responseData: _selectedSize != sizeList[0]
            ? _selectedSize
            : _controller.text.toString()));
  }

  updateValue(String value) {
    if (_controller.text.toString().isEmpty && _selectedSize == sizeList[0]) {
      setState(() {
        isDisabled = true;
      });
    }
    if (_controller.text.toString().isEmpty) return;
    setState(() {
      _selectedSize = sizeList[0];
      try {
        var size = int.parse(value);
        if (size > maxArraySize) throw Exception("Array Size is Greater");
        isDisabled = false;
      } catch (e) {
        isDisabled = true;
      }
    });
  }

  dismissDialog() {
    Navigator.pop(context);
  }

  updateSelectedSize(String value) {
    setState(() {
      _selectedSize = value;
      isDisabled = false;
      if (_selectedSize == sizeList[0] && _controller.text.toString().isEmpty)
        isDisabled = true;
      _controller.clear();
    });
  }

  @override
  void initState() {
    super.initState();
    _selectedSize = sizeList[0];
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
          gradient: darkGradient,
      ),
      padding: EdgeInsets.all(15),
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
          Row(
            children: [
              Expanded(
                child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                        color: darkBackgroundFinish,
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        border: Border.all(color: Color(0xffafafaf))),
                    child: TextField(
                      maxLines: 1,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      controller: _controller,
                      style: theme.textTheme.subtitle2
                          .copyWith(color: lightGrayColor),
                      decoration: InputDecoration(
                          hintText: 'Ex: 100',
                          hintStyle: theme.textTheme.caption
                              .copyWith(color: Color(0xff9B9B9B)),
                          focusedBorder: InputBorder.none,
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none),
                      onChanged: (value) {
                        updateValue(value);
                      },
                    )),
              ),
              SizedBox(width: 10),
              Text(
                "or",
                style: theme.textTheme.caption
                    .copyWith(color: mediumGrayColor, fontFamily: 'Arial'),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                        color: darkBackgroundStart,
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        border: Border.all(color: Color(0xffafafaf))),
                    child: DropDownWidget(
                      key: UniqueKey(),
                      menuItemsList: sizeList,
                      selectedType: _selectedSize,
                      onTap: updateSelectedSize,
                    )),
              ),
            ],
          ),
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
                  btnColor: isDisabled
                      ? theme.primaryColor.withOpacity(0.5)
                      : theme.primaryColor,
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
