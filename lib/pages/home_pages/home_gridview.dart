import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../../common.dart';

class HomeGridView extends StatefulWidget {
  @override
  _HomeGridViewState createState() => _HomeGridViewState();
}

class _HomeGridViewState extends State<HomeGridView> {
  final gridWidthCount = 6;
  final gridHeightCount = 2;
  List girdList = [];
  @override
  void initState() {
    super.initState();
    getHttpHomePageGridViewFunction();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Global.size.width / gridWidthCount * 1.5 * 2,
      child: GridView(
        scrollDirection: Axis.horizontal, //使用横向时需要在父组件中设置固定高度
        //physics: NeverScrollableScrollPhysics(), // 解决拖动GridView无法上下滑动
        //shrinkWrap: true, //坑...不加shrinkWrap会报错...
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: gridHeightCount, //横轴三个子widget
          childAspectRatio: 1.5,
        ),
        children: girdList.map((val) {
          return GestureDetector(
            //套一层GestureDetector就可以添加点击事件
            onTap: () => print(val),
            child: Column(
              children: [
                Container(
                  height: Global.size.width / gridWidthCount * 1.5 * 0.8,
                  child: FadeInImage(
                    //height: double.infinity,
                    //width: double.infinity,
                    image: NetworkImage(val['img']),
                    placeholder: AssetImage('images/loading2_3.jpg'),
                    fit: BoxFit.contain,
                  ),
                ),
                Text(val['name']),
              ],
            ),
          );
        }).toList(),

        // 遍历列表以呈现多个小部件？
        // Widget getTextWidgets(List<String> strings)
        // {
        //   List<Widget> list = new List<Widget>();
        //   for(var i = 0; i < strings.length; i++){
        //       list.add(new Text(strings[i]));
        //   }
        //   return new Row(children: list);
        // }
        // 或
        // Widget getTextWidgets(List<String> strings)
        // {
        //   return new Row(children: strings.map((item) => new Text(item)).toList());
        // }
      ),
    );
  }

  void getHttpHomePageGridViewFunction() {
    print('grid正在请求~~');
    getHttpHomePageGridView().then((value) {
      setState(() {
        girdList.clear();
        girdList.addAll(value['data']);
        //example:{"img": "https://dummyimage.com/40x60 /69f626 /fff.jpg","name": "尹洋","size": "40x60"}
        //print(girdList);
        print('grid请求成功');
      });
    });
  }

  Future getHttpHomePageGridView() async {
    try {
      Response response;
      Dio dio = Dio();
      response = await dio.post(
        'https://mock.mengxuegu.com/mock/6073090c56076a4a7648447b/shopping/homegridview',
      );
      return response.data;
    } catch (e) {
      return print('grid请求失败.........');
    }
  }
}
