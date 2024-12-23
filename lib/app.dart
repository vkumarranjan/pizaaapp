import 'package:flutter/material.dart';
import 'package:pizaaapp/repo/user_repo.dart';
import 'app_view.dart';
import 'blocs/authentication_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatelessWidget {
  final UserRepository userRepository;
  const MyApp(this.userRepository, {super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<AuthenticationBloc>(
      create: (context) => AuthenticationBloc(
          userRepository: userRepository
      ),
      child: const MyAppView(),
    );
  }
}