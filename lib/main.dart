import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media_integration/Methods/Authservice.dart';
import 'Screens/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Screens/user_details.dart';
import 'package:provider/provider.dart';
void main() {
  //Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=>Authentication())
      ],
      child: MaterialApp(

          //textTheme: ,
         // backgroundColor: Color(0xffffed99)


        home: Login(),
        //initialRoute: Login.login,
        routes: {
          Login.login:(context)=>Login(),
          UserDetails.user:(context)=>UserDetails()

      },


      ),
    );
  }
}
