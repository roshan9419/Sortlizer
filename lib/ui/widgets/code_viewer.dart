import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CodeViewer extends StatefulWidget {
  final String codeContent;
  final bool showCopyBtn;

  const CodeViewer({Key key, this.codeContent, this.showCopyBtn = true})
      : super(key: key);

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
                  heroTag: 'themeSwitcher',
                  backgroundColor:
                      isDark ? Colors.white : Theme.of(context).primaryColor,
                  child: Icon(
                    isDark ? Icons.wb_sunny_outlined : Icons.nightlight_round,
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
    );
  }
}
