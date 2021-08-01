import 'package:flutter/material.dart';
import 'package:sorting_visualization/ui/ui_theme.dart';

class MenuDrawer extends StatelessWidget {
  final List<String> menuItemsList;
  final String selectedValue;
  final Function(String) onTap;
  final Function(bool) onSwitchAction;
  final bool isSwitchEnable;

  const MenuDrawer(
      {Key key,
      @required this.menuItemsList,
      this.selectedValue,
      this.onTap,
      this.onSwitchAction,
      this.isSwitchEnable})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: 250,
        decoration: BoxDecoration(
            gradient: darkGradient),
        child: Column(
          children: [
            Expanded(
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
                      selected: selectedValue == value,
                      selectedTileColor: Theme.of(context).primaryColor,
                      title: Text(
                        value,
                        style: Theme.of(context).textTheme.subtitle2.copyWith(
                            color: selectedValue == value
                                ? Colors.white
                                : lightGrayColor,
                            fontFamily: 'Arial'),
                      ),
                    );
                  }),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 10),
                  child: Text(
                    'Show Sorting History',
                    style: Theme.of(context)
                        .textTheme
                        .caption
                        .copyWith(color: Colors.white),
                  ),
                ),
                Switch(
                    value: this.isSwitchEnable,
                    onChanged: (val) => this.onSwitchAction(val),
                    activeColor: Theme.of(context).primaryColor,
                    inactiveTrackColor: Colors.grey[800]),
              ],
            )
          ],
        ),
      ),
    );
  }
}
