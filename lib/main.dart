import 'package:card_3d_animation/feature/drawer_3d.dart';
import 'package:card_3d_animation/screens/home.dart';
import 'package:flutter/material.dart';

void main() => runApp(const My3dAnimationApp());

class My3dAnimationApp extends StatelessWidget {
  const My3dAnimationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      title: "Card 3D Animation",
      theme: ThemeData(
        primarySwatch: Colors.indigo
      ),
      home: const Drawer3D(),
      // routes: {
      //   '/': (context) => const Drawer3D(), 
      //   '/home': (context) => const Home(),
      // },
      // onGenerateRoute: (settings) {
      // },
    );
  }
}
