import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController typeController = TextEditingController();

  String showText = '欢迎光临！';

  int swiperCount = 3;
  List swiperList = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('主页'),
          centerTitle: true,
        ),
        body: Column(
          children: <Widget>[
            Container(
              child: Image.network(
                'https://img1.baidu.com/it/u=845556811,2396112636&fm=224&fmt=auto&gp=0.jpg',
              ),
              width: 200,
              height: 150,
            ),
            Container(
              child: AspectRatio(
                //AspectRatio用来固定图片比例，container中不用固定高，适配屏幕
                aspectRatio: 16 / 9,
                child: Swiper(
                  key: UniqueKey(), //给一个key，否则会红屏报错
                  itemBuilder: (BuildContext context, int index) {
                    return FadeInImage(
                        image: NetworkImage(swiperList[index]),
                        placeholder: AssetImage('images/loading16_9.jpg'));
                    //FadeInImage(image: NetworkImage(url), placeholder: AssetImage(assetName)
                    //FadeInImage在图片正在加载或加载失败是可以展示占位图！！
                    //使用谷歌浏览器调试图片是无法加载的！！！！！
                  },
                  loop: true,
                  autoplay: true,
                  itemCount: swiperList.length,
                  pagination: new SwiperPagination(),
                  control: new SwiperControl(),
                ),
              ),
            ),
            RaisedButton(onPressed: _bottomAction),
          ],
        ),
      ),
    );
  }

  void _bottomAction() {
    print('正在请求~~');
    getHttp(typeController.text.toString()).then((value) {
      setState(() {
        swiperList.clear();
        swiperList.addAll(value['picture']);
        //example:"https://dummyimage.com/400x225/be32ac/fff.jpg"
        print(swiperList);
        print('请求成功');
      });
    });
  }

  Future getHttp(String text) async {
    try {
      Response response;
      Dio dio = Dio();
      response = await dio.post(
        'https://mock.mengxuegu.com/mock/6073090c56076a4a7648447b/shopping/homeSwiper',
      );
      return response.data;
    } catch (e) {
      return print(e);
    }
  }
}
