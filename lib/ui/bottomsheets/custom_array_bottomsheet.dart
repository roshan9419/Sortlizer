import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Container(
      child: Column(
        children: [
          Text(
            widget.sheetRequest.title,
            style:
                theme.textTheme.subtitle1.copyWith(color: theme.primaryColor),
          ),
          Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 15),
              margin: EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  border: Border.all(color: Color(0xffF1F1F1))),
              child: TextField(
                maxLines: 1,
                controller: _controller,
                style: theme.textTheme.caption.copyWith(
                    color: Color(0xff00031D)),
                decoration: InputDecoration(
                  hintText: widget.sheetRequest.description,
                  hintStyle: theme.textTheme.caption.copyWith(
                    color: Color(0xff9B9B9B)),
                  focusedBorder: InputBorder.none,
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                ),
              )
          ),
        ],
      ),
    );
  }
}
