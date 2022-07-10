import 'package:flutter/material.dart';
import 'package:sorting_visualization/ui/ui_theme.dart';
import 'package:sorting_visualization/ui/widgets/custom_rect_btn.dart';
import 'package:stacked_services/stacked_services.dart';

class ConfirmationDialog extends StatefulWidget {
  final DialogRequest dialogRequest;
  final Function(DialogResponse) onDialogTap;

  const ConfirmationDialog(
      {Key? key, required this.dialogRequest, required this.onDialogTap})
      : super(key: key);

  @override
  _ConfirmationDialogState createState() => _ConfirmationDialogState();
}

class _ConfirmationDialogState extends State<ConfirmationDialog> {
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
          if (widget.dialogRequest.description != null)
            Text(
              widget.dialogRequest.description!,
              style: theme.textTheme.caption
                  ?.copyWith(color: mediumGrayColor, fontFamily: 'Arial'),
            ),
          SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: CustomRectButton(
                  labelText: widget.dialogRequest.secondaryButtonTitle ?? "No",
                  onTap: () {
                    widget.onDialogTap(DialogResponse(confirmed: false));
                  },
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: CustomRectButton(
                  labelText: widget.dialogRequest.mainButtonTitle ?? "Yes",
                  btnColor: theme.primaryColor,
                  onTap: () {
                    widget.onDialogTap(DialogResponse(confirmed: true));
                  },
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
