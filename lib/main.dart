import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Provider/Provider.dart';
import 'Widget/BarStock.dart';
import 'Display/MyHomePage.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ListProvider()),
        ChangeNotifierProvider(create: (_) => BarStockProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FSS Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Color(0xFF23272A),
      ),
      home: MyHomePage(),
    );
  }
}














