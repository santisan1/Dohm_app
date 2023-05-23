import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/home/components/body.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'components/bottom_nav_bar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MainScreenState();
  }
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: const HomeBody(),
      bottomNavigationBar: const BottomNavBar(),
    );
  }

  AppBar appBar() {
    return AppBar(
      backgroundColor: const Color.fromARGB(255, 89, 45, 192),
      elevation: 0,
      leading: IconButton(
        icon: SvgPicture.asset('assets/Icons/menu.svg'),
        onPressed: () {},
      ),
    );
  }
}
