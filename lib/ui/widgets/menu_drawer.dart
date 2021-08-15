import 'package:flutter/material.dart';
import 'package:sorting_visualization/ui/ui_theme.dart';

class MenuDrawer extends StatelessWidget {
  final List<String> menuItemsList;
  final String selectedValue;
  final Function(String) onTap;
  final Function(bool) onSwitchAction;
  final Function(bool) onShowFlagSwitchAction;
  final bool isSwitchEnable;
  final bool flagMode;

  const MenuDrawer(
      {Key key,
      @required this.menuItemsList,
      this.selectedValue,
      this.onTap,
      this.onSwitchAction,
      this.onShowFlagSwitchAction,
      this.isSwitchEnable,
      this.flagMode = false})
      : super(key: key);

  // final _controller = ScrollController();

  // _animateToIndex(i) => _controller.animateTo(50.0 * i,
  //     duration: Duration(milliseconds: 900), curve: Curves.fastOutSlowIn);

  @override
  Widget build(BuildContext context) {
    // WidgetsBinding.instance.addPostFrameCallback(
    //     (_) => _animateToIndex(menuItemsList.indexOf(selectedValue)));

    return SafeArea(
      child: Container(
        width: 250,
        decoration: BoxDecoration(gradient: darkGradient),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  // controller: _controller,
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
                    'View Indian Flag',
                    style: Theme.of(context)
                        .textTheme
                        .caption
                        .copyWith(color: Colors.white),
                  ),
                ),
                Switch(
                    value: this.flagMode,
                    onChanged: (val) => this.onShowFlagSwitchAction(val),
                    activeColor: Theme.of(context).primaryColor,
                    inactiveTrackColor: Colors.grey[800]),
              ],
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
// _animateToIndex(menuItemsList.indexOf(selectedValue));

}
