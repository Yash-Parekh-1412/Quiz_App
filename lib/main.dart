import 'package:flutter/material.dart';
import 'package:internship/models/question_models.dart';
import './screens/home_screen.dart';
import './models/db_connection.dart';

void main() {
  
  // //to connect to database
  // var db = DBconnect();
  // db.addQuestion(
  //   Question(
  //     id: '20', 
  //     title: 'What is 2 + 2?', 
  //     options: {
  //       '100': false, 
  //       '4': true,
  //       '5': false,
  //       '6': false,
  //     }
  //   )
  // );

  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext) {
    return const MaterialApp(
      //to remove debugg banner
      debugShowCheckedModeBanner: false,

      

      //homepage
      home: EnterName(),
    );
  }
}
