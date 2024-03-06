// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:quizapp/pages/api.dart';
// import 'package:quizapp/pages/home_page.dart';


//  // Import the sports quiz page file

// class MHomePage extends StatelessWidget {
//   final user=FirebaseAuth.instance.currentUser;
//   signout()async {
//     await FirebaseAuth.instance.signOut();
// }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Play Exciting Quizzes'),
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
//                   MaterialPageRoute(builder: (context) => HomePage()),
//                 );
//               },
//               child: Text('Predefined Quizes'),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 // Navigate to General Knowledge quiz category
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => QuizScreen()),
//                 );
//               },
//               child: Text('Random Quizes'),
//             ),
            
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: (()=>signout()),
//         child: Icon(Icons.login_rounded),
//       ),
//     );
//   }
// }
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quizapp/pages/api.dart';
import 'package:quizapp/pages/home_page.dart';

class MHomePage extends StatelessWidget {
  final user = FirebaseAuth.instance.currentUser;

  signout() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Play Exciting Quizzes',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.deepPurple[700],
        elevation: 5,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.deepPurple[400]!, Colors.deepPurple[700]!],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.deepPurple[900]!.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: Image.asset(
                  'images/quiz.webp',
                  width: 240, // Adjust the width of the image
                  height: 240, // Adjust the height of the image
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 60.0), // Increase the height for better spacing
            SizedBox(
              width: 200.0,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                },
                child: Text(
                  'Predefined Quizzes',
                  style: TextStyle(fontSize: 18.0, color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple[500],
                  padding: EdgeInsets.symmetric(vertical: 15.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            SizedBox(
              width: 200.0,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => QuizScreen()),
                  );
                },
                child: Text(
                  'Random Quizzes',
                  style: TextStyle(fontSize: 18.0, color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple[500],
                  padding: EdgeInsets.symmetric(vertical: 15.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (() => signout()),
        child: Icon(
          Icons.login_rounded,
          color: Colors.white,
        ),
        backgroundColor: Colors.deepPurple[700],
        elevation: 3,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
