import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:psmna10/models/user_model.dart';

class GoogleAuth {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  Future<UserModel> signInWithGoogle() async {
    this.signOutWithGoogle();
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      UserModel user=UserModel.fromFirebaseUser(userCredential.user!);
      return user;
    } catch (e) {
      print(e);
      return UserModel(name: null);
    }
  }

  Future<int> registerWithGoogle() async {
    this.signOutWithGoogle();
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: googleUser.email,
        password: googleAuth.accessToken.toString(),
      );
      await userCredential.user!.linkWithCredential(credential);
      userCredential.user!.sendEmailVerification();
      print('User registered: ${userCredential.user}');
      return 1;
    } catch (e) {
      if(e.toString().contains('already')){
        return 2;
      }else{
        return 3;
      }
    }
  }

  Future<bool> signOutWithGoogle() async {
    try {
      await _googleSignIn.signOut();
      await FirebaseAuth.instance.signOut();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

}


/*import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:proyectofinal_cont_rdz/models/user_model.dart';
import 'package:proyectofinal_cont_rdz/screens/dashboard_screen.dart';
import 'package:proyectofinal_cont_rdz/screens/signin_screen.dart';

class GoogleAuth{
   //Determine if the user is authenticated.
  handleAuthState() {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            return  DashboardScreen();
            
            //Navigator.pushNamed(context, '/dash');
          } else {
            return const SignInScreen();
          
          }
        });
  }


  signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn(
        scopes: <String>["email"]).signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }


   //Sign out
  signOut() {
    FirebaseAuth.instance.signOut();
  }



  Future<UserModel> signInWithFacebook() async {
    this.signOut();
    try {
      final LoginResult result = await GoogleSignIn.login();
      if (result.status == LoginStatus.success) {
        final AccessToken accessToken = result.accessToken!;
        final OAuthCredential credential =
            FacebookAuthProvider.credential(accessToken.token);
        final UserCredential userCredential =
            await auth.signInWithCredential(credential);
        print('User login: ${userCredential.user}');
        UserModel user=UserModel.fromFirebaseUser(userCredential.user!);
        return user;
      } else {
        return UserModel(name:null);
      }
    } catch (e) {
      print('Error signing in with Facebook: $e');
      return UserModel(name: null);
    }
  }
}*/