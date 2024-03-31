import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:onboarding_screen/screen/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IntroScreen extends StatelessWidget {
  IntroScreen({super.key});
  final List<PageViewModel> pages = [
    PageViewModel(
      title: 'คนที่ไม่รู้',
      body: ':D',
      footer: SizedBox(
        height: 45,
        width: 150,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 8,
          ),
          onPressed: () {},
          child: const Text('นิวๆ'),
        ),
      ),
      image: Image.network(
          'https://random.imagecdn.app/500/440'),
    ),
    PageViewModel(
      title: 'คนที่รู้',
      body: 'X_X',
      footer: SizedBox(
        height: 45,
        width: 150,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 8,
          ),
          onPressed: () {},
          child: const Text('นิวๆ1'),
        ),
      ),
      image: Image.network(
          'https://random.imagecdn.app/500/450'),
    ),
    PageViewModel(
      title: 'คนที่แกล้งทำเป็นรู้',
      body: 'Ttest',
      footer: SizedBox(
        height: 45,
        width: 150,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 8,
          ),
          onPressed: () {},
          child: const Text('Jirapat'),
        ),
      ),
      image: Image.network('https://random.imagecdn.app/500/420'),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        title: const Text('JirapatEz'),
        centerTitle: true,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Color.fromARGB(255, 104, 104, 104),
        child: Column(
          children: [
            const SizedBox(
              height: 24,
            ),
            Expanded(
              child: IntroductionScreen(
                globalBackgroundColor: Color.fromARGB(255, 104, 104, 104),
                pages: pages,
                showSkipButton: true,
                skip: const Text('Skip',
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16.0,
                        color: Colors.black)),
                showDoneButton: true,
                done: const Text('Finish',
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16.0,
                        color: Colors.black)),
                showNextButton: true,
                next: const Icon(Icons.arrow_right),
                onDone: () => onDone(context),
                curve: Curves.bounceOut,
                dotsDecorator: const DotsDecorator(
                    size: Size(10, 10),
                    color: Colors.lightBlue,
                    activeColor: Colors.blue,
                    activeSize: Size.square(15)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onDone(context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('ON_BOARDING', false);

    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => HomeScreen()));
  }
}
