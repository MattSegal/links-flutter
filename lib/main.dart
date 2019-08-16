import 'package:flutter/material.dart';

import 'home.dart';

void main() => runApp(MyApp());

const PrimaryColor = Color(0xFFEEEEEE);
var theme = ThemeData(
  primaryColor: PrimaryColor,
);

class MyApp extends StatelessWidget {
  build(context) {
    return MaterialApp(
      title: 'Matt\'s Links',
      theme: theme,
      home: HomePage(),
    );
  }
}
