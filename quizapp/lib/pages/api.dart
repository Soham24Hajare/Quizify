// import 'dart:async';
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// class QuizScreen extends StatefulWidget {
//   @override
//   _QuizScreenState createState() => _QuizScreenState();
// }

// class _QuizScreenState extends State<QuizScreen> {
//   List<dynamic> questions = [];
//   Map<int, String?> selectedAnswers = {};
//   int score = 0;
//   int questionIndex = 0;
//   late Timer timer;
//   int secondsRemaining = 30;

//   List<dynamic> categories = [];
//   String? selectedCategory;

//   @override
//   void initState() {
//     super.initState();
//     fetchCategories();
//   }

//   @override
//   void dispose() {
//     timer.cancel();
//     super.dispose();
//   }

//   Future<void> fetchCategories() async {
//     final response = await http.get(
//       Uri.parse('https://opentdb.com/api_category.php'),
//     );

//     if (response.statusCode == 200) {
//       setState(() {
//         categories = json.decode(response.body)['trivia_categories'];
//         selectedCategory = categories[0]['id'].toString(); // Default category
//       });
//     } else {
//       throw Exception('Failed to load categories');
//     }
//   }

//   Future<void> fetchQuestions(String? category) async {
//     final response = await http.get(
//       Uri.parse('https://opentdb.com/api.php?amount=10&type=multiple&category=$category'),
//     );

//     if (response.statusCode == 200) {
//       setState(() {
//         questions = json.decode(response.body)['results'];
//         startTimer(); // Start timer once questions are loaded
//       });
//     } else {
//       throw Exception('Failed to load questions');
//     }
//   }

//   void startTimer() {
//     timer = Timer.periodic(Duration(milliseconds: 1000), (timer) {
//       setState(() {
//         if (secondsRemaining > 0) {
//           secondsRemaining--;
//         } else {
//           timer.cancel();
//           moveToNextQuestion();
//         }
//       });
//     });
//   }

//   void moveToNextQuestion() {
//     if (questionIndex < questions.length - 1) {
//       setState(() {
//         questionIndex++;
//         secondsRemaining = 30;
//       });
//       startTimer();
//     } else {
//       timer.cancel();
//       score = calculateScore();
//       showQuizResult();
//     }
//   }

//   int calculateScore() {
//     int score = 0;
//     for (int i = 0; i < questions.length; i++) {
//       if (selectedAnswers.containsKey(i) &&
//           selectedAnswers[i] == questions[i]['correct_answer']) {
//         score++;
//       }
//     }
//     return score;
//   }

//   void showQuizResult() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Quiz Complete'),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text('Your score: $score'),
//               ElevatedButton(
//                 onPressed: showAnswers,
//                 child: Text('See Answers'),
//               ),
//             ],
//           ),
//           actions: <Widget>[
//             TextButton(
//               child: Text('Close'),
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }

//   void showAnswers() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Correct Answers'),
//           content: SingleChildScrollView(
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 for (int i = 0; i < questions.length; i++)
//                   ListTile(
//                     title: Text('Question ${i + 1}: ${questions[i]['question']}'),
//                     subtitle: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text('Your answer: ${selectedAnswers[i] ?? 'Not answered'}'),
//                         Text('Correct Answer: ${questions[i]['correct_answer']}'),
//                       ],
//                     ),
//                   ),
//               ],
//             ),
//           ),
//           actions: <Widget>[
//             TextButton(
//               child: Text('Close'),
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Quiz'),
//       ),
//       body: categories.isEmpty
//           ? Center(
//               child: CircularProgressIndicator(),
//             )
//           : Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: DropdownButtonFormField<String>(
//                     value: selectedCategory,
//                     items: categories.map((category) {
//                       return DropdownMenuItem<String>(
//                         value: category['id'].toString(),
//                         child: Text(category['name']),
//                       );
//                     }).toList(),
//                     onChanged: (value) {
//                       setState(() {
//                         selectedCategory = value;
//                         fetchQuestions(selectedCategory);
//                       });
//                     },
//                   ),
//                 ),
//                 if (questions.isNotEmpty) ...[
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Text(
//                       'Question ${questionIndex + 1} of ${questions.length}',
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 16.0,
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Text(
//                       'Time Remaining: $secondsRemaining seconds',
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 16.0,
//                       ),
//                     ),
//                   ),
//                   ListTile(
//                     title: Text(
//                       questions[questionIndex]['question'],
//                       style: TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                     subtitle: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         for (var option in [...questions[questionIndex]['incorrect_answers'], questions[questionIndex]['correct_answer']])
//                           RadioListTile(
//                             title: Text(option),
//                             value: option,
//                             groupValue: selectedAnswers[questionIndex],
//                             onChanged: (value) {
//                               setState(() {
//                                 selectedAnswers[questionIndex] = value.toString();
//                               });
//                             },
//                           ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(height: 20),
//                   Center(
//                     child: ElevatedButton(
//                       onPressed: moveToNextQuestion,
//                       child: Text('Next'),
//                     ),
//                   ),
//                 ],
//               ],
//             ),
//     );
//   }
// }

// void main() {
//   runApp(MaterialApp(
//     home: QuizScreen(),
//   ));
// }
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  List<dynamic> questions = [];
  Map<int, String?> selectedAnswers = {};
  int score = 0;
  int questionIndex = 0;
  late Timer timer;
  int secondsRemaining = 30;

  List<dynamic> categories = [];
  String? selectedCategory;

  @override
  void initState() {
    super.initState();
    fetchCategories();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  Future<void> fetchCategories() async {
    final response = await http.get(
      Uri.parse('https://opentdb.com/api_category.php'),
    );

    if (response.statusCode == 200) {
      setState(() {
        categories = json.decode(response.body)['trivia_categories'];
        selectedCategory = categories[0]['id'].toString(); // Default category
      });
    } else {
      throw Exception('Failed to load categories');
    }
  }

  Future<void> fetchQuestions(String? category) async {
    final response = await http.get(
      Uri.parse('https://opentdb.com/api.php?amount=10&type=multiple&category=$category'),
    );

    if (response.statusCode == 200) {
      setState(() {
        questions = json.decode(response.body)['results'];
        startTimer(); // Start timer once questions are loaded
      });
    } else {
      throw Exception('Failed to load questions');
    }
  }

  void startTimer() {
    timer = Timer.periodic(Duration(milliseconds: 1000), (timer) {
      setState(() {
        if (secondsRemaining > 0) {
          secondsRemaining--;
        } else {
          timer.cancel();
          moveToNextQuestion();
        }
      });
    });
  }

  void moveToNextQuestion() {
    if (questionIndex < questions.length - 1) {
      setState(() {
        questionIndex++;
        secondsRemaining = 30;
      });
      startTimer();
    } else {
      timer.cancel();
      score = calculateScore();
      showQuizResult();
    }
  }

  int calculateScore() {
    int score = 0;
    for (int i = 0; i < questions.length; i++) {
      if (selectedAnswers.containsKey(i) &&
          selectedAnswers[i] == questions[i]['correct_answer']) {
        score++;
      }
    }
    return score;
  }

  void showQuizResult() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Quiz Complete'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Your score: $score'),
              ElevatedButton(
                onPressed: showAnswers,
                child: Text('See Answers'),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void showAnswers() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Correct Answers'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (int i = 0; i < questions.length; i++)
                  ListTile(
                    title: Text('Question ${i + 1}: ${questions[i]['question']}'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Your answer: ${selectedAnswers[i] ?? 'Not answered'}'),
                        Text('Correct Answer: ${questions[i]['correct_answer']}'),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Quiz',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.brown,
      ),
      body: categories.isEmpty
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButtonFormField<String>(
                    value: selectedCategory,
                    items: categories.map((category) {
                      return DropdownMenuItem<String>(
                        value: category['id'].toString(),
                        child: Text(category['name']),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedCategory = value;
                        fetchQuestions(selectedCategory);
                      });
                    },
                  ),
                ),
                if (questions.isNotEmpty) ...[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Question ${questionIndex + 1} of ${questions.length}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Time Remaining: $secondsRemaining seconds',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      questions[questionIndex]['question'],
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.brown),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (var option in [...questions[questionIndex]['incorrect_answers'], questions[questionIndex]['correct_answer']])
                          RadioListTile(
                            title: Text(option),
                            value: option,
                            groupValue: selectedAnswers[questionIndex],
                            onChanged: (value) {
                              setState(() {
                                selectedAnswers[questionIndex] = value.toString();
                              });
                            },
                          ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      onPressed: moveToNextQuestion,
                      child: Text('Next'),
                    ),
                  ),
                ],
              ],
            ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: QuizScreen(),
  ));
}
