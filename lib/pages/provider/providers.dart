import 'package:flutter/material.dart';

//https://pub.dev/packages/provider/versions/5.0.0/example
//main函数要改变，provide配置要在Myapp前面
//runApp(
//   MultiProvider(
//     providers: [
//       ChangeNotifierProvider(create: (_) => Counter()),
//     ],
//     child: MyApp(),
//   ),
// );
//
//定义类：Counter111
//监控值：context.watch<Counter111>().val
//调用方法：context.read<Counter111>().increment()

class Counter with ChangeNotifier {
  int val = 0;
  increment() {
    val++;
    notifyListeners();
  }
}

class Counter111 with ChangeNotifier {
  String codeText = '';
  increment() {
    //codeText++;
    notifyListeners();
  }
}
