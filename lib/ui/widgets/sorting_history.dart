import 'package:flutter/material.dart';
import 'package:sorting_visualization/datamodels/algo_history_track.dart';
import 'package:sorting_visualization/ui/ui_theme.dart';

class SortingHistoryTable extends StatelessWidget {
  final List<AlgoHistoryTrack> itemsList;
  final String tableName;
  final Function onDetailsBtnTap;

  SortingHistoryTable(
      {Key key, @required this.itemsList, this.tableName, this.onDetailsBtnTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var headerStyle = Theme.of(context)
        .textTheme
        .caption
        .copyWith(fontWeight: FontWeight.bold, color: Colors.white);
    var normalStyle = Theme.of(context).textTheme.caption.copyWith(
        fontWeight: FontWeight.bold,
        color: lightGrayColor,
        fontFamily: 'Arial');
    return Container(
      padding: EdgeInsets.all(15.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                tableName,
                style: Theme.of(context)
                    .textTheme
                    .subtitle2
                    .copyWith(color: Theme.of(context).primaryColor),
              ),
              TextButton(
                onPressed: onDetailsBtnTap,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "View Detailed Track",
                      style: Theme.of(context)
                          .textTheme
                          .caption
                          .copyWith(color: lightGrayColor),
                    ),
                    Icon(
                      Icons.double_arrow,
                      size: 15,
                      color: lightGrayColor,
                    )
                  ],
                ),
              )
            ],
          ),
          // SizedBox(height: 10),
          Table(
            border: TableBorder.all(color: Colors.white38),
            children: [
              TableRow(children: [
                getTableRow('Algorithm Title', headerStyle),
                getTableRow('Array Size', headerStyle),
                getTableRow('Time taken(ms)', headerStyle),
                getTableRow('Comparisons', headerStyle)
              ]),
              for (int i = 0; i < itemsList.length; i++)
                TableRow(children: [
                  getTableRow(itemsList[i].algoTitle, normalStyle),
                  getTableRow(itemsList[i].arraySize.toString(), normalStyle),
                  getTableRow(itemsList[i].timeTaken.toString(), normalStyle),
                  getTableRow(
                      itemsList[i].totalComparisons.toString(), normalStyle)
                ])
            ],
          ),
        ],
      ),
    );
  }

  getTableRow(String text, TextStyle textStyle) {
    return Padding(
      padding: EdgeInsets.all(5.0),
      child: Text(text, style: textStyle),
    );
  }
}
