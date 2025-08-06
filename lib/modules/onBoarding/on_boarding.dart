import 'package:event_app/core/route/app_route.dart';
import 'package:event_app/core/route/route_name.dart';
import 'package:event_app/modules/onBoarding/wedgits/on_boarding_wedgit.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../core/constants/colors.dart';
import '../../layout.dart';


class OnboardingScreen extends StatefulWidget {
  static const routName = '/boarding';

  const OnboardingScreen({super.key});
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  bool isLastPage = false;


  final List<Widget> pages = [
    OnBoardingContainer(
      boardingnum: 1,
      title: "Personalize Your Experience",
      description: "Choose your preferred theme and language to get started with a comfortable, tailored experience that suits your style.",
    ),
    OnBoardingContainer(
      boardingnum: 2,
      title: "Find Events That Inspire You",
      description: "Dive into a world of events crafted to fit your unique interests. Whether you're into live music, art workshops, professional networking, or simply discovering new experiences, we have something for everyone. Our curated recommendations will help you explore, connect, and make the most of every opportunity around you.",
    ),

    OnBoardingContainer(
      boardingnum: 3,
      title: "Effortless Event Planning",
      description: "Take the hassle out of organizing events with our all-in-one planning tools. From setting up invites and managing RSVPs to scheduling reminders and coordinating details, we’ve got you covered. Plan with ease and focus on what matters – creating an unforgettable experience for you and your guests.",
    ),

    OnBoardingContainer(
      boardingnum: 4,
      title: "Connect with Friends & Share Moments",
      description: "Make every event memorable by sharing the experience with others. Our platform lets you invite friends, keep everyone in the loop, and celebrate moments together. Capture and share the excitement with your network, so you can relive the highlights and cherish the memories.",
    ),
  ];


  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void goToHome() {
    Navigator.pushReplacementNamed(context, RouteNames.layout);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _controller,
            itemCount: pages.length,
            onPageChanged: (index) {
              setState(() {
                isLastPage = index == pages.length - 1;
              });
            },
            itemBuilder: (_, index) => pages[index],
          ),




          Positioned(
            bottom: 20,
            left: 20,
            child: TextButton(
              child: Text("Back",style: TextStyle(color: TColors.primary),),
              onPressed: () {
                if (_controller.page! > 0) {
                  _controller.previousPage(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                }
              },
            ),
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: TextButton(
              child: Text(isLastPage ? "Done" : "Next",style: TextStyle(color: TColors.primary),),
              onPressed: () {
                if (isLastPage) {
                  goToHome();
                } else {
                  _controller.nextPage(
                    duration: Duration(milliseconds: 100),
                    curve: Curves.easeInOut,
                  );
                }
              },
            ),
          ),
          Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: Center(
              child: SmoothPageIndicator(
                
                controller: _controller,
                count: pages.length,
                effect: WormEffect(
                  dotHeight: 10,
                  dotWidth: 10,
                  spacing: 16,
                  activeDotColor: TColors.primary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
