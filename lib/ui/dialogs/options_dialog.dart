import 'package:flutter/material.dart';
import 'package:sorting_visualization/ui/ui_theme.dart';
import 'package:sorting_visualization/ui/widgets/dropDownWidget.dart';
import 'package:sorting_visualization/ui/widgets/custom_rect_btn.dart';
import 'package:stacked_services/stacked_services.dart';

class OptionsDialog extends StatefulWidget {
  final DialogRequest dialogRequest;
  final Function(DialogResponse) onDialogTap;

  const OptionsDialog(
      {Key? key, required this.dialogRequest, required this.onDialogTap})
      : super(key: key);

  @override
  _OptionsDialogState createState() => _OptionsDialogState();
}

class _OptionsDialogState extends State<OptionsDialog> {
  late String _selectedOption;
  List<String> _options = [];

  onSubmit() {
    widget.onDialogTap(DialogResponse(
        confirmed: true,
        data: _selectedOption));
  }

  updateValue(String value) {
    setState(() {
      _selectedOption = value;
    });
  }

  dismissDialog() {
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    _options = widget.dialogRequest.data["options"] as List<String>;
    _selectedOption = widget.dialogRequest.data["selected"] ?? _options.first;
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
            widget.dialogRequest.title!,
            style: theme.textTheme.subtitle2?.copyWith(color: lightGrayColor),
          ),
          SizedBox(height: 10),
          Text(
            widget.dialogRequest.description!,
            style: theme.textTheme.caption
                ?.copyWith(color: mediumGrayColor, fontFamily: 'Arial'),
          ),
          SizedBox(height: 20),
          Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                  color: darkBackgroundStart,
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  border: Border.all(color: Color(0xffafafaf))),
              child: DropDownWidget(
                key: UniqueKey(),
                menuItemsList: _options,
                selectedType: _selectedOption,
                onTap: updateValue,
              )),
          SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: CustomRectButton(
                  labelText: widget.dialogRequest.secondaryButtonTitle!,
                  onTap: dismissDialog,
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: CustomRectButton(
                  labelText: widget.dialogRequest.mainButtonTitle!,
                  btnColor: theme.primaryColor,
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
