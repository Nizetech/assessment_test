import 'package:assessment_test/chat_list.dart';
import 'package:assessment_test/home_screen.dart';
import 'package:assessment_test/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  late PersistentTabController _controller;
  late bool _hideNavBar;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController();
    _hideNavBar = false;
  }

  List<PersistentBottomNavBarItem> _navBarsItems() => [
        PersistentBottomNavBarItem(
          icon: const Icon(IconlyBold.home),
          title: "Home",
          activeColorPrimary: mainColor,
          activeColorSecondary: Colors.white,
          inactiveColorPrimary: grey,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.mail),
          title: "Chat",
          activeColorPrimary: mainColor,
          activeColorSecondary: Colors.white,
          inactiveColorPrimary: grey,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(IconlyBold.location),
          title: "Location",
          activeColorPrimary: mainColor,
          activeColorSecondary: Colors.white,
          inactiveColorPrimary: grey,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(IconlyBold.profile),
          title: "Profile",
          activeColorPrimary: mainColor,
          activeColorSecondary: Colors.white,
          inactiveColorPrimary: grey,
        ),
      ];
  List<Widget> buildScreens = [
    HomeScreen(),
    ChatScreen(),
    HomeScreen(),
    HomeScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PersistentTabView(
        context,
        controller: _controller,
        screens: buildScreens,
        items: _navBarsItems(),
        resizeToAvoidBottomInset: true,
     
        navBarHeight: 70,

        bottomScreenMargin: 0,
        backgroundColor: Colors.white,
        hideNavigationBar: _hideNavBar,
        decoration: const NavBarDecoration(colorBehindNavBar: Colors.indigo),
       
        screenTransitionAnimation: const ScreenTransitionAnimation(
          animateTabTransition: true,
        ),
        navBarStyle:
            NavBarStyle.style7, 
      ),
    );
  }
}
