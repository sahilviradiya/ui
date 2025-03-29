import 'package:get/get.dart';
import 'package:flutter/material.dart';

class HomeScreenController extends GetxController {
  var currentIndex = 0.obs;
  PageController pageController = PageController();

  void changePage(int index) {
    currentIndex.value = index;
    pageController.animateToPage(
      index,
      duration: Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }
}

class IndicatorController extends GetxController {
  RxInt activeIndex = 0.obs;

  void updateIndex(int index) {
    activeIndex.value = index;
  }
}
