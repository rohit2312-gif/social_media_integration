import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'model.dart';
class Authentication extends ChangeNotifier {
  FirebaseAuth auth = FirebaseAuth.instance;
  Fb_User info = Fb_User();

  //Future<User>Google_signin(
  User _user;

  User get user => _user;



  Fb_User get information=>info;

  Future<AuthCredential> Google_signin() async {

    GoogleSignIn googleSignIn = GoogleSignIn();
    GoogleSignInAccount account;
try {
  GoogleSignInAccount signInAccount = await googleSignIn.signIn();
  GoogleSignInAuthentication authentication = await signInAccount
      .authentication;

  AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: authentication.accessToken,
      idToken: authentication.idToken);

  Firebase_signin(credential);
}
catch(e){
  print(e);
}
}

  Future signinwithFacebook() async {
    final fb = FacebookLogin();
    FacebookLoginResult res = await FacebookLogin().logIn(permissions: [
      FacebookPermission.email,
      FacebookPermission.publicProfile
    ]);

    switch (res.status) {
      case FacebookLoginStatus.success:
// Logged in

// Send access token to server for validation and auth
        final FacebookAccessToken accessToken = res.accessToken;
        final FacebookAuthCredential = FacebookAuthProvider.credential(
            accessToken.token);

        // return FacebookAuthCredential;
        Firebase_signin(FacebookAuthCredential);



        print('Access token: ${accessToken.token}');

// Get profile data
        final profile = await fb.getUserProfile();
        info.name = await profile.name;


// Get user profile image url
        final imageUrl = await fb.getProfileImageUrl(width: 100);
        info.photourl = await imageUrl;
        print('Your profile image: $imageUrl');


// Get email (since we request email permission)
        final email = await fb.getUserEmail();
        info.email = await email;
// But user can decline permission
        if (email != null)
          print('And your email is $email');

        break;
      case FacebookLoginStatus.cancel:
// User cancel log in
        break;
      case FacebookLoginStatus.error:
// Log in failed
        print('Error while log in: ${res.error}');
        break;
    }
  }


    Future<User> Firebase_signin(AuthCredential credential) async {
     // AuthCredential authCredential = await Google_signin();

    UserCredential userCredential=await auth.signInWithCredential(credential);
      _user = auth.currentUser;
      info.email=userCredential.user.email;
      info.name=userCredential.user.displayName;
      info.photourl=userCredential.user.photoURL;
      //return auth.currentUser;
        //User user=credential.user;
      notifyListeners();
    }


  Future<void> signout()async{
    await auth.signOut();
    notifyListeners();
  //  await signIn.signOut();
    //await fb.logOut();
  }
  }


//int x;

// FirebaseAuth _auth=FirebaseAuth.instance;


