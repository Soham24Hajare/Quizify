// import 'dart:async';
// import 'package:flutter/material.dart';

// class ComputerScienceQuizPage extends StatefulWidget {
//   @override
//   _ComputerScienceQuizPageState createState() => _ComputerScienceQuizPageState();
// }

// class _ComputerScienceQuizPageState extends State<ComputerScienceQuizPage> {
//   int _currentQuestionIndex = 0;
//   int _score = 0;
//   int? _selectedOptionIndex;
//   late Timer _timer;
//   static const int _questionDurationInSeconds = 30;
//   int _timeLeft = _questionDurationInSeconds;
//   List<Map<String, dynamic>> _questions = [
//     {
//       'question': 'What does HTML stand for?',
//       'options': ['Hyper Trainer Marking Language', 'Hyper Text Markup Language', 'Hyperlink and Text Markup Language', 'Hyper Text Machine Language'],
//       'correctAnswerIndex': 1,
//     },
//     {
//       'question': 'Which programming language is also known as the "mother of all languages"?',
//       'options': ['Python', 'Java', 'C', 'Assembly'],
//       'correctAnswerIndex': 2,
//     },
//     {
//       'question': 'What does CSS stand for?',
//       'options': ['Cascading Style Sheet', 'Creative Style Sheet', 'Computer Style Sheet', 'Colorful Style Sheet'],
//       'correctAnswerIndex': 0,
//     },
//     {
//       'question': 'What is the full form of PHP?',
//       'options': ['Hypertext Preprocessor', 'Pretext Hypertext Processor', 'Personal Home Page', 'Preprocessor Home Page'],
//       'correctAnswerIndex': 0,
//     },
//     {
//       'question': 'Which of the following is not a programming language?',
//       'options': ['Java', 'C++', 'HTML', 'Python'],
//       'correctAnswerIndex': 2,
//     },
//     {
//       'question': 'What is the main function of a compiler?',
//       'options': ['Translate high-level code to machine code', 'Debug code', 'Execute code', 'Optimize code'],
//       'correctAnswerIndex': 0,
//     },
//     {
//       'question': 'What does SQL stand for?',
//       'options': ['Structured Question Language', 'Structured Query Language', 'Sequential Query Language', 'Sequential Question Language'],
//       'correctAnswerIndex': 1,
//     },
//     {
//       'question': 'What is the purpose of JavaScript?',
//       'options': ['To add styles to web pages', 'To program the behavior of web pages', 'To create database schemas', 'To query databases'],
//       'correctAnswerIndex': 1,
//     },
//     {
//       'question': 'Which of the following is not a data structure?',
//       'options': ['Queue', 'Tree', 'Path', 'Graph'],
//       'correctAnswerIndex': 2,
//     },
//     {
//       'question': 'What is the binary equivalent of decimal number 10?',
//       'options': ['1010', '1101', '1110', '1001'],
//       'correctAnswerIndex': 0,
//     },
//   ];
//   List<int> _selectedAnswers = List.filled(10, -1); // Initialize with -1 indicating no answer selected.

//   @override
//   void initState() {
//     super.initState();
//     _shuffleQuestions();
//     _startTimer();
//   }

//   @override
//   void dispose() {
//     _timer.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Computer Science Quiz'),
//       ),
//       body: _currentQuestionIndex < _questions.length
//           ? _buildQuestionWidget(_questions[_currentQuestionIndex], _currentQuestionIndex + 1, _questions.length)
//           : _buildResultWidget(),
//     );
//   }

//   Widget _buildQuestionWidget(Map<String, dynamic> question, int questionNumber, int totalQuestions) {
//     return Column(
//       children: [
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Text(
//             'Q$questionNumber/$totalQuestions: ${question['question']}',
//             style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Text(
//             'Time Remaining: $_timeLeft seconds',
//             style: TextStyle(fontSize: 16.0),
//           ),
//         ),
//         Column(
//           children: List<Widget>.generate(
//             question['options'].length,
//             (index) => RadioListTile(
//               title: Text(question['options'][index]),
//               value: index,
//               groupValue: _selectedOptionIndex,
//               onChanged: (int? value) {
//                 setState(() {
//                   _selectedOptionIndex = value;
//                   _selectedAnswers[_currentQuestionIndex] = value!;
//                   if (_selectedOptionIndex == question['correctAnswerIndex']) {
//                     _score++;
//                   }
//                   _moveToNextQuestion();
//                 });
//               },
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildResultWidget() {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text(
//             'Quiz Completed!',
//             style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
//           ),
//           Text(
//             'Your Score: $_score / ${_questions.length}',
//             style: TextStyle(fontSize: 20.0),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               _showAnswers(context);
//             },
//             child: Text('See Answers'),
//           ),
//         ],
//       ),
//     );
//   }

//   void _showAnswers(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Your Answers'),
//           content: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: _questions.asMap().entries.map<Widget>((entry) {
//                 final index = entry.key + 1;
//                 final question = entry.value;
//                 final userAnswerIndex = _selectedAnswers[index - 1];
//                 final userAnswer = userAnswerIndex != -1 ? question['options'][userAnswerIndex] : 'Not answered';
//                 final correctAnswer = question['options'][question['correctAnswerIndex']];
//                 return ListTile(
//                   title: Text('Question $index: ${question['question']}'),
//                   subtitle: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text('Your Answer: $userAnswer'),
//                       if (userAnswerIndex != -1 && userAnswer != correctAnswer)
//                         Text('Correct Answer: $correctAnswer'),
//                     ],
//                   ),
//                 );
//               }).toList(),
//             ),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text('Close'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   void _moveToNextQuestion() {
//     _timer.cancel();
//     setState(() {
//       _currentQuestionIndex++;
//       _selectedOptionIndex = null;
//       if (_currentQuestionIndex < _questions.length) {
//         _startTimer();
//       }
//     });
//   }

//   void _startTimer() {
//     _timeLeft = _questionDurationInSeconds;
//     _timer = Timer.periodic(Duration(seconds: 1), (timer) {
//       setState(() {
//         if (_timeLeft > 0) {
//           _timeLeft--;
//         } else {
//           _timer.cancel();
//           _moveToNextQuestion();
//         }
//       });
//     });
//   }

//   void _shuffleQuestions() {
//     _questions.shuffle();
//   }
// }
import 'dart:async';
import 'package:flutter/material.dart';

class ComputerScienceQuizPage extends StatefulWidget {
  @override
  _ComputerScienceQuizPageState createState() => _ComputerScienceQuizPageState();
}

class _ComputerScienceQuizPageState extends State<ComputerScienceQuizPage> {
  int _currentQuestionIndex = 0;
  int _score = 0;
  int? _selectedOptionIndex;
  late Timer _timer;
  static const int _questionDurationInSeconds = 30;
  int _timeLeft = _questionDurationInSeconds;
  List<Map<String, dynamic>> _questions = [
    {
      'question': 'What does HTML stand for?',
      'options': ['Hyper Trainer Marking Language', 'Hyper Text Markup Language', 'Hyperlink and Text Markup Language', 'Hyper Text Machine Language'],
      'correctAnswerIndex': 1,
    },
    {
      'question': 'Which programming language is also known as the "mother of all languages"?',
      'options': ['Python', 'Java', 'C', 'Assembly'],
      'correctAnswerIndex': 2,
    },
    {
      'question': 'What does CSS stand for?',
      'options': ['Cascading Style Sheet', 'Creative Style Sheet', 'Computer Style Sheet', 'Colorful Style Sheet'],
      'correctAnswerIndex': 0,
    },
    {
      'question': 'What is the full form of PHP?',
      'options': ['Hypertext Preprocessor', 'Pretext Hypertext Processor', 'Personal Home Page', 'Preprocessor Home Page'],
      'correctAnswerIndex': 0,
    },
    {
      'question': 'Which of the following is not a programming language?',
      'options': ['Java', 'C++', 'HTML', 'Python'],
      'correctAnswerIndex': 2,
    },
    {
      'question': 'What is the main function of a compiler?',
      'options': ['Translate high-level code to machine code', 'Debug code', 'Execute code', 'Optimize code'],
      'correctAnswerIndex': 0,
    },
    {
      'question': 'What does SQL stand for?',
      'options': ['Structured Question Language', 'Structured Query Language', 'Sequential Query Language', 'Sequential Question Language'],
      'correctAnswerIndex': 1,
    },
    {
      'question': 'What is the purpose of JavaScript?',
      'options': ['To add styles to web pages', 'To program the behavior of web pages', 'To create database schemas', 'To query databases'],
      'correctAnswerIndex': 1,
    },
    {
      'question': 'Which of the following is not a data structure?',
      'options': ['Queue', 'Tree', 'Path', 'Graph'],
      'correctAnswerIndex': 2,
    },
    {
      'question': 'What is the binary equivalent of decimal number 10?',
      'options': ['1010', '1101', '1110', '1001'],
      'correctAnswerIndex': 0,
    },
  ];
  List<int> _selectedAnswers = List.filled(10, -1); // Initialize with -1 indicating no answer selected.

  @override
  void initState() {
    super.initState();
    _shuffleQuestions();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Computer Science Quiz',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.blue[700],
      ),
      body: _currentQuestionIndex < _questions.length
          ? _buildQuestionWidget(_questions[_currentQuestionIndex], _currentQuestionIndex + 1, _questions.length)
          : _buildResultWidget(),
    );
  }

  Widget _buildQuestionWidget(Map<String, dynamic> question, int questionNumber, int totalQuestions) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Q$questionNumber/$totalQuestions: ${question['question']}',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Time Remaining: $_timeLeft seconds',
            style: TextStyle(fontSize: 16.0),
          ),
        ),
        SizedBox(height: 16), // Add space between question and options
        Column(
          children: List<Widget>.generate(
            question['options'].length,
            (index) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0), // Increase vertical gap between buttons
              child: SizedBox(
                width: double.infinity, // Force buttons to expand to the full width available
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _selectedOptionIndex = index;
                      _selectedAnswers[_currentQuestionIndex] = index;
                      if (_selectedOptionIndex == question['correctAnswerIndex']) {
                        _score++;
                      }
                      _moveToNextQuestion();
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.blue[700], backgroundColor: Colors.white,
                    elevation: 5,
                    shadowColor: Colors.blue[900],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      question['options'][index],
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildResultWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Quiz Completed!',
            style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
          ),
          Text(
            'Your Score: $_score / ${_questions.length}',
            style: TextStyle(fontSize: 20.0),
          ),
          ElevatedButton(
            onPressed: () {
              _showAnswers(context);
            },
            child: Text('See Answers'),
          ),
        ],
      ),
    );
  }

  void _showAnswers(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Your Answers'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _questions.asMap().entries.map<Widget>((entry) {
                final index = entry.key + 1;
                final question = entry.value;
                final userAnswerIndex = _selectedAnswers[index - 1];
                final userAnswer = userAnswerIndex != -1 ? question['options'][userAnswerIndex] : 'Not answered';
                final correctAnswer = question['options'][question['correctAnswerIndex']];
                return ListTile(
                  title: Text('Question $index: ${question['question']}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Your Answer: $userAnswer'),
                      if (userAnswerIndex != -1 && userAnswer != correctAnswer)
                        Text('Correct Answer: $correctAnswer'),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void _moveToNextQuestion() {
    _timer.cancel();
    setState(() {
      _currentQuestionIndex++;
      _selectedOptionIndex = null;
      if (_currentQuestionIndex < _questions.length) {
        _startTimer();
      }
    });
  }

  void _startTimer() {
    _timeLeft = _questionDurationInSeconds;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_timeLeft > 0) {
          _timeLeft--;
        } else {
          _timer.cancel();
          _moveToNextQuestion();
        }
      });
    });
  }

  void _shuffleQuestions() {
    _questions.shuffle();
  }
}
