import 'dart:core';
import 'dart:ui';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../modals/transaction_modal.dart';

class  ExpansedChart extends StatefulWidget {
  @override
  _ExpansedChartState createState() => _ExpansedChartState();
}

class _ExpansedChartState extends State<ExpansedChart> {

  @override
  void initState() {
    super.initState();
  }
  late Box box;
  // final dataMap = <String, double>{
  //   "Flutter":10,
  //   "React": 3,
  //   "Xamarin": 2,
  //   "Ionic": 2,
  // };
  Future<List<Map<String, double>>> addData() async{
    List<TransactionModel> data = await fetch();
    List<Map<String,double>> result = [];
    for(int i = 0 ; i < data.length; i++){
      result.add({'${data[i].dropdownValue}': double.parse(data[i].amount.toString())});
    }
    return result;
  }


  Future<List<TransactionModel>> fetch() async {
    if (box.values.isEmpty) {
      return Future.value([]);
    } else {
      List<TransactionModel> items = [];
      box.toMap().values.forEach((element) {
        items.add(
          TransactionModel(
            element['amount'] ,
            element['date'] ,
            element['dropdownValue'],
            element['type'],
          ),
        );
      });
      return items;
    }
  }
  final colorList = <Color>[
    Color(0xfffdcb6e),
    Color(0xff0984e3),
    Color(0xfffd79a8),
    Color(0xffe17055),
    Color(0xff6c5ce7),
  ];


  ChartType? _chartType = ChartType.disc;
  double? _ringStrokeWidth = 32;

  int key = 0;

  @override
  Widget build(BuildContext context) {
    final chart = PieChart(
      key: ValueKey(key),
      dataMap: addData(),
      animationDuration: Duration(milliseconds: 800),

      chartRadius: math.min(MediaQuery.of(context).size.width / 1.2, 300),
      colorList: colorList,
      initialAngleInDegree: 0,
      chartType: _chartType!,
      centerText:  "Expanded" ,
      chartValuesOptions: ChartValuesOptions(
        showChartValues: true,
        showChartValuesInPercentage: true
      ),
      ringStrokeWidth: _ringStrokeWidth!,
      emptyColor: Colors.grey,

      emptyColorGradient: [
        Color(0xff6c5ce7),
        Colors.blue,
      ],
      baseChartColor: Colors.transparent,
    );
    // final settings = SingleChildScrollView(
    //   child: Card(
    //     margin: EdgeInsets.all(12),
    //     child: Column(
    //       children: [
    //         SwitchListTile(
    //           value: _showGradientColors,
    //           title: Text("Show Gradient Colors"),
    //           onChanged: (val) {
    //             setState(() {
    //               _showGradientColors = val;
    //             });
    //           },
    //         ),
    //         ListTile(
    //           title: Text(
    //             'Pie Chart Options'.toUpperCase(),
    //             style: Theme.of(context).textTheme.overline!.copyWith(
    //               fontSize: 12,
    //               fontWeight: FontWeight.bold,
    //             ),
    //           ),
    //         ),
    //         ListTile(
    //           title: Text("chartType"),
    //           trailing: Padding(
    //             padding: const EdgeInsets.symmetric(horizontal: 16.0),
    //             child: DropdownButton<ChartType>(
    //               value: _chartType,
    //               items: [
    //                 DropdownMenuItem(
    //                   child: Text("disc"),
    //                   value: ChartType.disc,
    //                 ),
    //                 DropdownMenuItem(
    //                   child: Text("ring"),
    //                   value: ChartType.ring,
    //                 ),
    //               ],
    //               onChanged: (val) {
    //                 setState(() {
    //                   _chartType = val;
    //                 });
    //               },
    //             ),
    //           ),
    //         ),
    //         ListTile(
    //           title: Text("ringStrokeWidth"),
    //           trailing: Padding(
    //             padding: const EdgeInsets.symmetric(horizontal: 16.0),
    //             child: DropdownButton<double>(
    //               value: _ringStrokeWidth,
    //               disabledHint: Text("select chartType.ring"),
    //               items: [
    //                 DropdownMenuItem(
    //                   child: Text("16"),
    //                   value: 16,
    //                 ),
    //                 DropdownMenuItem(
    //                   child: Text("32"),
    //                   value: 32,
    //                 ),
    //                 DropdownMenuItem(
    //                   child: Text("48"),
    //                   value: 48,
    //                 ),
    //               ],
    //               onChanged: (_chartType == ChartType.ring)
    //                   ? (val) {
    //                 setState(() {
    //                   _ringStrokeWidth = val;
    //                 });
    //               }
    //                   : null,
    //             ),
    //           ),
    //         ),
    //         SwitchListTile(
    //           value: _showCenterText,
    //           title: Text("showCenterText"),
    //           onChanged: (val) {
    //             setState(() {
    //               _showCenterText = val;
    //             });
    //           },
    //         ),
    //         ListTile(
    //           title: Text("chartLegendSpacing"),
    //           trailing: Padding(
    //             padding: const EdgeInsets.symmetric(horizontal: 16.0),
    //             child: DropdownButton<double>(
    //               value: _chartLegendSpacing,
    //               disabledHint: Text("select chartType.ring"),
    //               items: [
    //                 DropdownMenuItem(
    //                   child: Text("16"),
    //                   value: 16,
    //                 ),
    //                 DropdownMenuItem(
    //                   child: Text("32"),
    //                   value: 32,
    //                 ),
    //                 DropdownMenuItem(
    //                   child: Text("48"),
    //                   value: 48,
    //                 ),
    //                 DropdownMenuItem(
    //                   child: Text("64"),
    //                   value: 64,
    //                 ),
    //               ],
    //               onChanged: (val) {
    //                 setState(() {
    //                   _chartLegendSpacing = val;
    //                 });
    //               },
    //             ),
    //           ),
    //         ),
    //         ListTile(
    //           title: Text(
    //             'Legend Options'.toUpperCase(),
    //             style: Theme.of(context).textTheme.overline!.copyWith(
    //               fontSize: 12,
    //               fontWeight: FontWeight.bold,
    //             ),
    //           ),
    //         ),
    //         SwitchListTile(
    //           value: _showLegendsInRow,
    //           title: Text("showLegendsInRow"),
    //           onChanged: (val) {
    //             setState(() {
    //               _showLegendsInRow = val;
    //             });
    //           },
    //         ),
    //         SwitchListTile(
    //           value: _showLegends,
    //           title: Text("showLegends"),
    //           onChanged: (val) {
    //             setState(() {
    //               _showLegends = val;
    //             });
    //           },
    //         ),
    //         SwitchListTile(
    //           value: _showLegendLabel,
    //           title: Text("showLegendLabels"),
    //           onChanged: (val) {
    //             setState(() {
    //               _showLegendLabel = val;
    //             });
    //           },
    //         ),
    //         ListTile(
    //           title: Text("legendShape"),
    //           trailing: Padding(
    //             padding: const EdgeInsets.symmetric(horizontal: 16.0),
    //             child: DropdownButton<LegendShape>(
    //               value: _legendShape,
    //               items: [
    //                 DropdownMenuItem(
    //                   child: Text("BoxShape.circle"),
    //                   value: LegendShape.Circle,
    //                 ),
    //                 DropdownMenuItem(
    //                   child: Text("BoxShape.rectangle"),
    //                   value: LegendShape.Rectangle,
    //                 ),
    //               ],
    //               onChanged: (val) {
    //                 setState(() {
    //                   _legendShape = val;
    //                 });
    //               },
    //             ),
    //           ),
    //         ),
    //         ListTile(
    //           title: Text("legendPosition"),
    //           trailing: Padding(
    //             padding: const EdgeInsets.symmetric(horizontal: 16.0),
    //             child: DropdownButton<LegendPosition>(
    //               value: _legendPosition,
    //               items: [
    //                 DropdownMenuItem(
    //                   child: Text("left"),
    //                   value: LegendPosition.left,
    //                 ),
    //                 DropdownMenuItem(
    //                   child: Text("right"),
    //                   value: LegendPosition.right,
    //                 ),
    //                 DropdownMenuItem(
    //                   child: Text("top"),
    //                   value: LegendPosition.top,
    //                 ),
    //                 DropdownMenuItem(
    //                   child: Text("bottom"),
    //                   value: LegendPosition.bottom,
    //                 ),
    //               ],
    //               onChanged: (val) {
    //                 setState(() {
    //                   _legendPosition = val;
    //                 });
    //               },
    //             ),
    //           ),
    //         ),
    //         ListTile(
    //           title: Text(
    //             'Chart values Options'.toUpperCase(),
    //             style: Theme.of(context).textTheme.overline!.copyWith(
    //               fontSize: 12,
    //               fontWeight: FontWeight.bold,
    //             ),
    //           ),
    //         ),
    //         SwitchListTile(
    //           value: _showChartValueBackground,
    //           title: Text("showChartValueBackground"),
    //           onChanged: (val) {
    //             setState(() {
    //               _showChartValueBackground = val;
    //             });
    //           },
    //         ),
    //         SwitchListTile(
    //           value: _showChartValues,
    //           title: Text("showChartValues"),
    //           onChanged: (val) {
    //             setState(() {
    //               _showChartValues = val;
    //             });
    //           },
    //         ),
    //         SwitchListTile(
    //           value: _showChartValuesInPercentage,
    //           title: Text("showChartValuesInPercentage"),
    //           onChanged: (val) {
    //             setState(() {
    //               _showChartValuesInPercentage = val;
    //             });
    //           },
    //         ),
    //         SwitchListTile(
    //           value: _showChartValuesOutside,
    //           title: Text("showChartValuesOutside"),
    //           onChanged: (val) {
    //             setState(() {
    //               _showChartValuesOutside = val;
    //             });
    //           },
    //         ),
    //       ],
    //     ),
    //   ),
    // );
    return Scaffold(
      appBar: AppBar(
        title: Text("Expanded"
        ,
        style: TextStyle(
          color: Colors.white
        ),),


      ),
      body: LayoutBuilder(
        builder: (_, constraints) {
          if (constraints.maxWidth >= 200) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: chart,
                ),
                Flexible(
                  flex: 2,
                  fit: FlexFit.tight,
                  child: Text(
                    "123123123123123"
                  )
                )
              ],
            );
          } else {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    child: chart,
                    margin: EdgeInsets.symmetric(
                      vertical: 32,
                    ),
                  ),
                  // settings,
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

