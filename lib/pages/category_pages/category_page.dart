import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../provider/providers.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${context.watch<Counter>().val}',
                style: TextStyle(fontSize: 30),
              ),
              FloatingActionButton(
                child: Icon(Icons.add),
                onPressed: () {
                  context.read<Counter>().increment();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
