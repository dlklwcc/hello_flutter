import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

// 提供五套可选主题色
const _themes = <MaterialColor>[
  Colors.blue,
  Colors.cyan,
  Colors.teal,
  Colors.green,
  Colors.red,
];

class Global {
  // 可选的主题列表
  static List<MaterialColor> get themes => _themes;

  // 是否为release版
  static bool get isRelease => bool.fromEnvironment("dart.vm.product");
  //屏幕尺寸
  static Size size = Size.zero;
}

class Api {
  static String rootApi =
      'https://mock.mengxuegu.com/mock/6073090c56076a4a7648447b/shopping';
  static Map<String, String> api = {
    '首页轮播': '/homeSwiper',
    '首页导航': '/homegridview',
    '首页商品列表': '/homelistview',
  };
}

Future PostHttp(String text) async {
  print('$text 正在请求post~~~~~~~~~~~~~~');
  try {
    Response response;
    Dio dio = Dio();
    response = await dio.post(
      Api.rootApi + Api.api[text],
      //data: FormData.fromMap({'size': '200x50'}),
    );
    print('$text 请求成功post~~~~~~~~~~~~~~');
    return response.data;
  } catch (e) {
    return print('$text 请求失败post!!!!!!!!!!!!!!!!');
  }
}
