import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizaaapp/blocs/authentication_bloc.dart';
import 'package:pizaaapp/screens/auth/view/welcome_screen.dart';
import 'package:pizaaapp/screens/home/view/home_screen.dart';

class MyAppView extends StatelessWidget {
  const MyAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pizza Delivery',
      debugShowCheckedModeBanner: true,
      theme: ThemeData(
        colorScheme: ColorScheme.light(
          surface: Colors.grey.shade100,
          onSurface: Colors.black,
          primary: Colors.blue,
          onPrimary: Colors.white
        )
      ),
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (( context, state) {
          if (state.status == AuthenticationState.authenticated) {
            return HomeScreen();
          } else {
            return WelcomeScreen();
          }
        }),

      ),
    );
  }
}
