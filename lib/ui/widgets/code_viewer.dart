import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sorting_visualization/ui/ui_theme.dart';

class CodeViewer extends StatefulWidget {
  final String codeContent;
  final String titleLabel;
  final String sourceLabel;
  final bool showCopyBtn;

  const CodeViewer(
      {Key key,
      this.codeContent,
      this.titleLabel,
      this.sourceLabel,
      this.showCopyBtn = true})
      : super(key: key);

  @override
  _CodeViewerState createState() => _CodeViewerState();
}

class _CodeViewerState extends State<CodeViewer> {
  bool isDark = true;

  changeTheme() {
    setState(() {
      isDark = !isDark;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.titleLabel != null && widget.titleLabel.isNotEmpty)
          Padding(
            padding: EdgeInsets.only(bottom: 8.0),
            child: Text(
              widget.titleLabel,
              style: Theme.of(context)
                  .textTheme
                  .subtitle2
                  .copyWith(color: Theme.of(context).primaryColor),
            ),
          ),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
              color: isDark ? Color(0xff2B2B2B) : Colors.white,
              border: Border.all(color: Colors.grey),
              boxShadow: [
                BoxShadow(
                    color: darkGrayColor,
                    offset: Offset(5, 5),
                    spreadRadius: -10,
                    blurRadius: 10),
                BoxShadow(
                    color: darkGrayColor,
                    offset: Offset(-5, -5),
                    spreadRadius: -10,
                    blurRadius: 10)
              ],
              borderRadius: BorderRadius.all(Radius.circular(5))),
          padding: EdgeInsets.all(10),
          child: Stack(
            children: [
              Text(
                widget.codeContent,
                style: Theme.of(context).textTheme.subtitle2.copyWith(
                    color: isDark ? Colors.white : Colors.black87,
                    fontFamily: 'Arial',
                    fontWeight: FontWeight.normal),
              ),
              Positioned(
                  top: 0,
                  right: 0,
                  child: FloatingActionButton(
                      onPressed: () {
                        changeTheme();
                      },
                      mini: true,
                      heroTag: 'themeSwitcher',
                      backgroundColor: isDark
                          ? Colors.white
                          : Theme.of(context).primaryColor,
                      child: Icon(
                        isDark
                            ? Icons.wb_sunny_outlined
                            : Icons.nightlight_round,
                        color: isDark ? Colors.black87 : Colors.white,
                        size: 20,
                      ))),
              widget.showCopyBtn
                  ? Positioned(
                      top: 50,
                      right: 0,
                      child: FloatingActionButton(
                          onPressed: () {
                            Clipboard.setData(
                                    ClipboardData(text: widget.codeContent))
                                .then((value) =>
                                    Scaffold.of(context).showSnackBar(SnackBar(
                                      content: Text('Code Copied'),
                                    )));
                          },
                          mini: true,
                          heroTag: 'copy',
                          backgroundColor: Theme.of(context).primaryColor,
                          child: Icon(
                            Icons.copy,
                            color: Colors.white,
                            size: 20,
                          )))
                  : SizedBox.shrink()
            ],
          ),
        ),
        if (widget.sourceLabel != null && widget.sourceLabel.isNotEmpty)
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: Text(
                  widget.sourceLabel,
                  textAlign: TextAlign.end,
                  style: Theme.of(context).textTheme.caption.copyWith(
                      fontStyle: FontStyle.italic, color: lightGrayColor),
                ),
              ),
            ],
          ),
      ],
    );
  }
}
