import 'package:flutter/material.dart';
import 'package:money_tracker/screens/home_screen.dart';
import 'package:provider/provider.dart';
import 'providers/transaction_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TransactionProvider(),

      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Pocket Tracker',
        theme: ThemeData(primaryColor: Colors.green),
        home: HomeScreen(),
      ),
    );
  }
}
