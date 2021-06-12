import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import '../Screens/user_details.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'model.dart';


final fb = FacebookLogin();
Fb_User info=Fb_User();
FirebaseAuth auth=FirebaseAuth.instance;
// Log in

GoogleSignIn signIn=GoogleSignIn();


GoogleSignInAccount account;

Future signinwithGoogle()async{
GoogleSignInAccount account=await signIn.signIn();
GoogleSignInAuthentication signInAuthentication=await account.authentication;


AuthCredential authCredential=GoogleAuthProvider.credential(accessToken: signInAuthentication.accessToken,idToken: signInAuthentication.idToken);

UserCredential credential=await auth.signInWithCredential(authCredential);
User user=credential.user;
info.email=user.email;
info.name=user.displayName;
info.photourl=user.photoURL;


}



Future signinwithFacebook()async{
FacebookLoginResult res= await FacebookLogin().logIn(permissions: [FacebookPermission.email,FacebookPermission.publicProfile]);

switch (res.status) {
case FacebookLoginStatus.success:
// Logged in

// Send access token to server for validation and auth
final FacebookAccessToken accessToken = res.accessToken;
final FacebookAuthCredential=FacebookAuthProvider.credential(accessToken.token);


UserCredential user=await auth.signInWithCredential(FacebookAuthCredential);


print('Access token: ${accessToken.token}');

// Get profile data
final profile = await fb.getUserProfile();
info.name=await profile.name;


// Get user profile image url
final imageUrl = await fb.getProfileImageUrl(width: 100);
info.photourl=await imageUrl;
print('Your profile image: $imageUrl');


// Get email (since we request email permission)
final email = await fb.getUserEmail();
info.email=await email;
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

//FacebookAccessToken token=res.accessToken;
//return info;
// return currentuser;
}


