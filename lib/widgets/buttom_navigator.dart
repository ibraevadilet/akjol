import 'package:akjol/features/home/home_screen.dart';
import 'package:akjol/features/profile/profile_screen.dart';
import 'package:akjol/helpers/app_colors.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class BottomNavigatorScreen extends StatefulWidget {
  const BottomNavigatorScreen({Key? key}) : super(key: key);

  @override
  State<BottomNavigatorScreen> createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigatorScreen> {
  // int index = 0;
  int _page = 0;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: pages[_page],
      bottomNavigationBar: 
      
      CurvedNavigationBar(
          key: _bottomNavigationKey,
          index: 0,
          height: 60.0,
          items: <Widget>[
            Icon(Icons.add, size: 30),
            Icon(Icons.list, size: 30),
            Icon(Icons.compare_arrows, size: 30),
            Icon(Icons.call_split, size: 30),
            Icon(Icons.perm_identity, size: 30),
          ],
          color: Colors.white,
          buttonBackgroundColor: Colors.white,
          backgroundColor: Colors.blueAccent,
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 600),
          onTap: (index) {
            setState(() {
             _page = index;
            });
          },
          letIndexChange: (index) => true,
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
