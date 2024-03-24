import 'package:flutter/material.dart';

void main() => runApp(my3DAnimationApp());

class my3DAnimationApp extends StatelessWidget {
  const my3DAnimationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      home: Home(),
      routes: {
        
      },
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
    );
  }
}
