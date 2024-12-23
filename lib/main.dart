import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pizaaapp/repo/firebase_user_repo.dart';
import 'package:pizaaapp/simple_bloc_observer.dart';

import 'app.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//   Bloc.observer = SimpleBlocObserver();
//   runApp( MyApp(FirebaseUserRepo()));
// }


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = SimpleBlocObserver(); // Set up a Bloc observer
  runApp(MyApp(FirebaseUserRepo())); // Inject FirebaseUserRepo dependency
}