import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:control_your_budget/components/icon_content.dart';
import 'package:control_your_budget/components/reusable_card.dart';
import 'package:control_your_budget/constants.dart';

class StartPage extends StatefulWidget {
  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CONTROL YOUR BUDGET'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 1,
            child: ReusableCard(
                colour: kInactiveCardColour,
                cardChild: IconContent(
                  icon: FontAwesomeIcons.folderOpen,
                  label: 'Your Budgets',
                ),
                onPress: () {
                  setState(() {
                  });
                }),
          ),
          Expanded(
            flex: 5,
            child: ReusableCard(
                colour: kInactiveCardColour,
                onPress: () {
                  setState(() {
                  });
                }),
          ),
          Container(
              color: kBottomContainerColourStart,
              margin: EdgeInsets.only(top: 10.0),
              width: double.infinity,
              height: kBottomContainerHeight),
        ],
      ),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Settings'),
            ),
            ListTile(
              title: Text('Mingi setting'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Mingi setting 2'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton( // Create New Budget Button
        onPressed: () {
          Navigator.pushNamed(context, '/first');
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.cyanAccent,
      ),
    );
  }
}
