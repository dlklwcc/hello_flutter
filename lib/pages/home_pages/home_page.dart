import 'package:flutter/material.dart';
import 'top_swiper.dart';
import 'home_gridview.dart';
import '../../common.dart';

//首页轮播图片
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('主页'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              TopSwiper(),
              HomeGridView(),
            ],
          ),
        ),
      ),
    );
  }
}
