import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
//创建一个上拉加载，下拉刷新的组件；
//controller为可选参数，当只有一个refresh组件时不需要传入，
//  有多个refresh组件为区分每个组件，可以分别操作，需要传入string类型的key
//垂直拉动时，若本组件比屏幕高度更长，则无法拉回到顶部的组件，只能将垂直方向所有组件全部放入本组件中
//水平同理
//

//创建全局类存放所有refresh组件的controller

Map refreshControllers = <String, RefreshController>{
  'default': RefreshController(),
};

class Refresh extends StatefulWidget {
  final double width;
  final double height;
  final Axis direction;
  final List<Widget> children;
  final Function onRefresh;
  final Function onLoading;
  final String controller;
  const Refresh({
    Key key,
    this.width,
    this.height,
    this.direction = Axis.vertical,
    this.children,
    this.onRefresh,
    this.onLoading,
    this.controller = 'default',
  }) : super(key: key);

  @override
  _RefreshState createState() => _RefreshState();
}

class _RefreshState extends State<Refresh> {
  void _onRefresh() {
    //final k = widget.onRefresh();
    if (widget.onRefresh == null)
      // if failed,use refreshFailed(),if successful,use refreshCompleted()
      //没有传入刷新函数，即为刷新失败
      refreshControllers[widget.controller].refreshFailed();
    else {
      widget.onRefresh();
      if (mounted)
        setState(() {
          refreshControllers[widget.controller].refreshCompleted();
        });
    }
  }

  void _onLoading() {
    //final k = widget.onRefresh();
    if (widget.onLoading == null)
      // if failed,use loadFailed(),if no data return,use LoadNodata(),if successful,use loadComplete()
      //没有传入刷新函数，即为加载失败
      refreshControllers[widget.controller].loadFailed();
    else {
      widget.onLoading();
      if (mounted)
        setState(() {
          refreshControllers[widget.controller].loadComplete();
        });
    }
  }

  @override
  void initState() {
    super.initState();
    if (refreshControllers.containsKey(widget.controller))
      ;
    else
      refreshControllers[widget.controller] = RefreshController();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      child: SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        header: WaterDropHeader(),
        footer: CustomFooter(
          builder: (BuildContext context, LoadStatus mode) {
            Widget body;
            if (mode == LoadStatus.idle) {
              body = Text("上拉加载");
            } else if (mode == LoadStatus.loading) {
              body = CupertinoActivityIndicator();
            } else if (mode == LoadStatus.failed) {
              body = Text("加载失败！点击重试！");
            } else if (mode == LoadStatus.canLoading) {
              body = Text("松手,加载更多!");
            } else {
              body = Text("没有更多数据了!");
            }
            return Container(
              height: 55.0,
              child: Center(child: body),
            );
          },
        ),
        controller: refreshControllers[widget.controller],
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child: SingleChildScrollView(
          scrollDirection: widget.direction,
          child: Flex(
            direction: widget.direction,
            children: widget.children,
          ),
        ),
      ),
    );
  }
}

// 全局配置子树下的SmartRefresher,下面列举几个特别重要的属性
//  RefreshConfiguration(
//      headerBuilder: () => WaterDropHeader(),        // 配置默认头部指示器,假如你每个页面的头部指示器都一样的话,你需要设置这个
//      footerBuilder:  () => ClassicFooter(),        // 配置默认底部指示器
//      headerTriggerDistance: 80.0,        // 头部触发刷新的越界距离
//      springDescription:SpringDescription(stiffness: 170, damping: 16, mass: 1.9),         // 自定义回弹动画,三个属性值意义请查询flutter api
//      maxOverScrollExtent :100, //头部最大可以拖动的范围,如果发生冲出视图范围区域,请设置这个属性
//      maxUnderScrollExtent:0, // 底部最大可以拖动的范围
//      enableScrollWhenRefreshCompleted: true, //这个属性不兼容PageView和TabBarView,如果你特别需要TabBarView左右滑动,你需要把它设置为true
//      enableLoadingWhenFailed : true, //在加载失败的状态下,用户仍然可以通过手势上拉来触发加载更多
//      hideFooterWhenNotFull: false, // Viewport不满一屏时,禁用上拉加载更多功能
//      enableBallisticLoad: true, // 可以通过惯性滑动触发加载更多
//     child: MaterialApp(
//         ........
//     )
// );
//
//  请求顶部指示器刷新,触发onRefresh
//   void requestRefresh(
//       {Duration duration: const Duration(milliseconds: 300),
//       Curve curve: Curves.linear});
//  // 请求底部指示器加载数据,触发onLoading
//   void requestLoading(
//       {Duration duration: const Duration(milliseconds: 300),
//       Curve curve: Curves.linear}) ;
//   //  主动打开二楼
//   void requestTwoLevel(
//             {Duration duration: const Duration(milliseconds: 300),
//             Curve curve: Curves.linear});

//   // 顶部指示器刷新成功,是否要还原底部没有更多数据状态
//   void refreshCompleted({bool resetFooterState:false});
//   // 不显示任何状态,直接变成idle状态隐藏掉
//   void refreshToIdle();
//   // 顶部指示器刷新失败
//   void refreshFailed();
//   // 关闭二楼
//   void twoLevelComplete(
//    {Duration duration: const Duration(milliseconds: 500),
//    Curve curve: Curves.linear};
//   // 底部指示器加载完成
//   void loadComplete();
//   // 底部指示器进入一个没有更多数据的状态
//   void loadNoData();
//   // 底部加载失败
//   void loadFailed()
//   // 刷新底部指示器状态为idle
//   void resetNoData();
