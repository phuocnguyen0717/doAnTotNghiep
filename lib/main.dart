import 'package:endgame/pages/details/expensed.dart';
import 'package:endgame/pages/security.dart';
import 'package:endgame/pages/splash.dart';
import 'package:endgame/theme.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('money');
  runApp(
      const MyApp(
      ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Money Manager',
      theme: myTheme,
      home:  ExpansedChart(),
    );
  }
}

