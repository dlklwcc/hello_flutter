import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../../my_packages/verify_code.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: Center(
          child: Container(
            height: 300,
            width: 300,
            child: Column(children: [
              Center(
                child: VerifyCode(
                  controller: '第一个',
                ),
              ),
              Center(
                child: VerifyCode(),
              ),
              ElevatedButton(
                onPressed: () => VerifyCodeSubmit(
                  successCallBack: () {
                    print('验证码正确');
                  },
                  failCallBack: () {
                    print('验证码错误');
                  },
                  controller: '第一个',
                ),
                child: Text('data'),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
