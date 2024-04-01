import 'package:flutter/material.dart';

void main() => runApp(const My3dAnimationApp());

class My3dAnimationApp extends StatelessWidget {
  const My3dAnimationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      theme: ThemeData(
        primarySwatch: Colors.indigo
      ),
      routes: {
        "/": (context) => Home(),
      },
      onGenerateRoute: (settings) {
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
