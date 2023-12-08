import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app_api/controller/quiz_controller/quiz_controller.dart';
import 'package:quiz_app_api/view/result_page/result_page.dart';

class QuestionPage extends StatefulWidget {
  const QuestionPage({super.key});

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  @override
  void initState() {
    // TODO: implement initState
    getQuestions();
    super.initState();
  }

  getQuestions() async {
    await Provider.of<QuizController>(context, listen: false).getData();
  }

  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<QuizController>(context);
    return Scaffold(
      backgroundColor: Color(0xFF481450),
      body: Provider.of<QuizController>(context).isLoading == true
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 8),
                        child: Text(
                          'Question - ${provider.questionIndex + 1} / ${provider.questions!.length}',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w400),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 50,
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: SizedBox(
                        width: MediaQuery.sizeOf(context).width * 0.9,
                        child: Text(
                          Provider.of<QuizController>(context)
                              .questions?[provider.questionIndex]
                              .question,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                  // answers
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.5,
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: Provider.of<QuizController>(context)
                          .questions?[provider.questionIndex]
                          .options
                          .length,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            provider.canSelect == true
                                ? setState(() {
                                    selectedIndex = index;
                                  })
                                : null;
                            provider.canSelect == true
                                ? Provider.of<QuizController>(context,
                                        listen: false)
                                    .checkAnswer(index)
                                : null;
                            provider.canSelect = false;
                            provider.goNext = true;
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 20),
                            decoration: BoxDecoration(
                                color: selectedIndex == index
                                    ? provider.isCorrect == true
                                        ? Colors.green
                                        : Colors.red
                                    : Colors.transparent,
                                border: Border.all(color: Colors.white),
                                borderRadius: BorderRadius.circular(20)),
                            child: Text(
                              '${index + 1}.  ${Provider.of<QuizController>(context).questions?[provider.questionIndex].options[index].text}',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  provider.goNext == true
                      ? Center(
                          child: InkWell(
                          onTap: () {
                            provider.questionIndex <
                                    provider.questions!.length - 1
                                ? Provider.of<QuizController>(context,
                                        listen: false)
                                    .nextQuestion()
                                : Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ResultScreen(),
                                    ));
                            selectedIndex = null;
                            provider.canSelect = true;
                            provider.goNext = false;
                          },
                          child: Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width * 0.8,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20)),
                            child: Center(
                                child: Text(
                              'Next',
                              style: TextStyle(
                                  color: Color(0xFF481450),
                                  fontWeight: FontWeight.w600),
                            )),
                          ),
                        ))
                      : Container()
                ],
              ),
            ),
    );
  }
}
