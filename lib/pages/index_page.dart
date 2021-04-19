import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'home_pages/home_page.dart';
import 'category_pages/category_page.dart';
import 'cart_pages/cart_page.dart';
import 'member_pages/member_page.dart';
import '../common.dart';

class InitPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Global.size = MediaQuery.of(context).size;
    print('width=${Global.size.width},height=${Global.size.height}');
    return Container(
      child: IndexPage(),
    );
  }
}

class IndexPage extends StatefulWidget {
  _IndexPagestate createState() => _IndexPagestate();
}

class _IndexPagestate extends State<IndexPage> {
  final List<BottomNavigationBarItem> bottomTabs = [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      title: Text(('首页')),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.view_module),
      title: Text(('分类')),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.shopping_cart),
      title: Text(('购物车')),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person),
      title: Text(('会员中心')),
    ),
  ];

  final List tabBodies = <Widget>[
    HomePage(),
    CategoryPage(),
    CartPage(),
    MemberPage(),
  ];

  int currentIndex = 0;
  var currentPage;

  @override
  void initState() {
    currentPage = tabBodies[currentIndex];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        //使在底部导航栏切换时保持各个页面的状态
        //在各个页面state函数添加with AutomaticKeepAliveClientMixin 及bool get wantKeepAlive => true;
        //例如：
        //class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {
        //  @override
        //  bool get wantKeepAlive => true;
        //}
        index: currentIndex,
        children: tabBodies,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        items: bottomTabs,
        onTap: (index) {
          setState(() {
            currentIndex = index;
            currentPage = tabBodies[currentIndex];
          });
        },
      ),
    );
  }
}
