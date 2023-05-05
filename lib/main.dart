
import 'package:akjol/widgets/buttom_navigator.dart';
import 'package:flutter/material.dart';
final scaffoldKey = GlobalKey<ScaffoldMessengerState>();

void main()  {

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: scaffoldKey,
      debugShowCheckedModeBanner: false,
      title: 'Akjol',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const BottomNavigatorScreen(),
    );
  }
}