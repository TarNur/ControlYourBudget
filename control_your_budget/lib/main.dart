import 'package:flutter/material.dart';
import 'start_page.dart';
import 'newBudget_page.dart';
import 'viewBudget_page.dart';
import 'settings_page.dart';

void main() => runApp(ControlYourBudget());

class ControlYourBudget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith( // App-i main värvid(theme)
        primaryColor: Color(0xFF0A0E21),
        scaffoldBackgroundColor: Color(0xFF0A0E21),
        accentColor: Colors.cyanAccent,
        textTheme: TextTheme(bodyText2: TextStyle(color: Colors.white))
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
