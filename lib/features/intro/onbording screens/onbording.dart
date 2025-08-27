import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../core/constants/colors_app.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _controller = PageController();
  bool isLastPage = false;

  final List<Map<String, String>> pages = [
    {
      "animation": "assets/animations/budget.json",
      "title": "Your Budget, Your Rules",
      "subtitle":
          "Easily track your expenses, plan your budget, and achieve your financial goals.",
    },
    {
      "animation": "assets/animations/spending.json",
      "title": "Track Your Spending",
      "subtitle":
          "Easily record your daily expenses and stay on top of your budget.",
    },
    {
      "animation": "assets/animations/save1.json",
      "title": "Save Smarter",
      "subtitle": "Reduce waste and watch your savings grow effortlessly.",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: PageView.builder(
          controller: _controller,
          itemCount: pages.length,
          onPageChanged: (index) {
            setState(() {
              isLastPage = index == pages.length - 1;
            });
          },
          itemBuilder: (context, index) {
            final page = pages[index];
            return buildPage(
              animation: page["animation"]!,
              title: page["title"]!,
              subtitle: page["subtitle"]!,
              index: index,
              isLast: isLastPage,
            );
          },
        ),
      ),
    );
  }

  Widget buildPage({
    required String animation,
    required String title,
    required String subtitle,
    required int index,
    bool isLast = false,
  }) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(animation, height: 250),
          const SizedBox(height: 30),
          Text(
            title,
            style: TextStyle(
              color: Colors.black,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 15),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16, color: Colors.black54),
          ),
          const SizedBox(height: 30),

          SmoothPageIndicator(
            controller: _controller,
            count: pages.length,
            effect: ExpandingDotsEffect(
              activeDotColor: AppColors.primary,
              dotColor: AppColors.unselected,
              dotHeight: 8,
              dotWidth: 8,
            ),
          ),

          const SizedBox(height: 30),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () {
              if (isLast) {
                Navigator.pushReplacementNamed(context, "/home");
              } else {
                _controller.nextPage(
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeInOut,
                );
              }
            },
            child: Text(
              isLast ? "Get Started" : "Next",
              style: const TextStyle(color: Colors.white, fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }
}
