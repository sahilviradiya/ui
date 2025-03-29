import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ui/ui/home_screen/home_screen.dart';
import 'package:ui/ui/tag_page/tag_page.dart';
import '../../theme/color/colors.dart';
import '../../ui/chat_page/chat_page.dart';
import '../../ui/profile_page/profile_page.dart';
import '../../ui/search_page/search_page.dart';
import 'controller/bottom_bar_controller.dart';

class BottomBar extends StatelessWidget {
  BottomBar({super.key});

  final BottomBarController bottomBarController = Get.put(BottomBarController());

  final List<Widget> pages = [
    HomeScreen(),
    HomeScreen(),
    HomeScreen(),
    HomeScreen(),
    HomeScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        body: Obx(
              () => IndexedStack(
            index: bottomBarController.selectedIndex.value,
            children: pages,
          ),
        ),
        bottomNavigationBar: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildNavItem('assets/svg/bet.svg', 0,context),
              _buildNavItem('assets/svg/search.svg', 1,context),
              _buildNavItem('assets/svg/home.svg', 2,context),
              _buildNavItem('assets/svg/message.svg', 3,context),
              _buildNavItem('assets/svg/profile.svg', 4,context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(String svgAsset, int index,BuildContext context) {
    return Obx(() {
      final isSelected = bottomBarController.selectedIndex.value == index;
      return GestureDetector(
        onTap: () => bottomBarController.onItemTapped(index),
        child: Padding(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            child: SvgPicture.asset(
              svgAsset,
              color: isSelected ? white : Colors.white70
            ),
          ),
        ),
      );
    });
  }
}
