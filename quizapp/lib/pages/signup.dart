// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:quizapp/pages/wrapper.dart';
// class SignUp extends StatefulWidget {
//   const SignUp({super.key});

//   @override
//   State<SignUp> createState() => _SignUpState();
// }

// class _SignUpState extends State<SignUp> {

//   TextEditingController email=TextEditingController();
//   TextEditingController password=TextEditingController();

//   signUp() async {
//     await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email.text, password: password.text);
//     Get.offAll(()=>Wrapper());
//   }
//   @override
//   Widget build(BuildContext context) {
// return Scaffold(
//       appBar: AppBar(title: Text("Sign Up"),),
//       body:Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           children: [
//             TextField(
//               controller:email,
//               decoration: InputDecoration(hintText: 'Enter email'),
//             ),
//             TextField(
//               controller:password,
//               decoration: InputDecoration(hintText: 'Enter password'),
//             ),
//             ElevatedButton(onPressed: (()=>signUp()), child: Text("Sign Up"))
//           ],),
//       )
//     );
//   }
// }
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizapp/pages/wrapper.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  signUp() async {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email.text, password: password.text);
    Get.offAll(() => Wrapper());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            SizedBox(height: 20),
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('images/login.png'), // Your circular image
            ),
            SizedBox(height: 40),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: TextField(
                controller: email,
                decoration: InputDecoration(
                  hintText: 'Enter email',
                  contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  border: InputBorder.none,
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: TextField(
                controller: password,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Enter password',
                  contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  border: InputBorder.none,
                ),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => signUp(),
                child: Text("Sign Up"),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Colors.blue[900],
                  padding: EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
