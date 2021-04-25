import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
//import 'package:flutter/services.dart';
import './pages/index_page.dart';
import 'package:provider/provider.dart';
import 'pages/provider/providers.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Counter()),
        ChangeNotifierProvider(create: (_) => Counter111()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //SystemChrome.setEnabledSystemUIOverlays([]);//隐藏状态栏
    return Container(
      child: MaterialApp(
        title: 'shopping',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.pink,
        ),
        home: InitPage(),
      ),
    );
  }
}
