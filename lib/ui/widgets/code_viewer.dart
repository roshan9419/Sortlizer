import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutter_highlight/themes/a11y-dark.dart';
import 'package:flutter_highlight/themes/atelier-forest-dark.dart';
import 'package:flutter_highlight/themes/atom-one-dark-reasonable.dart';
import 'package:flutter_highlight/themes/atom-one-dark.dart';
import 'package:flutter_highlight/themes/dark.dart';
import 'package:flutter_highlight/themes/github.dart';
import 'package:flutter_highlight/themes/kimbie.dark.dart';
import 'package:flutter_highlight/themes/mono-blue.dart';
import 'package:flutter_highlight/themes/solarized-dark.dart';
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

  List<String> contentList() {
    return widget.codeContent.split("\n");
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
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: isDark
                  ? atomOneDarkTheme['root'].backgroundColor
                  : monoBlueTheme['root'].backgroundColor,
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
          child: Stack(
            children: [
              Column(
                children: [
                  for (int i = 0; i < contentList().length; i += 70)
                    HighlightView(
                      contentList()
                          .sublist(
                              i,
                              i + 70 > contentList().length
                                  ? contentList().length - 1
                                  : i + 70)
                          .join("\n"),
                      language: 'cpp',
                      theme: isDark ? atomOneDarkTheme : monoBlueTheme,
                      padding: EdgeInsets.all(10),
                      textStyle: TextStyle(
                        fontFamily: 'Arial',
                        fontSize: 14,
                      ),
                    ),
                ],
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
