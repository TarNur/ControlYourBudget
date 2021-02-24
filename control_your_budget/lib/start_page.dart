import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'icon_content.dart';
import 'reusable_card.dart';
import 'constants.dart';

enum WhichButton {
  startNewBudget,
  viewYourBudgets,
  settings,
  none,
}

class StartPage extends StatefulWidget {
  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  WhichButton pressed;

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
            child: ReusableCard(
                colour: pressed == WhichButton.startNewBudget
                    ? kActiveCardColour
                    : kInactiveCardColour,
                cardChild: IconContent(
                  icon: FontAwesomeIcons.folderPlus,
                  label: 'Start new Budget',
                ),
                onPress: () {
                  setState(() {
                    pressed = WhichButton.startNewBudget;
                    Navigator.pushNamed(context, '/first');
                  });
                }),
          ),
          Expanded(
            child: ReusableCard(
                colour: pressed == WhichButton.viewYourBudgets
                    ? kActiveCardColour
                    : kInactiveCardColour,
                cardChild: IconContent(
                  icon: FontAwesomeIcons.folderOpen,
                  label: 'View your Budgets',
                ),
                onPress: () {
                  setState(() {
                    pressed = WhichButton.viewYourBudgets;
                    Navigator.pushNamed(context, '/second');
                  });
                }),
          ),
          Expanded(
            child: ReusableCard(
                colour: pressed == WhichButton.settings
                    ? kActiveCardColour
                    : kInactiveCardColour,
                cardChild: IconContent(
                  icon: FontAwesomeIcons.cog,
                  label: 'Settings',
                ),
                onPress: () {
                  setState(() {
                    pressed = WhichButton.settings;
                    Navigator.pushNamed(context, '/third');
                  });
                }),
          ),
          Container(
              color: kBottomContainerColour,
              margin: EdgeInsets.only(top: 10.0),
              width: double.infinity,
              height: kBottomContainerHeight),
        ],
      ),
    );
  }
}
