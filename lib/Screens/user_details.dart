import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login_screen.dart';
import '../Methods/sign_in.dart';
//User _user;
class UserDetails extends StatefulWidget {
  static const user='user';
  String name;
  String email;
  String photourl;

  UserDetails({this.name,this.email,this.photourl});
  @override
  _UserDetailsState createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
Future<void> signout()async{
  await auth.signOut();
  await signIn.signOut();
  await fb.logOut();
}
@override

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(


        textTheme: Theme.of(context).textTheme.apply(
          displayColor: Colors.white,
          bodyColor: Colors.white,
        ),

        //backgroundColor: Color(0xffa5e1ad),
      ),
        home:Scaffold(
          backgroundColor: Color(0xffb4aee8),

      body:
          Stack(
            children: [
              Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  SizedBox(
                    height: MediaQuery.of(context).size.height*0.25,
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: double.infinity,
                      //  height: 300.0,

                        child:  Column(

                          children: [
                            SizedBox(height: 120.0,),
                            Column(

                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                               children: [



                                    Text('WELCOME!',style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w500),),
                                    Text(widget.name,style: TextStyle(fontFamily: 'Pacifico',fontSize: 40.0),),
                                    Container(
                                      height: 3.0,
                                      width: MediaQuery.of(context).size.width*0.5,
                                      color: Colors.white,

                                    ),
                                    Container(
                                      height: 2.0,
                                      width: double.infinity,
                                    ),

                                    Card(
                                      color: Colors.white,
                                      elevation: 10.0,
                                      child: ListTile(
                                        title: Text(widget.email,style: TextStyle(color: Color(0xff867ae9)),),
                                        leading: Icon(Icons.mail,color: Color(0xff867ae9),),
                                      ),
                                    ),


                                // Text(widget.email),
                               ],
                            ),
                              SizedBox(
                                height: 50.0,
                              ),
                            MaterialButton(
                              elevation: 10.0,
                              onPressed: ()async{
                                await signout();

                                Navigator.pop(context);
                              },
                              child: Container(
                                  height: 50.0,
                                width: 100.0,
                                padding: EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: Center(child: Text('LOGOUT')),
                              ),
                            ),
                          ],
                        ),
                        decoration: BoxDecoration(

                           color: Color(0xff867ae9),
                            borderRadius: BorderRadius.circular(20.0),
                        ),
                        //child: ,
                      ),
                    ),
                  ),
                  Container(
                  ),

                ],
              ),
              Positioned(
                left: MediaQuery.of(context).size.width*0.36,
                top: MediaQuery.of(context).size.height*0.10,

                child: Container(
                  alignment: Alignment.center,
                  height: MediaQuery.of(context).size.height*0.32,
                  width: MediaQuery.of(context).size.width*0.30,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.contain,
                      image: NetworkImage(widget.photourl),
                    ),
                  ),
                  //child: Image(image: NetworkImage(widget.photourl),fit: BoxFit.fill,),
                ),
              ),







        ],
      ),
        ),
    );
  }
}
