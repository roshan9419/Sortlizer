import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:widget_with_codeview/source_code_view.dart';
import 'package:widget_with_codeview/widget_with_codeview.dart';

class CodeViewer extends StatefulWidget {
  final String codeContent;

  const CodeViewer({Key key, this.codeContent}) : super(key: key);

  @override
  _CodeViewerState createState() => _CodeViewerState();
}

class _CodeViewerState extends State<CodeViewer> {
  bool isDark = false;

  changeTheme() {
    setState(() {
      isDark = !isDark;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 500,
      decoration: BoxDecoration(
          color: isDark ? Color(0xff2B2B2B) : Colors.white,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.all(Radius.circular(5))),
      padding: EdgeInsets.all(10),
      child: Stack(
        children: [
          Text(
            widget.codeContent,
            style: Theme.of(context)
                .textTheme
                .subtitle2
                .copyWith(color: isDark ? Colors.white : Colors.black),
          ),
          Positioned(
              top: 0,
              right: 0,
              child: FloatingActionButton(
                  onPressed: () {
                    changeTheme();
                  },
                  mini: true,
                  backgroundColor: isDark ? Colors.white : Theme.of(context).primaryColor,
                  child: Icon(
                    isDark ? Icons.wb_sunny_outlined : Icons.nightlight_round,
                    color: isDark ? Colors.black87 : Colors.white,
                    size: 20,
                  )))
        ],
      ),
    );
  }
}
