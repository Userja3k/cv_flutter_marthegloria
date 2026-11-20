import 'package:flutter/material.dart';

import '../widgets/custom_nav_bar.dart';
import 'contact_page.dart';
import 'family_page.dart';
import 'home_page.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  final List<Widget> _pages = const [HomePage(), FamilyPage(), ContactPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: CustomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
      ),
    );
  }
}
