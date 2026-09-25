import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_app/bloc/counter_bloc/counter_bloc.dart';
import 'package:user_app/screens/counterScreen.dart';
import 'package:user_app/screens/homePage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => CounterBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'User App',
        home: const HomePage(),
      ),
    );
  }
}
