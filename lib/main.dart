import 'package:burger_order/screens/burger_order_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const BurgerOrderApp());
}

class BurgerOrderApp extends StatelessWidget {
  const BurgerOrderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'طلب أكل',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        fontFamily: 'Cairo',
      ),
      debugShowCheckedModeBanner: false,
      home: const BurgerOrderScreen(),
    );
  }
}
