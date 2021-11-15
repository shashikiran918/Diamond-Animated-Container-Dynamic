

import 'package:flutter/material.dart';


class Diamond extends StatefulWidget {
  const Diamond(this.userInput, {Key? key}) : super(key: key);
  final int userInput;
  @override
  _DiamondState createState() => _DiamondState();
}

class _DiamondState extends State<Diamond> {
  // late int boxes;
  late int row;
  late int input;
  var opacity;
  var color = Colors.transparent;

  late ScrollController _scrollController;
  late ScrollController _scrollController1;

  @override
  void initState() {
    row = (2 * widget.userInput) - 1;
// boxes = pow(row, 2).toInt();
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) => initValues());
    _scrollController1 = ScrollController();
    _scrollController = ScrollController();

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _scrollController1.jumpTo(
        (_scrollController.position.maxScrollExtent / 2.3),
      );
      _scrollController.jumpTo(
        (_scrollController.position.minScrollExtent / 2.3),
      );
    });
  }
  void initValues() {
    setState(() {
      opacity = 0;
      color = Colors.green;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.redAccent,
            body: Center(
              child: Container(
                alignment: Alignment.center,
                color: Colors.purple,
                child: SingleChildScrollView(
                    controller: _scrollController1,
                    scrollDirection: Axis.vertical,
                    child: SizedBox(
                      height: row * 50,
                      width: row * 50,
                      child: GridView.count(
                        controller: _scrollController,
                        scrollDirection: Axis.horizontal,
                        crossAxisCount: row,
                        children: pattern(widget.userInput),
                      ),
                    )),
              ),
            )));
  }


  List<Widget> pattern(int userInput) {
    opacity = 0.5;
    var listWidget = <Widget>[];
    int size = row;
    int start, end, mid;
    int containerText = 0;
    var totalRows = row;
    var revRow;
    var value;
    start = end = mid = size ~/ 2;
    for (int row = 0; row < size; row++,) {
      if (row <= ((totalRows / 2))) {
        revRow = row;
      }
      if (row > ((totalRows / 2))) {
        value = revRow--;
      }

      for (int col = 0; col < size; col++) {
        if (col >= start && col <= end) {
          if (col <= (start + end) / 2) {
            containerText++;
          } else {
            containerText--;
          }
          if (row < (totalRows / 2) - 1) {
            listWidget.add(
                AnimatedContainer(
              duration: Duration(seconds: row + 1),
              curve: Curves.bounceInOut,
              decoration: BoxDecoration(
                  color: color, border: Border.all(color: Colors.black)),
              alignment: Alignment.center,
              child: Text(
                '$containerText',
                style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),
              ),
            ));
            // revRow = row + 1;
          } else if (
          row <= ((totalRows / 2))) {
            listWidget.add(
                Container(
              decoration: BoxDecoration(
                  color: Colors.green, border: Border.all(color: Colors.black)),
              alignment: Alignment.center,
              child: Text(
                '$containerText',
                style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),
              ),
            ));
            // revRow = row;
          } else if (
          row > ((totalRows / 2))) {
            listWidget.add(
                AnimatedContainer(
              duration: Duration(seconds: revRow),  
                  curve: Curves.bounceInOut,
              decoration: BoxDecoration(
                  color: color, border: Border.all(color: Colors.black)),
              alignment: Alignment.center,
              child: Text(
                '$containerText',
                style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),
              ),
            ));

            print('value of reverse row is $value');
          }
        } else {
          listWidget.add(const SizedBox());
        }
      }
      if (row < mid) {
        start--;
        end++;
      } else {
        start++;
        end--;
      }
      containerText = 0;
    }
    // print(listWidget.length);

    return listWidget;
  }
}
