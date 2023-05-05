import 'package:akjol/features/home/home_screen.dart';
import 'package:akjol/features/profile/home_screen.dart';
import 'package:akjol/helpers/app_colors.dart';
import 'package:flutter/material.dart';

class BottomNavigatorScreen extends StatefulWidget {
  const BottomNavigatorScreen({Key? key}) : super(key: key);

  @override
  State<BottomNavigatorScreen> createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigatorScreen> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: pages[index],
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(0),
          topRight: Radius.circular(0),
        ),
        child: BottomNavigationBar(
          backgroundColor: AppColors.color4CADEABlue,
          type: BottomNavigationBarType.fixed,
          unselectedFontSize: 10,
          selectedFontSize: 10,
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 13,
          ),
          unselectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 13,
          ),
          selectedItemColor: AppColors.white,
          unselectedItemColor: AppColors.white.withOpacity(0.5),
          currentIndex: index,
          onTap: (indexFrom) async {
            setState(() {
              index = indexFrom;
            });
          },
          items: [
            BottomNavigationBarItem(
              activeIcon: const Icon(
                Icons.home,
                color: Colors.white,
              ),
              icon: Icon(
                Icons.home,
                color: Colors.white.withOpacity(0.5),
              ),
              label: 'main',
            ),
            BottomNavigationBarItem(
              activeIcon: const Icon(
                Icons.person,
                color: Colors.white,
              ),
              icon: Icon(
                Icons.person,
                color: Colors.white.withOpacity(0.5),
              ),
              label: "profile",
            ),
          ],
        ),
      ),
    );
  }
}

List<Widget> pages = [
  const HomeScreen(),
  const ProfileScreen(),
];
