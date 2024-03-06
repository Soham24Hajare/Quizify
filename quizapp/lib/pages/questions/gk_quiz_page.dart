// import 'dart:async';
// import 'package:flutter/material.dart';

// class GeneralKnowledgeQuizPage extends StatefulWidget {
//   @override
//   _GeneralKnowledgeQuizPageState createState() => _GeneralKnowledgeQuizPageState();
// }

// class _GeneralKnowledgeQuizPageState extends State<GeneralKnowledgeQuizPage> {
//   int _currentQuestionIndex = 0;
//   int _score = 0;
//   int? _selectedOptionIndex;
//   late Timer _timer;
//   static const int _questionDurationInSeconds = 30;
//   int _timeLeft = _questionDurationInSeconds;
//   List<Map<String, dynamic>> _questions = [
//     {
//       'question': 'What is the capital of France?',
//       'options': ['Paris', 'London', 'Berlin', 'Rome'],
//       'correctAnswerIndex': 0,
//     },
//     {
//       'question': 'Which planet is known as the Red Planet?',
//       'options': ['Venus', 'Mars', 'Jupiter', 'Saturn'],
//       'correctAnswerIndex': 1,
//     },
//     {
//       'question': 'Who wrote "To Kill a Mockingbird"?',
//       'options': ['Harper Lee', 'Jane Austen', 'J.K. Rowling', 'George Orwell'],
//       'correctAnswerIndex': 0,
//     },
//     {
//       'question': 'What is the chemical symbol for water?',
//       'options': ['Wa', 'Wo', 'H2O', 'O2'],
//       'correctAnswerIndex': 2,
//     },
//     {
//       'question': 'Which country is known as the Land of the Rising Sun?',
//       'options': ['China', 'India', 'Japan', 'South Korea'],
//       'correctAnswerIndex': 2,
//     },
//     {
//       'question': 'What is the largest mammal?',
//       'options': ['Elephant', 'Whale', 'Giraffe', 'Hippopotamus'],
//       'correctAnswerIndex': 1,
//     },
//     {
//       'question': 'What is the longest river in the world?',
//       'options': ['Nile', 'Amazon', 'Mississippi', 'Yangtze'],
//       'correctAnswerIndex': 0,
//     },
//     {
//       'question': 'Who painted the Mona Lisa?',
//       'options': ['Vincent van Gogh', 'Leonardo da Vinci', 'Pablo Picasso', 'Michelangelo'],
//       'correctAnswerIndex': 1,
//     },
//     {
//       'question': 'What is the currency of Japan?',
//       'options': ['Yuan', 'Euro', 'Yen', 'Pound'],
//       'correctAnswerIndex': 2,
//     },
//     {
//       'question': 'Who developed the theory of relativity?',
//       'options': ['Isaac Newton', 'Albert Einstein', 'Galileo Galilei', 'Stephen Hawking'],
//       'correctAnswerIndex': 1,
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
//         title: Text('General Knowledge Quiz'),
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

class GeneralKnowledgeQuizPage extends StatefulWidget {
  @override
  _GeneralKnowledgeQuizPageState createState() => _GeneralKnowledgeQuizPageState();
}

class _GeneralKnowledgeQuizPageState extends State<GeneralKnowledgeQuizPage> {
  int _currentQuestionIndex = 0;
  int _score = 0;
  int? _selectedOptionIndex;
  late Timer _timer;
  static const int _questionDurationInSeconds = 30;
  int _timeLeft = _questionDurationInSeconds;
  List<Map<String, dynamic>> _questions = [
    {
      'question': 'What is the capital of France?',
      'options': ['Paris', 'London', 'Berlin', 'Rome'],
      'correctAnswerIndex': 0,
    },
    {
      'question': 'Which planet is known as the Red Planet?',
      'options': ['Venus', 'Mars', 'Jupiter', 'Saturn'],
      'correctAnswerIndex': 1,
    },
    {
      'question': 'Who wrote "To Kill a Mockingbird"?',
      'options': ['Harper Lee', 'Jane Austen', 'J.K. Rowling', 'George Orwell'],
      'correctAnswerIndex': 0,
    },
    {
      'question': 'What is the chemical symbol for water?',
      'options': ['Wa', 'Wo', 'H2O', 'O2'],
      'correctAnswerIndex': 2,
    },
    {
      'question': 'Which country is known as the Land of the Rising Sun?',
      'options': ['China', 'India', 'Japan', 'South Korea'],
      'correctAnswerIndex': 2,
    },
    {
      'question': 'What is the largest mammal?',
      'options': ['Elephant', 'Whale', 'Giraffe', 'Hippopotamus'],
      'correctAnswerIndex': 1,
    },
    {
      'question': 'What is the longest river in the world?',
      'options': ['Nile', 'Amazon', 'Mississippi', 'Yangtze'],
      'correctAnswerIndex': 0,
    },
    {
      'question': 'Who painted the Mona Lisa?',
      'options': ['Vincent van Gogh', 'Leonardo da Vinci', 'Pablo Picasso', 'Michelangelo'],
      'correctAnswerIndex': 1,
    },
    {
      'question': 'What is the currency of Japan?',
      'options': ['Yuan', 'Euro', 'Yen', 'Pound'],
      'correctAnswerIndex': 2,
    },
    {
      'question': 'Who developed the theory of relativity?',
      'options': ['Isaac Newton', 'Albert Einstein', 'Galileo Galilei', 'Stephen Hawking'],
      'correctAnswerIndex': 1,
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
          'General Knowledge Quiz',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.orange[700],
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
                    foregroundColor: Colors.orange[700], backgroundColor: Colors.white,
                    elevation: 5,
                    shadowColor: Colors.orange[900],
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
