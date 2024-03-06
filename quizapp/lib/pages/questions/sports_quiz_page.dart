// import 'dart:async';
// import 'package:flutter/material.dart';

// class SportsQuizPage extends StatefulWidget {
//   @override
//   _SportsQuizPageState createState() => _SportsQuizPageState();
// }

// class _SportsQuizPageState extends State<SportsQuizPage> {
//   int _currentQuestionIndex = 0;
//   int _score = 0;
//   int? _selectedOptionIndex;
//   late Timer _timer;
//   static const int _questionDurationInSeconds = 30;
//   int _timeLeft = _questionDurationInSeconds;
//   List<Map<String, dynamic>> _questions = [
//     {
//       'question': 'Who won the FIFA World Cup in 2018?',
//       'options': ['Brazil', 'Germany', 'France', 'Spain'],
//       'correctAnswerIndex': 2,
//     },
//     {
//       'question': 'Which country has won the most Olympic gold medals?',
//       'options': ['United States', 'China', 'Russia', 'Australia'],
//       'correctAnswerIndex': 0,
//     },
//     {
//       'question': 'In which sport is the Davis Cup awarded?',
//       'options': ['Tennis', 'Golf', 'Cricket', 'Football'],
//       'correctAnswerIndex': 0,
//     },
//     {
//       'question': 'Who has won the most Grand Slam titles in tennis history?',
//       'options': ['Rafael Nadal', 'Roger Federer', 'Novak Djokovic', 'Serena Williams'],
//       'correctAnswerIndex': 1,
//     },
//     {
//       'question': 'Which country hosted the 2016 Summer Olympics?',
//       'options': ['United States', 'China', 'Brazil', 'Russia'],
//       'correctAnswerIndex': 2,
//     },
//     {
//       'question': 'Which sport uses the term "birdie"?',
//       'options': ['Golf', 'Tennis', 'Cricket', 'Soccer'],
//       'correctAnswerIndex': 0,
//     },
//     {
//       'question': 'Who won the UEFA Champions League in 2020?',
//       'options': ['Bayern Munich', 'Real Madrid', 'Liverpool', 'Barcelona'],
//       'correctAnswerIndex': 0,
//     },
//     {
//       'question': 'Which athlete is known as "The Flying Finn"?',
//       'options': ['Usain Bolt', 'Paavo Nurmi', 'Michael Phelps', 'Carl Lewis'],
//       'correctAnswerIndex': 1,
//     },
//     {
//       'question': 'Which country won the most medals in the 2020 Tokyo Olympics?',
//       'options': ['United States', 'China', 'Japan', 'Russia'],
//       'correctAnswerIndex': 2,
//     },
//     {
//       'question': 'Which NFL team has won the most Super Bowl titles?',
//       'options': ['New England Patriots', 'Dallas Cowboys', 'Pittsburgh Steelers', 'San Francisco 49ers'],
//       'correctAnswerIndex': 2,
//     },
//     // Add more questions here...
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
//         title: Text('Sports Quiz'),
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
//               children: _questions.map<Widget>((question) {
//                 int index = _questions.indexOf(question) + 1;
//                 String userAnswer = question['options'][_selectedAnswers[index - 1]];
//                 String correctAnswer = question['options'][question['correctAnswerIndex']];
//                 return ListTile(
//                   title: Text('Question $index: ${question['question']}'),
//                   subtitle: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text('Your Answer: $userAnswer'),
//                       if (userAnswer != correctAnswer)
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

class SportsQuizPage extends StatefulWidget {
  @override
  _SportsQuizPageState createState() => _SportsQuizPageState();
}

class _SportsQuizPageState extends State<SportsQuizPage> {
  int _currentQuestionIndex = 0;
  int _score = 0;
  int? _selectedOptionIndex;
  late Timer _timer;
  static const int _questionDurationInSeconds = 30;
  int _timeLeft = _questionDurationInSeconds;
  List<Map<String, dynamic>> _questions = [
    {
      'question': 'Who won the FIFA World Cup in 2018?',
      'options': ['Brazil', 'Germany', 'France', 'Spain'],
      'correctAnswerIndex': 2,
    },
    {
      'question': 'Which country has won the most Olympic gold medals?',
      'options': ['United States', 'China', 'Russia', 'Australia'],
      'correctAnswerIndex': 0,
    },
    {
      'question': 'In which sport is the Davis Cup awarded?',
      'options': ['Tennis', 'Golf', 'Cricket', 'Football'],
      'correctAnswerIndex': 0,
    },
    {
      'question': 'Who has won the most Grand Slam titles in tennis history?',
      'options': ['Rafael Nadal', 'Roger Federer', 'Novak Djokovic', 'Serena Williams'],
      'correctAnswerIndex': 1,
    },
    {
      'question': 'Which country hosted the 2016 Summer Olympics?',
      'options': ['United States', 'China', 'Brazil', 'Russia'],
      'correctAnswerIndex': 2,
    },
    {
      'question': 'Which sport uses the term "birdie"?',
      'options': ['Golf', 'Tennis', 'Cricket', 'Soccer'],
      'correctAnswerIndex': 0,
    },
    {
      'question': 'Who won the UEFA Champions League in 2020?',
      'options': ['Bayern Munich', 'Real Madrid', 'Liverpool', 'Barcelona'],
      'correctAnswerIndex': 0,
    },
    {
      'question': 'Which athlete is known as "The Flying Finn"?',
      'options': ['Usain Bolt', 'Paavo Nurmi', 'Michael Phelps', 'Carl Lewis'],
      'correctAnswerIndex': 1,
    },
    {
      'question': 'Which country won the most medals in the 2020 Tokyo Olympics?',
      'options': ['United States', 'China', 'Japan', 'Russia'],
      'correctAnswerIndex': 2,
    },
    {
      'question': 'Which NFL team has won the most Super Bowl titles?',
      'options': ['New England Patriots', 'Dallas Cowboys', 'Pittsburgh Steelers', 'San Francisco 49ers'],
      'correctAnswerIndex': 2,
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
          'Sports Quiz',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.green[700],
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
                    foregroundColor: Colors.green[700], backgroundColor: Colors.white,
                    elevation: 5,
                    shadowColor: Colors.green[900],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    minimumSize: Size(double.infinity, 48), // Set button height
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
              children: _questions.map<Widget>((question) {
                int index = _questions.indexOf(question) + 1;
                String userAnswer = question['options'][_selectedAnswers[index - 1]];
                String correctAnswer = question['options'][question['correctAnswerIndex']];
                return ListTile(
                  title: Text('Question $index: ${question['question']}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Your Answer: $userAnswer'),
                      if (userAnswer != correctAnswer)
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
