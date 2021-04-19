import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import '../../common.dart';

class TopSwiper extends StatefulWidget {
  @override
  _TopSwiperState createState() => _TopSwiperState();
}

class _TopSwiperState extends State<TopSwiper> {
  TextEditingController typeController = TextEditingController(); //文本输入框变量字符
  int swiperCount = 3;
  List swiperList = [];

  //初始化方法，刷新build不会再执行
  @override
  void initState() {
    super.initState();
    getHttpHomePageSwiperFunction();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AspectRatio(
        //AspectRatio用来固定图片比例，container中不用固定高，适配屏幕
        aspectRatio: 16 / 9,
        child: Swiper(
          key: UniqueKey(), //给一个key，否则会红屏报错
          itemBuilder: (BuildContext context, int index) {
            return FadeInImage(
              image: NetworkImage(swiperList[index]),
              placeholder: AssetImage('images/loading16_9.jpg'),
              fit: BoxFit.contain,
            );

            //FadeInImage(image: NetworkImage(url), placeholder: AssetImage(assetName)
            //FadeInImage在图片正在加载或加载失败是可以展示占位图！！
            //使用谷歌浏览器调试图片是无法加载的！！！！！
          },
          loop: true,
          autoplay: true,
          itemCount: swiperList.length,
          onTap: onTap,
          pagination: new SwiperPagination(),
          control: new SwiperControl(),
          //itemWidth: 200.0,
          viewportFraction: 0.7,
          scale: 0.8,
        ),
      ),
    );
  }

  void onTap(int index) {
    print(index);
    getHttpHomePageSwiperFunction();
  }

  void getHttpHomePageSwiperFunction() {
    //print('正在请求~~');
    getHttpHomePageSwiper(typeController.text.toString()).then((value) {
      setState(() {
        swiperList.clear();
        swiperList.addAll(value['picture']);
        //example:"https://dummyimage.com/400x225/be32ac/fff.jpg"
        //print(swiperList);
        //print('请求成功');
      });
    });
  }

  Future getHttpHomePageSwiper(String text) async {
    try {
      Response response;
      Dio dio = Dio();
      response = await dio.post(
        'https://mock.mengxuegu.com/mock/6073090c56076a4a7648447b/shopping/homeSwiper',
        //data: FormData.fromMap({'size': '200x50'}),
      );
      return response.data;
    } catch (e) {
      return print(e);
    }
  }
}
