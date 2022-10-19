import 'package:http/http.dart' as http;
import './question_models.dart';
import 'dart:convert';

class DBconnect {
  //add questions to our database
  //declaring the name of the table we are adding our values to
  final url = Uri.parse(
      'https://internship-510d3-default-rtdb.firebaseio.com/questions.json');
  Future<void> addQuestion(Question question) async {
    http.post(url, body: json.encode({
      'title': question.title,
      'options': question.options, 
    }));
  }
}
