// import 'package:flutter/material.dart';
// // ignore: unused_import
// import 'package:quizapp/pages/api.dart';
// import 'package:quizapp/pages/questions/sports_quiz_page.dart';
// import 'package:quizapp/pages/questions/gk_quiz_page.dart';
// import 'package:quizapp/pages/questions/science_quiz_page.dart';

//  // Import the sports quiz page file

// class HomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Predefined Quiz Categories'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             ElevatedButton(
//               onPressed: () {
//                 // Navigate to Sports quiz category
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => SportsQuizPage()),
//                 );
//               },
//               child: Text('Sports'),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 // Navigate to General Knowledge quiz category
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => GeneralKnowledgeQuizPage()),
//                 );
//               },
//               child: Text('General Knowledge'),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 // Navigate to Science quiz category
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => ComputerScienceQuizPage()),
//                 );
//               },
//               child: Text('Science'),
//             ),
//             // ElevatedButton(
//             //   onPressed: () {
//             //     // Navigate to Science quiz category
//             //     Navigator.push(
//             //       context,
//             //       MaterialPageRoute(builder: (context) => QuizScreen()),
//             //     );
//             //   },
//             //   child: Text('API'),
//             // ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:quizapp/pages/questions/sports_quiz_page.dart';
import 'package:quizapp/pages/questions/gk_quiz_page.dart';
import 'package:quizapp/pages/questions/science_quiz_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Predefined Quiz Categories',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.green[700],
        elevation: 5,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 200,
              height: 200,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SportsQuizPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(20.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  shadowColor: Colors.green[900],
                  elevation: 5,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Image.asset(
                        'images/sports.avif',
                        width: 190,
                        height: 120,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Sports',
                      style: TextStyle(fontSize: 18, color: Colors.green[700], fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: 200,
              height: 200,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => GeneralKnowledgeQuizPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(20.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  shadowColor: Colors.green[900],
                  elevation: 5,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Image.asset(
                        'images/gk.webp',
                        width: 190,
                        height: 120,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'General Knowledge',
                      style: TextStyle(fontSize: 18, color: Colors.green[700], fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: 200,
              height: 200,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ComputerScienceQuizPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(20.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  shadowColor: Colors.green[900],
                  elevation: 5,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Image.asset(
                        'images/cs.jpg',
                        width: 190,
                        height: 120,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Computer Science',
                      style: TextStyle(fontSize: 18, color: Colors.green[700], fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
