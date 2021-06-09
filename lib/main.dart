import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'Screens/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Screens/user_details.dart';
void main() {
  //Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

        //textTheme: ,
       // backgroundColor: Color(0xffffed99)
      theme: ThemeData(


        textTheme: Theme.of(context).textTheme.apply(
      displayColor: Colors.black,
      bodyColor: Colors.black,
    ),
      ),
      home: Login(),
      initialRoute: Login.login,
      routes: {
        Login.login:(context)=>Login(),
        UserDetails.us:(context)=>UserDetails()

    },


    );
  }
}
