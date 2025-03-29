import 'package:get/get.dart';

class BottomBarController extends GetxController{
  var selectedIndex = 2.obs;

  void onItemTapped(int index) {
    selectedIndex.value = index;
  }
}