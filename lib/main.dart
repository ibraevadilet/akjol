import 'package:akjol/core/save_person_data.dart';
import 'package:akjol/features/role/role_screen.dart';
import 'package:akjol/firebase_options.dart';
import 'package:akjol/widgets/buttom_navigator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

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
      home: AnimatedSplashScreen(
        splash: 'assets/images/wheel.png',
        nextScreen: FutureBuilder(
          future: SavePersonData.getUserId(),
          builder: (context, AsyncSnapshot<String?> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.isNotEmpty) {
                return BottomNavigatorScreen();
              }
            }
            return RoleScreen();
          },
        ),
        splashIconSize: 150,
        splashTransition: SplashTransition.slideTransition,
      ),
    );
  }
}
