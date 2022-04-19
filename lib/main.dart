import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:zoom/controllers/auth_controller.dart';
import 'package:zoom/screens/auth/login_screen.dart';
import 'package:zoom/screens/home_screen.dart';
import 'package:zoom/utils/colors.dart';

void main() async {
  //Initialize firebase
  WidgetsFlutterBinding.ensureInitialized(); //initialize all widgets
  await Firebase.initializeApp(); //wait and initialize firebase
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme:
          ThemeData.dark().copyWith(scaffoldBackgroundColor: backgroundColor),

          //
      home: StreamBuilder(
        stream: AuthController().authChanges,
        builder: (context, snapshot) {
          //if waiting for something...could be problems
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              //show spinning wheel
              child: CircularProgressIndicator(),
            );
          }
          //Send user to home screen if sighned in
          if (snapshot.hasData) {
            return HomeScreen();
          }
          //Send user to login screen if not logged in 
          else {
            return LoginScreen();
          }
        },
      ),
    );
  }
}
