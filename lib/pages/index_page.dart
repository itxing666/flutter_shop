import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop/pages/cart_page.dart';
import 'package:flutter_shop/pages/category_page.dart';
import 'package:flutter_shop/pages/home_page.dart';
import 'package:flutter_shop/pages/member_page.dart';

// class IndexPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return new Scaffold(
//       appBar: AppBar(
//         title: Text('百姓生活+'),
//       ),
//       body: Center(
//         child: Text('百姓生活+'),
//       ),
//     );
//   }
// }

class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  PageController _pageController;

  final List<BottomNavigationBarItem> bottomTabs = [
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.home),
      title: Text('首页')
    ),
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.search),
      title: Text('分类')
    ),
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.shopping_cart),
      title: Text('购物车')
    ),
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.profile_circled),
      title: Text('会员中心')
    )
  ];

  final List<Widget> tabBodies = [
    HomePage(),
    CategoryPage(),
    CartPage(),
    MemberPage()
  ];

  int currentIndex = 0;
  var currentPage;

  @override
  void initState() {
    currentPage = tabBodies[currentIndex];
    _pageController = new PageController()
    ..addListener(() {
      if (currentPage != _pageController.page.round()) {
        setState(() {
          currentPage = _pageController.page.round();
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(244, 245, 245, 1.0),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        items: bottomTabs,
        onTap: (index){
          setState(() {
            currentIndex = index;
            currentPage = tabBodies[currentIndex];
          });
        },
      ),
      body: IndexedStack(
        index: currentIndex,
        children: tabBodies,
      )
    );
  }
}
