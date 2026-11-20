import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class CustomNavBar extends StatelessWidget {
  const CustomNavBar({
    required this.currentIndex,
    required this.onTap,
    super.key,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
      height: 80,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final itemWidth = constraints.maxWidth / 3;
          return Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: 70,
                margin: const EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                  color: AppColors.navBarDark,
                  borderRadius: BorderRadius.circular(35),
                ),
              ),
              AnimatedPositioned(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                top: 0,
                left: itemWidth * (currentIndex + 0.5) - 30,
                width: 60,
                height: 60,
                child: Container(
                  decoration: const BoxDecoration(
                    color: AppColors.background,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: const BoxDecoration(
                        color: AppColors.navBarDark,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        _iconForIndex(currentIndex),
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                children: List.generate(3, (index) {
                  return Expanded(
                    child: Semantics(
                      button: true,
                      selected: index == currentIndex,
                      label: _labelForIndex(index),
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () => onTap(index),
                        child: SizedBox(
                          height: 70,
                          child: index == currentIndex
                              ? const SizedBox.shrink()
                              : Icon(
                                  _iconForIndex(index),
                                  color: Colors.white54,
                                  size: 26,
                                ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ],
          );
        },
      ),
    );
  }

  static IconData _iconForIndex(int index) {
    switch (index) {
      case 0:
        return Icons.home_rounded;
      case 1:
        return Icons.people_rounded;
      case 2:
        return Icons.contact_page_rounded;
      default:
        return Icons.home_rounded;
    }
  }

  static String _labelForIndex(int index) {
    switch (index) {
      case 0:
        return 'Accueil';
      case 1:
        return 'Famille';
      case 2:
        return 'Contact';
      default:
        return 'Accueil';
    }
  }
}
