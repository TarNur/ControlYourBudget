import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'icon_content.dart';
import 'reusable_card.dart';

const bottomContainerHeight = 20.0;
const inactiveCardColour = Color(0xFF1D1E33);
const activeCardColour = Color(0xFF111328);
const bottomContainerColour = Color(0xFF1D1E33);

enum WhichButton{
  startNewBudget,
  viewYourBudgets,
  settings,
}

class StartPage extends StatefulWidget {
  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {

  Color startNewBudgetColour = inactiveCardColour;
  Color viewBudgetsColour = inactiveCardColour;
  Color settingsColour = inactiveCardColour;

  void updateColour(WhichButton pressed) {
    if (pressed == WhichButton.startNewBudget) {
      if (startNewBudgetColour == inactiveCardColour) {
        settingsColour = inactiveCardColour;
        viewBudgetsColour = inactiveCardColour;
        startNewBudgetColour = activeCardColour;
      } else {
        startNewBudgetColour = inactiveCardColour;
      }
    } 
    if (pressed == WhichButton.viewYourBudgets) {
      if (viewBudgetsColour == inactiveCardColour) {
        settingsColour = inactiveCardColour;
        viewBudgetsColour = activeCardColour;
        startNewBudgetColour = inactiveCardColour;
      } else {
        viewBudgetsColour = inactiveCardColour;
      }
    } 
    if (pressed == WhichButton.settings) {
      if (settingsColour == inactiveCardColour) {
        settingsColour = activeCardColour;
        viewBudgetsColour = inactiveCardColour;
        startNewBudgetColour = inactiveCardColour;
      } else {
        settingsColour = inactiveCardColour;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CONTROL YOUR BUDGET'),
      ),
      body: Column(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(
                  () {
                    updateColour(WhichButton.startNewBudget);
                  },
                );
              },
              child: ReusableCard(
                startNewBudgetColour,
                IconContent(
                  icon: FontAwesomeIcons.folderPlus,
                  label: 'Start new Budget',
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(
                  () {
                    updateColour(WhichButton.viewYourBudgets);
                  },
                );
              },
              child: ReusableCard(
                viewBudgetsColour,
                IconContent(
                  icon: FontAwesomeIcons.folderOpen,
                  label: 'View your Budgets',
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(
                  () {
                    updateColour(WhichButton.settings);
                  },
                );
              },
              child: ReusableCard(
                settingsColour,
                IconContent(
                  icon: FontAwesomeIcons.cog,
                  label: 'Settings',
                ),
              ),
            ),
          ),
          Container(
              color: bottomContainerColour,
              margin: EdgeInsets.only(top: 10.0),
              width: double.infinity,
              height: bottomContainerHeight),
        ],
      ),
    );
  }
}
