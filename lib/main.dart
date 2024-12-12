import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'database_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  
  final dbHelper = DatabaseHelper();
  await dbHelper.database; 

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
 @override
 Widget build(BuildContext context) {
   return MaterialApp(
     title:'ALFA Y OMEGA',
     theme:(ThemeData(primarySwatch:(Colors.blue))),
     home:(LoginScreen()),
   );
 }
}
