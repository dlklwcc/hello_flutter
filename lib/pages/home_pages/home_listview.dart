import 'package:flutter/material.dart';
import 'package:hello_flutter/common.dart';

ValueNotifier<int> listviewListlength = ValueNotifier<int>(0);

void getHttpHomePageListViewFunction() {
  PostHttp('首页商品列表').then((value) {
    //listviewList.clear();
    _HomeListViewState.listviewList.addAll(value['data']);
    listviewListlength.value = _HomeListViewState.listviewList.length;
  });
}

class HomeListView extends StatefulWidget {
  @override
  _HomeListViewState createState() => _HomeListViewState();
}

class _HomeListViewState extends State<HomeListView> {
  static List listviewList = [];
  @override
  void initState() {
    super.initState();
    getHttpHomePageListViewFunction();
    listviewListlength.value = listviewList.length;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      builder: (BuildContext context, int value, Widget child) {
        return Container(
          child: ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (c, i) {
              final val = listviewList[i];
              return GestureDetector(
                //套一层GestureDetector就可以添加点击事件
                onTap: () => print(val),
                child: Column(
                  children: [
                    Container(
                      height: 100,
                      child: FadeInImage(
                        //height: double.infinity,
                        //width: double.infinity,
                        image: NetworkImage(val['img']),
                        placeholder: AssetImage('images/loading16_9.jpg'),
                        fit: BoxFit.contain,
                      ),
                    ),
                    Text(val['name']),
                  ],
                ),
              );
            },
            itemExtent: 140.0,
            itemCount: listviewList.length,
          ),
        );
      },
      valueListenable: listviewListlength,
    );
  }
}
