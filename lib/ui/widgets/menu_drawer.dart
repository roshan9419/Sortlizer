import 'package:flutter/material.dart';
import 'package:sorting_visualization/ui/ui_theme.dart';

class MenuDrawer extends StatelessWidget {
  final List<String> menuItemsList;
  final String selectedValue;
  final Function(String) onTap;

  const MenuDrawer(
      {Key key, @required this.menuItemsList, this.selectedValue, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: 250,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [darkBackgroundStart, darkBackgroundFinish])),
        child: ListView.builder(
            itemCount: menuItemsList.length,
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              String value = menuItemsList[index];
              return ListTile(
                onTap: () async {
                  onTap(value);
                  await Future.delayed(Duration(milliseconds: 50), () {});
                  Navigator.pop(context);
                },
                tileColor: selectedValue == value
                    ? Theme.of(context).primaryColor
                    : Colors.transparent,
                title: Text(
                  value,
                  style: Theme.of(context).textTheme.subtitle2.copyWith(
                      color: selectedValue == value
                          ? Colors.white
                          : lightGrayColor,
                    fontFamily: 'Arial'
                  ),
                ),
              );
            }),
      ),
    );
  }
}
