import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sorting_visualization/ui/ui_theme.dart';
import 'package:sorting_visualization/ui/widgets/custom_round_btn.dart';
import 'package:stacked_services/stacked_services.dart';

class CustomArrayBottomSheet extends StatefulWidget {
  final SheetRequest sheetRequest;
  final Function(SheetResponse) onDialogTap;

  const CustomArrayBottomSheet({Key key, this.sheetRequest, this.onDialogTap})
      : super(key: key);

  @override
  _CustomArrayBottomSheetState createState() => _CustomArrayBottomSheetState();
}

class _CustomArrayBottomSheetState extends State<CustomArrayBottomSheet> {
  var _controller = new TextEditingController();

  onBtnPressed() {
    widget.onDialogTap(SheetResponse(
        confirmed: true, responseData: _controller.text));
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: darkBackgroundFinish,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      padding: EdgeInsets.all(15),
      height: 200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          CustomRoundButton(icon: Icon(Icons.check, size: 35, color: Colors.white,),
            onTap: onBtnPressed, btnSize: 50, btnColor: theme.primaryColor,),
          SizedBox(height: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.sheetRequest.title,
                style: theme.textTheme.subtitle1.copyWith(
                    color: theme.primaryColor, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 15),
              Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      border: Border.all(color: Color(0xffafafaf))),
                  child: TextField(
                    maxLines: 1,
                    keyboardType: TextInputType.numberWithOptions(signed: true),
                    controller: _controller,
                    style: theme.textTheme.subtitle2
                        .copyWith(color: lightGrayColor),
                    decoration: InputDecoration(
                      hintText: widget.sheetRequest.description,
                      hintStyle: theme.textTheme.caption
                          .copyWith(color: Color(0xff9B9B9B)),
                      focusedBorder: InputBorder.none,
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                    ),
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
