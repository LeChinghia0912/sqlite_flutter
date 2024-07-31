import 'package:flutter/material.dart';
import 'package:sqlite_flutter/Authtentication/login.dart';
import 'package:sqlite_flutter/Authtentication/signup.dart';
import 'package:sqlite_flutter/screen/product_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ExampleSqlite());
}

class ExampleSqlite extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Todo List',
      home: LoginScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}