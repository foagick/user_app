import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Badge(
              label: Text('3'),
              child: Icon(Icons.shopping_cart),
            ),
          ),
        ],
        title: Text('User App'), centerTitle: true),
      body: Center(
        child: Text('Welcome to the User App!'),
      ),
    );
  }
}