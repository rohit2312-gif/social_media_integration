import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_media_integration/Methods/Authservice.dart';
import 'user_details.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import '../Methods/model.dart';
import '../Methods/sign_in.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:provider/provider.dart';
class Login extends StatefulWidget {
  static const login='login';
  

  @override
  _LoginState createState() => _LoginState();
}



// Check result status


class _LoginState extends State<Login> with SingleTickerProviderStateMixin{
  @override
  void initState() {
 Firebase.initializeApp();
 //var model=Provider<Authentication>.of(context);
   // signinwithFacebook();
    // TODO: implement initState
    super.initState();
  }

  bool hasSigned=false;
  @override

  Widget build(BuildContext context) {

    return ChangeNotifierProvider<Authentication>(
      create: (context)=>Authentication(),
      child: Scaffold(

        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,

          body: ModalProgressHUD(
            inAsyncCall: hasSigned,
            child: Column(



              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                ClipPath(
                  clipper: WaveClipperOne(reverse: false,flip: true),
                  child: Container(

                    alignment: Alignment.topCenter,
                    color: Color(0xff867ae9),
                    height: 100.0,
                  ),
                ),

                AnimatedTextKit(
                  animatedTexts: [
                    WavyAnimatedText('Sign in to get started',textStyle: TextStyle(color: Color(0xff867ae9),fontSize: 30.0,fontWeight: FontWeight.w500)),

                  ],

                ),
                    SizedBox(
                      height: 100.0,
                    ),
                    Container(
                      padding: EdgeInsets.all(10.0),
                      child: Material(

                        borderRadius: BorderRadius.circular(20.0),
                        color: Color(0xffb4aee8),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 50.0,
                            ),
                            UserInputCard(icon: Icons.mail,text: 'Email',),

                                SizedBox(
                                height: 10.0,
                                ),
                               UserInputCard(icon: Icons.lock,text: 'Password',),
                                SizedBox(
                                height: 50.0,
                                ),
                                GestureDetector(
                                onTap: (){

                                //var x=auth.createUserWithEmailAndPassword(email: email, password: password)
                                },
                                child: Container(

                                width: MediaQuery.of(context).size.width*0.48,
                                height: 40.0,
                                decoration: BoxDecoration(

                                color: Color(0xff867ae9),
                                borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Center(child: Text('Login',style: TextStyle(fontSize: 20.0,color: Colors.white),)),
                                ),
                                ),
                                SizedBox(
                                height: 50.0,
                                ),
                                Text('or sign in via',style: TextStyle(decoration:TextDecoration.underline,
                                fontSize: 20.0,color: Colors.blue,fontWeight: FontWeight.w400),),
                                Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                //crossAxisAlignment: CrossAxisAlignment.center,

                                children: [

                                GestureDetector(
                                onTap: ()async{


                                   await Provider.of<Authentication>(context,listen: false).Google_signin();
                                    print(auth.currentUser);



                                //await signinwithGoogle();


                                  Future.delayed(Duration(milliseconds: 300),(){

                                    Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                        return UserDetails(
                                          name: Provider.of<Authentication>(context).information.name,
                                          email: Provider.of<Authentication>(context).information.email,
                                          photourl: Provider.of<Authentication>(context).information.photourl,
                                        );
                                      }),);

                                  });


                                },
                                child: Material(
                                elevation: 10.0,
                                shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(100.0)),
                                child: CircleAvatar(
                                backgroundColor: Colors.redAccent,
                                child: Icon(FontAwesomeIcons.google,color: Colors.white,),
                                ),
                                ),
                                ),

                                GestureDetector(
                                onTap: ()async{
                                 await Provider.of<Authentication>(context,listen: false).signinwithFacebook();
                                  print(auth.currentUser);
                                  if(auth.currentUser!=null){
                                    Navigator.push(context, MaterialPageRoute(builder: (context){
                                      return UserDetails(
                                        name: info.name,
                                        email: info.email,
                                        photourl: info.photourl,
                                      );
                                    }),);
                                    //Navigator.push(context, route)
                                  }
                                },
                                child: Material(
                                elevation: 10.0,
                                shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(100.0)),
                                child: CircleAvatar(
                                backgroundColor: Colors.blue.shade800,
                                child: Icon(FontAwesomeIcons.facebookF),
                                ),
                                ),
                                ),



                              ],
                        ),

                        SizedBox(
                          height: 40.0,
                        ),


                  ],
                ),
                      ),
                    ),
                          ClipPath(

                            clipper: WaveClipperOne(reverse: true,flip: false),
                            child: Container(
                              color: Color(0xff867ae9),
                              alignment: Alignment.bottomCenter,
                              height: 100.0,
                            ),
                          ),

              ],
            ),
          ),
      ),
    );
  }
}

class UserInputCard extends StatelessWidget {
UserInputCard({this.text,this.icon});
String text;
IconData icon;
  @override
  Widget build(BuildContext context) {
    return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6.0),
          ),
        //color: Colors.white,


      width: MediaQuery.of(context).size.width*0.65,
      child: TextFormField(




        decoration: InputDecoration(
          border: OutlineInputBorder(

            borderSide: BorderSide.none,
          ),
          fillColor: Colors.white,
          filled: true,



          //border: OutlineInputBorder(

            //borderRadius: BorderRadius.circular(5.0),
          //),
          prefixIcon: Icon(icon,color: Color(0xff867ae9),),

          hintText: text,
          hintStyle: TextStyle(
            fontWeight: FontWeight.w700,
            color: Color(0xff867ae9),
          ),
        ),
      ),
    );
  }
}
