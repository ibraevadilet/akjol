
import 'package:akjol/features/authorization/screens/signin_screen.dart';
import 'package:akjol/firebase_options.dart';
//import 'package:akjol/widgets/buttom_navigator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
final scaffoldKey = GlobalKey<ScaffoldMessengerState>();

void main() async {
 WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
      home: AuthorizationScreen(),//const BottomNavigatorScreen(),
    );
  }
}