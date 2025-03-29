import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../theme/color/colors.dart';
import 'controller/home_screen_controller.dart';
import 'edit_screen.dart';
import 'insta.dart';

class DottedIndicator extends StatelessWidget {
  final int itemCount;
  final IndicatorController controller = Get.put(IndicatorController());

  DottedIndicator({required this.itemCount});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 16,
      top: MediaQuery.of(context).size.height * 0.2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(itemCount, (index) {
          return Obx(() => Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: controller.activeIndex.value == index
                        ? Colors.green
                        : Colors.white,
                  ),
                ),
              ));
        }),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final PageController pageController = PageController();
  final RxInt currentPageIndex = 0.obs;
  final IndicatorController indicatorController =
      Get.put(IndicatorController());

  final List<Map<String, String>> contentList = [
    {
      "image": "assets/png/IMG_1.png",
      "description":
          "💄Elevate your beauty with the Giordani Gold - Eternal Glow Lipstick SPF 25! This luxurious creamy lipstick doesn't just promise rich pigments but brings you the benefits of hyaluronic acid and collagen-boosting peptides too. Pamper your lips with care while enjoying a long-lasting, luminous matte colour. 💋 ✨ #Oriflame #GiordaniGold #LipCareGoalsUse my referral code: UK-AMANDA3012Use my referral link: www.oriflame.com/giordani/amada3012",
      "music": "Bad Habits by Ed Sheeran"
    },
    {
      "image": "assets/png/IMG_2.png",
      "description":
          "✨ Experience the elegance of Eclat Amour—a fragrance that captures the essence of romance and sophistication. Let every spritz wrap you in timeless charm and effortless allure. 💕 #EclatAmour #TimelessEleganceUse my referral code: UK-AMANDA3012 Use my referral link: www.oriflame.com/giordani/amada3012",
      "music": "Unstoppable by Sia"
    },
    {
      "image": "assets/png/IMG_3.png",
      "description":
          "Unlock the power of bold, beautiful lashes! With WonderLash Mascara, get ultimate length, volume, and definition for a stunning, eye-catching look. One swipe is all it takes! 💖 #WonderLash #LashesForDays Use my referral code: UK-AMANDA3012 Use my referral link: www.oriflame.com/giordani/amada3012",
      "music": "Vogue by Madonna"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4, // Number of tabs
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(
                'assets/jpg/logo.jpeg',
                width: MediaQuery.of(context).size.width * 0.6,
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: _buildCameraButton(),
              ),
            ),
            // Added TabBar
            Container(
              color: Colors.white,
              width: double.infinity, // Ensures it takes the full width
              child: TabBar(
                isScrollable: false,
                labelColor: Colors.green,
                unselectedLabelColor: Colors.black,
                indicatorColor: Colors.green,
                indicatorSize: TabBarIndicatorSize.label,
                labelStyle: TextStyle(fontWeight: FontWeight.bold),
                tabs: [
                  Tab(text: "Smart Post"),
                  Tab(text: "Library"),
                  Tab(text: "Communities"),
                  Tab(text: "Share & Win"),
                ],
              ),
            ),
            Expanded(
              child: Stack(
                children: [
                  PageView.builder(
                    controller: pageController,
                    scrollDirection: Axis.vertical,
                    physics: BouncingScrollPhysics(),
                    itemCount: contentList.length,
                    onPageChanged: (index) {
                      currentPageIndex.value = index;
                      indicatorController.updateIndex(index);
                    },
                    itemBuilder: (context, index) {
                      return _buildReelItem(contentList[index], context);
                    },
                  ),
                  DottedIndicator(itemCount: contentList.length),
                  Positioned(
                    bottom: 70,
                    left: 0,
                    right: 0, // Ensures it spans the screen width
                    child: SizedBox(
                      height: 50, // Adjust height as needed
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            SizedBox(width: 16), // Padding from left
                            Text(
                              'Quick share to:',
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(width: 10),
                            Image.asset('assets/png/soc1.png', width: 35),
                            SizedBox(width: 10),
                            InkWell(
                                onTap: () {
                                  showLoadingDialog(context);
                                },
                                child: Image.asset('assets/png/soc10.png',
                                    width: 35)),
                            SizedBox(width: 10),
                            Image.asset('assets/png/soc2.png', width: 35),
                            SizedBox(width: 10),
                            Image.asset('assets/png/soc11.png', width: 35),
                            SizedBox(width: 10),
                            Image.asset('assets/png/soc3.png', width: 35),
                            SizedBox(width: 10),
                            Image.asset('assets/png/soc4.png', width: 35),
                            SizedBox(width: 16),
                            Image.asset('assets/png/soc5.png', width: 35),
                            SizedBox(width: 16),
                            Image.asset('assets/png/soc6.png', width: 35),
                            SizedBox(width: 16),
                            Image.asset('assets/png/soc7.png', width: 35),
                            SizedBox(width: 16),
                            Image.asset('assets/png/soc8.png', width: 35),
                            SizedBox(width: 16),
                            Image.asset('assets/png/soc9.png', width: 35),
                            SizedBox(width: 16),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReelItem(Map<String, String> content, BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            content["image"]!,
            fit: BoxFit.cover,
          ),
        ),
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.black.withOpacity(0.7),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),
        Positioned(
            top: 10,
            left: 10,
            child: Row(
              children: [
                ClipRRect(
                  child: Image.asset('assets/png/image.png'),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Image.asset('assets/png/Tag.png'),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.32,
                          ),
                          Obx(() => Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 12,
                                ),
                                decoration: BoxDecoration(
                                  color: grey,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  "${currentPageIndex.value + 1} of ${contentList.length}",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                ),
                              )),
                        ]),
                    Text(
                      'High-converting in Oriflame Community',
                      style: TextStyle(color: white),
                    )
                  ],
                )
              ],
            )),
        Positioned(
          bottom: 150,
          left: 16,
          right: 16,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                    color: grey, borderRadius: BorderRadius.circular(8)),
                child: Row(
                  children: [
                    Icon(
                      Icons.music_note,
                      color: white,
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Recommended : ',
                            style: TextStyle(
                              color: white,
                              fontSize: 14,
                            ),
                          ),
                          TextSpan(
                            text: content["music"]!,
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 5),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditCaptionScreen(
                        caption: content["description"]!,
                        onSave: (newCaption) {
                          content["description"] = newCaption;
                        },
                      ),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: grey,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    content["description"]!,
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCameraButton() {
    return Container(
      decoration: BoxDecoration(
        color: customGreen,
        borderRadius: BorderRadius.circular(50),
      ),
      child: IconButton(
        onPressed: () {
        },
        icon: Icon(Icons.camera_alt, size: 25, color: Colors.white),
      ),
    );
  }
}

void showLoadingDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return LoadingDialog();
    },
  );
}

class LoadingDialog extends StatefulWidget {
  @override
  _LoadingDialogState createState() => _LoadingDialogState();
}

class _LoadingDialogState extends State<LoadingDialog> {
  List<String> messages = [
    "Generating your sales link..",
    "Copying the caption to clipboard",
    "Saving the content to your profile",
    "Preparing the content for social media"
  ];
  int currentIndex = 0;
  double progress = 0.0;

  @override
  void initState() {
    super.initState();
    startProgress();
  }

  void startProgress() {
    Timer.periodic(Duration(seconds: 2), (timer) {
      if (currentIndex < messages.length - 1) {
        setState(() {
          currentIndex++;
          progress += 0.25;
        });
      } else {
        timer.cancel();
        Get.offAll(Insta());
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    return AlertDialog(
      backgroundColor: white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset('assets/png/progressbar.png'),
          SizedBox(height: 20),
          Text(messages[currentIndex], textAlign: TextAlign.center),
          SizedBox(height: 20),
          SizedBox(
            height: 10,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: progress,
                backgroundColor: Colors.grey.shade300,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
              ),
            ),
          )
        ],
      ),
    );
  }
}
