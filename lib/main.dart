import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'features/authentication/register_page.dart';
import 'features/authentication/login_page.dart';

void main() {
  runApp(KwizzleApp());
}

class KwizzleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kwizzle',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.light(
          primary: Color(0xFF1EB8D1),
          secondary: Color(0xFF283466),
        ),
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Roboto',
      ),
      home: OnboardingPage(),
      routes: {
        '/register': (context) => RegisterPage(),
        '/login': (context) => LoginPage(),
      },
    );
  }
}

class OnboardingPage extends StatefulWidget {
  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: _pageController,
                children: [
                  _buildOnboardingPage(
                    image: 'assets/image/logo1.svg', // Path to your SVG logo
                    title:
                        'Create, share and play quizzes\nwhenever and wherever you want',
                  ),
                  _buildOnboardingPage(
                    image: 'assets/image/logo1.svg', // Path to your SVG logo
                    title:
                        'Find fun and interesting quizzes\nto boost up your knowledge',
                  ),
                  _buildOnboardingPage(
                    image: 'assets/image/logo1.svg', // Path to your SVG logo
                    title:
                        'Play and take quiz challenges\ntogether with your friends',
                  ),
                ],
              ),
            ),
            _buildPageIndicator(),
            _buildButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildOnboardingPage({required String image, required String title}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(image, height: 200),
        SizedBox(height: 24),
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFF283466),
          ),
        ),
      ],
    );
  }

  Widget _buildPageIndicator() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [_buildIndicator(0), _buildIndicator(1), _buildIndicator(2)],
      ),
    );
  }

  Widget _buildIndicator(int pageIndex) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      margin: EdgeInsets.symmetric(horizontal: 5),
      height: 8,
      width: pageIndex == _pageController.page?.round() ? 24 : 8,
      decoration: BoxDecoration(
        color:
            pageIndex == _pageController.page?.round()
                ? Color(0xFF1EB8D1)
                : Colors.grey,
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  Widget _buildButtons() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/register');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF1EB8D1),
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              minimumSize: Size(double.infinity, 48),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              'Get Started',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                letterSpacing: 0.5,
              ),
            ),
          ),
          SizedBox(height: 10),
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, '/login');
            },
            child: Text(
              'I Already Have an Account',
              style: TextStyle(color: Color(0xFF283466), fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
