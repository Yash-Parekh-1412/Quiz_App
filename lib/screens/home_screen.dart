import 'package:flutter/material.dart';
import '../constants.dart';
import '../models/question_models.dart';
import '../widgets/question_widget.dart';
import '../widgets/next_button.dart';
import '../widgets/option_card.dart';
import '../widgets/result_box.dart';

//first class to show name
class EnterName extends StatefulWidget {
  const EnterName({super.key});

  @override
  State<EnterName> createState() => _EnterNameState();
}

class _EnterNameState extends State<EnterName> {
  
  late String title;
  String text = "No value Entered";

  void _setText() {
    setState(() {
      text = title;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        title: const Text('Quiz App'),
        backgroundColor: background,
        shadowColor: Colors.transparent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(15),
              child: TextField(
                decoration: const InputDecoration(labelText: 'Enter your name'),
                onChanged:(value) => title = value,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen())
                );
              }, 
              child: const Text('Submit'),
            ),
          ],
        ),
      )
    );
  }
}

//for questions
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //questions
  final List<Question> _questions = [
    Question(
      id: '10',
      title: 'What is 345 + 456?',
      options: {'734': false, '1024': false, '801': true, '761': false},
    ),
    Question(
      id: '11',
      title: 'What is 23 x 5?',
      options: {'115': true, '345': false, '95': false, '105': false},
    ),
    Question(
      id: '12',
      title: 'What is 65 / 13?',
      options: {'7': false, '5': true, '6': false, '4': false},
    ),
    Question(
      id: '13',
      title: 'What is (35 + 26) x 5?',
      options: {'325': false, '415': false, '305': true, '365': false},
    ),
    Question(
      id: '14',
      title: 'What is (357 - 243) / 3?',
      options: {'26': false, '24': false, '34': false, '38': true},
    ),
    Question(
      id: '15',
      title: 'What is (4 + 6) * 4?',
      options: {'34': false, '50': false, '12': false, '40': true},
    ),
    Question(
      id: '16',
      title: 'What is (2 * 5) + 6?',
      options: {'16': true, '18': false, '12': false, '14': false},
    ),
    Question(
      id: '17',
      title: 'What is 7 * (15 + 5)?',
      options: {'130': false, '140': true, '150': false, '120': false},
    ),
    Question(
      id: '18',
      title: 'What is 120 / 2 * 6?',
      options: {'10': false, '40': false, '360': true, '380': false},
    ),
    Question(
      id: '19',
      title: 'What is 15 * 5 -5?',
      options: {'0': false, '50': false, '75': false, '70': true},
    ),
  ];

  //question number
  int index = 0;

  //to keep track of score
  int score = 0;

  //to check if the user has clicked
  bool isPressed = false;

  //for score
  bool isAlreadySelected = false;

  //to change color on clicking
  void checkAnswerAndUpdate(bool value) {
    if (isAlreadySelected) {
      return;
    } else {
      if (value == true) {
        score++;
        setState(() {
          isPressed = true;
          isAlreadySelected = true;
        });
      } else {
        setState(() {
          isPressed = true;
          isAlreadySelected = true;
        });
      }
    }
  }

  //display next question
  void nextQuestion() {
    if (index == _questions.length - 1) {
      //to show result
      showDialog(
          context: context,
          barrierDismissible: false, //to disable function
          builder: (ctx) => ResultBox(
                result: score, //total points
                questionLength: _questions.length,
                onPressed: startOver,
              ));
    } else {
      //to check if the question is answered before you go to the next question
      if (isPressed) {
        setState(() {
          index++;
          isPressed = false;
          isAlreadySelected = false;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Please select a option'),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.symmetric(vertical: 20.0),
        ));
      }
    }
  }

  //Start over function
  void startOver() {
    setState(() {
      index = 0;
      score = 0;
      isPressed = false;
      isAlreadySelected = false;
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        title: const Text('Quiz App'),
        backgroundColor: background,
        shadowColor: Colors.transparent,
        actions: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Text(
              'Score: $score',
              style: const TextStyle(fontSize: 18.0),
            ),
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: [
            QuestionWidget(
              indexAction: index,
              question: _questions[index].title,
              totalQuestion: _questions.length,
            ),
            const Divider(color: neutral),

            //space
            const SizedBox(height: 25.0),
            for (int i = 0; i < _questions[index].options.length; i++)
              GestureDetector(
                onTap: () => checkAnswerAndUpdate(
                    _questions[index].options.values.toList()[i]),
                child: OptionCard(
                  option: _questions[index].options.keys.toList()[i],
                  color: isPressed
                      ? _questions[index].options.values.toList()[i] == true
                          ? correct
                          : incorrect
                      : neutral,
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: NextButton(
          nextQuestion: nextQuestion,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
