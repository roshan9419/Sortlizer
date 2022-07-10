import 'package:flutter/material.dart';
import 'package:sorting_visualization/ui/ui_theme.dart';

class MenuDrawer extends StatelessWidget {
  final List<String> menuItemsList;
  final String selectedValue;
  final Function(String) onTap;
  final Function(bool) onShowFlagSwitchAction;
  final Function() onSettingsTap;
  final bool isSwitchEnable;
  final bool flagMode;

  const MenuDrawer(
      {Key? key,
      required this.menuItemsList,
      required this.selectedValue,
      required this.onTap,
      required this.onShowFlagSwitchAction,
      required this.isSwitchEnable,
        required this.onSettingsTap,
      this.flagMode = false})
      : super(key: key);

  // final _controller = ScrollController();

  // _animateToIndex(i) => _controller.animateTo(50.0 * i,
  //     duration: Duration(milliseconds: 900), curve: Curves.fastOutSlowIn);

  @override
  Widget build(BuildContext context) {
    // WidgetsBinding.instance.addPostFrameCallback(
    //     (_) => _animateToIndex(menuItemsList.indexOf(selectedValue)));
    var theme = Theme.of(context);
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
                    return InkWell(
                      onTap: () async {
                        onTap(value);
                        await Future.delayed(Duration(milliseconds: 50), () {});
                        Navigator.pop(context);
                      },
                      child: Container(
                        child: Text(value,
                            style: theme.textTheme.subtitle2?.copyWith(
                                color: selectedValue == value
                                    ? Colors.white
                                    : lightGrayColor,
                                fontFamily: 'Arial')),
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                        color: selectedValue == value
                            ? theme.primaryColor
                            : Colors.transparent,
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
                        ?.copyWith(color: Colors.white),
                  ),
                ),
                Switch(
                    value: this.flagMode,
                    onChanged: (val) => this.onShowFlagSwitchAction(val),
                    activeColor: Theme.of(context).primaryColor,
                    inactiveTrackColor: Colors.grey[800]),
              ],
            ),
            TextButton.icon(
              icon: Icon(Icons.settings),
              onPressed: this.onSettingsTap,
              label: Text(
                'Settings',
                style: Theme.of(context)
                    .textTheme
                    .caption
                    ?.copyWith(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
// _animateToIndex(menuItemsList.indexOf(selectedValue));

}
