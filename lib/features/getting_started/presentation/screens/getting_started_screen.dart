import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class GettingStartedScreen extends StatefulWidget {
  const GettingStartedScreen({super.key});

  @override
  State<GettingStartedScreen> createState() => _GettingStartedScreenState();
}

class _GettingStartedScreenState extends State<GettingStartedScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> pages = [
    {
      'image': 'assets/images/podcast_avatar.png',
      'title': 'Podkes',
      'desc':
      'A podcast is an episodic series of spoken word digital audio files that a user can download to a personal device for easy listening.',
    },
    {
      'image': 'assets/images/another_podcast_image.png',
      'title': 'Discover',
      'desc':
      'Discover trending podcasts and new creators with one simple swipe.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double screenHeight = size.height;
    final double screenWidth = size.width;

    return Scaffold(
      backgroundColor: const Color(0xFF0D0C1D),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: screenHeight * 0.08),

            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: pages.length,
                onPageChanged: (index) {
                  setState(() => _currentPage = index);
                },
                itemBuilder: (context, index) {
                  final page = pages[index];
                  return Column(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                        ),
                        child: Image.asset(
                          page['image']!,
                          height: screenHeight * 0.35,
                          width: screenWidth * 0.55,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.04),
                      Text(
                        page['title']!,
                        style: TextStyle(
                          fontSize: screenWidth * 0.07,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.1,
                        ),
                        child: Text(
                          page['desc']!,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: screenWidth * 0.035,
                            color: Colors.white60,
                            height: 1.5,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),

            SizedBox(height: screenHeight * 0.03),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(pages.length, (index) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color:
                    _currentPage == index ? Colors.purple : Colors.white30,
                  ),
                );
              }),
            ),

            SizedBox(height: screenHeight * 0.1),

            GestureDetector(
              onTap: () {
                if (_currentPage == pages.length - 1) {
                  context.go('/explore');
                } else {
                  _pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                }
              },
              child: Container(
                height: screenWidth * 0.16,
                width: screenWidth * 0.16,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(
                  Icons.arrow_forward,
                  color: Colors.purple,
                ),
              ),
            ),

            SizedBox(height: screenHeight * 0.04),
          ],
        ),
      ),
    );
  }
}
