import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sorting_visualization/ui/ui_theme.dart';

class DropDownWidget extends StatefulWidget {
  final String selectedType;
  final List<String> menuItemsList;
  final Function onTap;
  final bool showDropDownIcon;

  const DropDownWidget(
      {Key key, this.selectedType, this.menuItemsList, this.onTap, this.showDropDownIcon = true})
      : super(key: key);

  @override
  _DropDownWidgetState createState() => _DropDownWidgetState();
}

class _DropDownWidgetState extends State<DropDownWidget> {
  String _selectedType;

  _onTap(val) {
    widget.onTap(val);
    setState(() {
      _selectedType = val;
    });
  }

  @override
  void initState() {
    super.initState();
    _selectedType = widget.selectedType;
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        value: _selectedType,
        iconSize: widget.showDropDownIcon ? 20 : 0,
        items: widget.menuItemsList.toList().map((String value) {
          return new DropdownMenuItem<String>(
            value: value,
            child: Container(
              child: Text(value,
                  style: theme.textTheme.subtitle2.copyWith(
                      fontWeight: value == _selectedType
                          ? FontWeight.bold
                          : FontWeight.normal,
                      color: value == _selectedType ? Colors.blue : lightGrayColor,
                      letterSpacing: 1),
                  maxLines: 1,
                  softWrap: true),
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
