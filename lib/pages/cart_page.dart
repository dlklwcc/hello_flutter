import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

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
          child: Text('购物车'),
        ),
      ),
    );
  }
}
