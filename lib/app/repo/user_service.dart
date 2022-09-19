import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_chat/app/data/user_model.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserService {
  static final UserService _instance = UserService._internal();

  factory UserService() => _instance;

  UserService._internal();

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
    // Create a new credential
    print(googleAuth?.accessToken);

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future createNewUser(UserModel userModel) async {
    DocumentReference<Map<String, dynamic>> documentReference = FirebaseFirestore.instance.collection('users').doc(userModel.userKey);

    final DocumentSnapshot<Map<String, dynamic>> documentSnapshot = await documentReference.get();

    if(!documentSnapshot.exists){
      await documentReference.set(userModel.toJson());
    }
  }

  Future<UserModel> getUserInfo(String userKey) async {
    DocumentReference<Map<String, dynamic>> documentReference = FirebaseFirestore.instance.collection('users').doc(userKey);
    
    final DocumentSnapshot<Map<String,dynamic>> documentSnapshot = await documentReference.get();
    
    return UserModel.fromSnapshot(documentSnapshot);
  }
}