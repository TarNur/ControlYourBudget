import 'package:flutter/material.dart';
import 'package:control_your_budget/screens/newBudget_page.dart';
import 'package:control_your_budget/screens/settings_page.dart';
import 'package:control_your_budget/screens/start_page.dart';
import 'package:control_your_budget/screens/viewBudget_page.dart';
import 'package:flutter/services.dart';

void main() => runApp(ControlYourBudget());

class ControlYourBudget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
      ]);

    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        // App-i main värvid(theme)
        primaryColor: Color(0xFF0A0E21),
        scaffoldBackgroundColor: Color(0xFF0A0E21),
        accentColor: Colors.cyanAccent,
        textTheme: TextTheme(
          bodyText2: TextStyle(color: Colors.white),
        ),
      ),
      home: StartPage(),
      routes: {
        '/first': (context) => NewBudget(),
        '/second': (context) => ViewBudgets(),
        '/third': (context) => Settings(),
      },
    );
  }
}
