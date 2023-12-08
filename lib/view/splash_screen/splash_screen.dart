import 'package:flutter/material.dart';
import 'package:quiz_app_api/view/question_listing_page/question_page.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF481450),
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Center(
          child: Image.asset(
            'assets/images/quiz_time.png',
            width: 300,
            height: 300,
          ),
        ),
        Center(
          child: InkWell(
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => QuestionPage(),)),
            child: Container(
              height: 50,
              width: 100,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.deepPurple,
                  borderRadius: BorderRadius.circular(20)),
              child: Center(
                  child: Text(
                'Get Started',
                style: TextStyle(color: Colors.white),
              )),
            ),
          ),
        )
      ]),
    );
  }
}
