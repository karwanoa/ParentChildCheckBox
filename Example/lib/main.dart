import 'package:flutter/material.dart';
import 'package:parent_child_checkbox/ParentChildCheckBox.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        primaryColor: Colors.deepPurple,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Parent Child CheckBox Demo'),
      ),
      body: ListView(
        children: [
          ParentChildCheckBox(
            parentTitle: 'Favourite Fast Food Chain',
            parentTitleStyle: TextStyle(
              fontWeight: FontWeight.bold,
            ),
            parentDefaultValue: true,
            parentDecoration: BoxDecoration(
              color: Colors.grey.shade300,
            ),
            childrenTitle: ['McDonald', 'Subway', 'BurgerKing'],
            childrenTitleStyle: TextStyle(fontStyle: FontStyle.italic),
            childrenDefaultValue: true,
            // childrenDecoration: BoxDecoration(
            //   color: Colors.grey.shade100,
            // ),
            childrenHorizontalPadding: 20,
            isTristate: true,
            activeColor: Colors.black,
            checkColor: Colors.yellow,
            controlAffinity: ListTileControlAffinity.leading,
            onChange: (bool parentValue, List<bool> childrenValue) {
              debugPrint('Parent value : ' + parentValue.toString());
              debugPrint('Children value : ' + childrenValue.toString());
            },
          ),
        ],
      ),
    );
  }
}
