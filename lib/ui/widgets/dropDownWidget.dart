import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DropDownWidget extends StatefulWidget {
  final String selectedType;
  final List<String> menuItemsList;
  final Function onTap;

  const DropDownWidget(
      {Key key, this.selectedType, this.menuItemsList, this.onTap})
      : super(key: key);

  @override
  _DropDownWidgetState createState() => _DropDownWidgetState();
}

class _DropDownWidgetState extends State<DropDownWidget> {
  String _selectedType;

  init() {
    _selectedType = widget.selectedType;
  }

  _onTap(val) {
    widget.onTap(val);
    setState(() {
      _selectedType = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        isDense: true,
        value: _selectedType,
        iconSize: 0,
        items: widget.menuItemsList.toList().map((String value) {
          return new DropdownMenuItem<String>(
            value: value,
            child: Container(
              child: Row(
                children: [
                  Text(value,
                      style: theme.textTheme.subtitle1.copyWith(
                          fontWeight: value == _selectedType
                              ? FontWeight.bold
                              : FontWeight.normal,
                          color: Colors.white,
                          letterSpacing: 1),
                      maxLines: 1,
                      softWrap: true),
                ],
              ),
            ),
          );
        }).toList(),
        onChanged: (val) {
          _onTap(val);
        },
      ),
    );
  }
}
