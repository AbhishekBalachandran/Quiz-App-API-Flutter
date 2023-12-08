import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app_api/controller/quiz_controller/quiz_controller.dart';
import 'package:quiz_app_api/view/question_listing_page/question_page.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({super.key});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  @override
  void initState() {
    Provider.of<QuizController>(context, listen: false).scoreCalculator();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<QuizController>(context);
    return Scaffold(
      backgroundColor: Color(0xFF481450),
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Center(
          child: Container(
            height: MediaQuery.sizeOf(context).height * 0.4,
            width: MediaQuery.sizeOf(context).width * 0.75,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(30)),
            child: Column(children: [
              Image.network(
                'https://s3-alpha-sig.figma.com/img/0d0b/0589/f92419f24fac60a5f4c4cf74059dba12?Expires=1702857600&Signature=XbfsajInyFVLGrJRF33yYlF1~qE63-FdHMUGL0ivFhDrLB2cZJ5dIRCMAfVF3BoMVsvKSMpDrRrgBuNT1xDY~7YMRKLWaNKc90TLVerkFOGU7aLVD48ZkM2qWONoZRafBB5dsp8ttwAqO4rHYvnvjqbLwIBzk3F-MHUsKG~iOvl5oAL4D36aEVUHv8zJhXpO1FOOGIB8T8eYpSZmjZFxp8vYzvDVyXx0gZKx3wbUeOrRTt4MQHDkrH5Dk2AV25tR3Xli~vGCTpT0NwjErTgRBJ~-nRzwplTLkkDoXviYItSJ21IbRaR0IEXf9isJSKrzN9vuD1IqV5ocd6Cn9R5x1Q__&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4',
                width: 200,
                height: 130,
              ),
              Text(
                '${provider.score}% Score',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                    color: provider.score < 50 ? Colors.red : Colors.green),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Quiz completed successfully...!',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Questions attempted - ${provider.questions!.length}',
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.purple,
                      fontWeight: FontWeight.w500),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Correct answers - ${provider.crctAnswers}',
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.green,
                      fontWeight: FontWeight.w500),
                ),
              )
            ]),
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {
              Provider.of<QuizController>(context,listen: false).tryAgain();
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QuestionPage(),
                  ));
            },
            child: Container(
              height: 50,
              width: MediaQuery.sizeOf(context).width * 0.5,
              decoration: BoxDecoration(
                  color: Color(0xFF481450),
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(20)),
              child: Center(
                child: Text(
                  'Try again',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
        )
      ]),
    );
  }
}
