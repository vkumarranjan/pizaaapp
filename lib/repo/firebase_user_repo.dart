
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:rxdart/rxdart.dart';
import 'entities/user_entity.dart';
import 'models/users.dart';
import 'user_repo.dart';

class FirebaseUserRepo implements UserRepository {
  final FirebaseAuth _firebaseAuth;
  final userCollection = FirebaseFirestore.instance.collection('users');

  FirebaseUserRepo({
    FirebaseAuth? firebaseAuth
  }) : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  @override
  // TODO: implement user
  Stream<MyUser?> get user {
    return _firebaseAuth.authStateChanges().flatMap((firebaseuser) async* {
      if(firebaseuser == null) {
        yield MyUser.empty;
      } else {
        yield  await userCollection
            .doc(firebaseuser.uid)
            .get()
            .then((value) => MyUser.fromEntity(MyUserEntity.fromDocument(value.data()!)));
      }
    });
  }

  @override
  // Future<void> signIn(String email, String password) async {
  //   try {
  //     await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
  //   } catch (e) {
  //     log('Error: ${e.toString()}');
  //     rethrow;
  //   }
  // }

  Future<void> signIn(String email, String password) async {
    try {
      log('Email: $email' as num); // Debug log
      log('Password: $password' as num); // Debug log

      await _firebaseAuth.signInWithEmailAndPassword(
        email: email.trim(), // Ensure no whitespace issues
        password: password,
      );
    } catch (e) {
      log('Error: ${e.toString()}' as num);
      rethrow;
    }
  }


  @override
  Future<MyUser> signUp(myUser, String password) async {
    try {
      UserCredential user = await _firebaseAuth.createUserWithEmailAndPassword(
          email: myUser.email,
          password: password
      );
      myUser.userId = user.user!.uid;
      return myUser;
    } catch (e) {
      log('Error: ${e.toString()}' as num);
      rethrow;
    }
  }

  @override
  Future<void> setUserData(user) async {
    try {
      await userCollection
          .doc(user.userId)
          .set(user.toEntity().toDocument());

    } catch (e) {
      log('Error: ${e.toString()}' as num);
      rethrow;
    }
  }

  @override
  Future<void> logout() async{
    _firebaseAuth.signOut();
  }


}

