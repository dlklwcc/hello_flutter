import 'package:flutter/material.dart';
import 'top_swiper.dart';
import 'home_gridview.dart';
import '../../common.dart';
import '../../my_packages/refresh.dart';
import 'home_listview.dart';

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
          actions: [
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                refreshControllers['list'].requestRefresh();
              },
            ),
            IconButton(
              icon: Icon(Icons.arrow_downward),
              onPressed: () {
                refreshControllers['list'].requestLoading();
              },
            ),
          ],
        ),
        body: Refresh(
          controller: 'list',
          onRefresh: initOnRefresh,
          onLoading: getHttpHomePageListViewFunction,
          children: <Widget>[
            TopSwiper(),
            HomeGridView(),
            HomeListView(),
          ],
        ),
      ),
    );
  }

  void initOnRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    refreshControllers['list'].refreshCompleted();
  }
}
