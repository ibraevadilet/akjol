import 'package:akjol/features/home/home_screen.dart';
import 'package:akjol/features/profile/profile_screen.dart';
import 'package:akjol/helpers/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class BottomNavigatorScreen extends StatefulWidget {
  const BottomNavigatorScreen({Key? key}) : super(key: key);

  @override
  State<BottomNavigatorScreen> createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigatorScreen> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: pages[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              rippleColor: Color.fromARGB(255, 172, 166, 255),
              hoverColor: Color.fromARGB(255, 166, 167, 255),
              tabBackgroundColor: Color.fromARGB(255, 166, 167, 255),
              gap: 8,
              activeColor: Colors.black87,
              iconSize: 24,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: Duration(milliseconds: 400),
              color: Colors.black54,
              tabs: [
                GButton(
                  icon: Icons.map_outlined,
                  text: 'Карта',
                ),
                GButton(
                  icon: Icons.person_outlined,
                  text: 'Профиль',
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
        ),
      ),

      // ClipRRect(
      //   borderRadius: const BorderRadius.only(
      //     topLeft: Radius.circular(0),
      //     topRight: Radius.circular(0),
      //   ),
      //   child: BottomNavigationBar(
      //     backgroundColor: AppColors.color4CADEABlue,
      //     type: BottomNavigationBarType.fixed,
      //     unselectedFontSize: 10,
      //     selectedFontSize: 10,
      //     selectedLabelStyle: const TextStyle(
      //       fontWeight: FontWeight.w700,
      //       fontSize: 13,
      //     ),
      //     unselectedLabelStyle: const TextStyle(
      //       fontWeight: FontWeight.w700,
      //       fontSize: 13,
      //     ),
      //     selectedItemColor: AppColors.white,
      //     unselectedItemColor: AppColors.white.withOpacity(0.5),
      //     currentIndex: index,
      //     onTap: (indexFrom) async {
      //       setState(() {
      //         index = indexFrom;
      //       });
      //     },
      //     items: [
      //       BottomNavigationBarItem(
      //         activeIcon: const Icon(
      //           Icons.home,
      //           color: Colors.white,
      //         ),
      //         icon: Icon(
      //           Icons.home,
      //           color: Colors.white.withOpacity(0.5),
      //         ),
      //         label: 'main',
      //       ),
      //       BottomNavigationBarItem(
      //         activeIcon: const Icon(
      //           Icons.person,
      //           color: Colors.white,
      //         ),
      //         icon: Icon(
      //           Icons.person,
      //           color: Colors.white.withOpacity(0.5),
      //         ),
      //         label: "profile",
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}

List<Widget> pages = [
  const HomeScreen(),
  const ProfileScreen(),
];
