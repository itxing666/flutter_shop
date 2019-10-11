import 'dart:convert';
import 'dart:core';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/config/httpHeaders.dart';
import 'package:flutter_shop/service/service_method.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:url_launcher/url_launcher.dart';

// class HomePage extends StatelessWidget {

//   @override
//   Widget build(BuildContext context) {
//     // getHttp();
//     return Scaffold(
//       body: Center(
//         child: Text('商城首页1'),
//       ),
//     );
//   }

  //   void getHttp()async {
  //   try{
  //     Response response;
  //     // var data = {'name': '技术胖'};
  //     response = await Dio().get(
  //       "https://www.easy-mock.com/mock/5c60131a4bed3a6342711498/baixing/dabaojian?name=大胸美女"
  //       //  queryParameters:data
  //     );
  //     print(response);
  //   }catch(e) {
  //     print('=========');
  //     print(e);
  //   }
  // }
// }

// class HomePage extends StatefulWidget {
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {

//   TextEditingController typeController = TextEditingController();
//   String showText = '欢迎你来到美好人间';
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         child: Scaffold(
//           appBar: AppBar(title: Text('美好人间'),),
//           body:Container(
//             height: 1000.0,
//             child: Column(
//               children: <Widget>[
//                 TextField(
//                   controller:typeController,
//                   decoration:InputDecoration (
//                     contentPadding: EdgeInsets.all(10.0),
//                     labelText: '美女类型',
//                     helperText: '请输入你喜欢的类型'
//                   ),
//                   autofocus: false,
//                 ),
//                 RaisedButton(
//                   onPressed:_choiceAction,
//                   child: Text('选择完毕'),
//                 ),
//                 Text(
//                   showText,
//                     overflow:TextOverflow.ellipsis,
//                     maxLines: 2,
//                 ),
//                 ],
//             ),
//           )
//         ),
//     );
//   }

//   void _choiceAction(){
//     print('开始选择你喜欢的类型............');
//     if(typeController.text.toString()==''){
//       showDialog(
//         context: context,
//         builder: (context)=>AlertDialog(title:Text('美女类型不能为空'))
//       );
//     }else{
//         getHttp(typeController.text.toString()).then((val){
//          setState(() {
//            showText=val['data']['name'].toString();
//          });
//         });
//         // setState(() {
//         //    showText='test';
//         // });
//     }

//   }

//   Future getHttp(String typeText)async{
//     try{
//       Response response;
//       var data={'name': typeText};
//       response = await Dio().get(
//         "https://www.easy-mock.com/mock/5c60131a4bed3a6342711498/baixing/dabaojian",
//           queryParameters:data
//       );
//       print('========================='+response.data['data']['name']);
//       return response.data;
//     }catch(e){
//       return print(e);
//     }
//   }
// }


// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   String showText = "还没有请求数据";
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Scaffold(
//         appBar: AppBar(title: Text('请求远程数据'),),
//         body: SingleChildScrollView(
//           child: Column(
//             children: <Widget>[
//               RaisedButton(
//                 onPressed: _jike,
//                 child: Text('请求数据'),
//               ),
//               Text(showText)
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//   void _jike() {
//     print('开始向极客时间请求数据..................');
//     getHttp().then((val) {
//       setState(() {
//         showText = val['data'].toString();
//       });
//     });
//   }

//   Future getHttp() async {
//     try{
//       Response response;
//       Dio dio = new Dio();
//       dio.options.headers = httpHeaders;
//       response = await dio.get("https://time.geekbang.org/serv/v1/column/newAll");
//       print(response);
//       return response.data;

//     }catch(e){
//       return print(e);
//     }
//   }
// }



class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {
  // String homePageContent = '正在获取数据';
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   getHomePageContent().then((val) {
  //     setState(() {
  //       homePageContent = val.toString();
  //     });
  //   });
  //   super.initState();
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('111111111111111111111111111');
  }

    @override
  bool get wantKeepAlive =>true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('百姓生活+'),),
      // body: Text(homePageContent),
      body: FutureBuilder(
        future: getHomePageContent(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var data = json.decode(snapshot.data.toString());
            print(data['data'].toString());
            List<Map> swiperDataList = (data['data']['slides'] as List).cast(); // 顶部轮播组件数
            List<Map> navigatorList = (data['data']['category'] as List).cast();
            String advertestPicture = data['data']['advertesPicture']['PICTURE_ADDRESS']; //广告图片
            String  leaderImage= data['data']['shopInfo']['leaderImage'];  //店长图片
            String  leaderPhone = data['data']['shopInfo']['leaderPhone']; //店长电话
            List<Map> recommendList = (data['data']['recommend'] as List).cast(); // 商品推荐
            String floor1Title =data['data']['floor1Pic']['PICTURE_ADDRESS'];//楼层1的标题图片
            String floor2Title =data['data']['floor2Pic']['PICTURE_ADDRESS'];//楼层2的标题图片
            String floor3Title =data['data']['floor3Pic']['PICTURE_ADDRESS'];//楼层3的标题图片
            List<Map> floor1 = (data['data']['floor1'] as List).cast(); //楼层1商品和图片
            List<Map> floor2 = (data['data']['floor2'] as List).cast(); //楼层2商品和图片
            List<Map> floor3 = (data['data']['floor3'] as List).cast(); //楼层3商品和图片
             if (navigatorList.length > 10) {
               navigatorList.removeRange(10, navigatorList.length);
             }
             return SingleChildScrollView(
               child: Column(
                children: <Widget>[
                  SwiperDiy(swiperDataList: swiperDataList,),
                  TopNavigator(navigatorList: navigatorList),
                  ADBanner(advertestPicture: advertestPicture),
                  LeaderPhone(leaderImage:leaderImage,leaderPhone: leaderPhone),  //广告组件
                  Recommend(recommendList:recommendList),
                  FloorTitle(pictureAddress:floor1Title),
                  FloorContent(floorGoodsList:floor1),
                  FloorTitle(pictureAddress:floor2Title),
                  FloorContent(floorGoodsList:floor2),
                  FloorTitle(pictureAddress:floor3Title),
                  FloorContent(floorGoodsList:floor3)
                ],
              ),
            );
          } else {
            return Center(
              child: Text('加载中'),
            );
          }
        },
      ),
    );
  }
}


class SwiperDiy extends StatelessWidget {
  final List swiperDataList;
  SwiperDiy({Key key, this.swiperDataList}):super(key:key);
  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
    print('设备宽度：${ScreenUtil.screenWidth}');
    print('设备高度：${ScreenUtil.screenHeight}');
    return Container(
      height: ScreenUtil().setHeight(333),
      width: ScreenUtil().setWidth(750),
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return Image.network("${swiperDataList[index]['image']}",fit:BoxFit.fill);
        },
        itemCount: swiperDataList.length,
        pagination: new SwiperPagination(),
        autoplay: true,
      ),
    );
  }
}


class TopNavigator extends StatelessWidget {
  final List navigatorList;
  TopNavigator({Key key, this.navigatorList}) : super(key: key);

  Widget _gridViewItemUI(BuildContext context, item) {
    return InkWell(
      onTap: () { print('点击了导航'); },
      child: Column(
        children: <Widget>[
          Image.network(item['image'], width:ScreenUtil().setWidth(95)),
          Text(item['mallCategoryName'])
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(320),
      padding: EdgeInsets.all(3.0),
      child: GridView.count(
        crossAxisCount: 5,
        padding: EdgeInsets.all(4.0),
        children: navigatorList.map((item) {
          return _gridViewItemUI(context, item);
        }).toList(),
      ),
    );
  }
}

class ADBanner extends StatelessWidget {
  final String advertestPicture;
  ADBanner({ Key key, this.advertestPicture }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.network(advertestPicture),
    );
  }
}


class LeaderPhone extends StatelessWidget {
  final String leaderImage; // 店长图片
  final String leaderPhone; // 店长电话
  LeaderPhone({Key key, this.leaderImage, this.leaderPhone}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: _launchURL,
        child: Image.network(leaderImage),
      ),
    );
  }

  void _launchURL() async {
    String url = 'tel:' + leaderPhone;
    print(url);
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not lauch $url';
    }
  }
}

// 商品推荐
class Recommend extends StatelessWidget {
  final List recommendList;
  Recommend({Key key, this.recommendList}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(380),
      margin: EdgeInsets.only(top: 10.0),
      child: Column(
        children: <Widget>[
          _titleWidget(),
          _recommedList()
        ],
      ),
    );
  }

  // 推荐商品标题
  Widget _titleWidget() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.fromLTRB(10.0, 2.0, 0, 5.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(width: 1, color: Colors.black12)
        )
      ),
      child: Text(
        '商品推荐',
        style: TextStyle(
          color: Colors.pink
        )
      ),
    );
  }

  Widget _item(index) {
    return InkWell(
      onTap: () {},
      child: Container(
        height: ScreenUtil().setHeight(330),
        width: ScreenUtil().setWidth(250),
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            left: BorderSide(width:1,color:Colors.black12)
          )
        ),
        child: Column(
          children: <Widget>[
            Image.network(recommendList[index]['image']),
            Text('¥${recommendList[index]['mallPrice']}'),
            Text(
              '¥${recommendList[index]['price']}',
              style: TextStyle(
                decoration: TextDecoration.lineThrough,
                color: Colors.grey
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _recommedList() {
    return Container(
      height: ScreenUtil().setWidth(330),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: recommendList.length,
        itemBuilder: (context,index) {
          return _item(index);
        },
      ),
    );
  }
}

// 楼层标题
class FloorTitle extends StatelessWidget {
  final String pictureAddress; // 图片地址
  FloorTitle({Key key, this.pictureAddress}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Image.network(pictureAddress),
    );
  }
}

// 楼层组件
class FloorContent extends StatelessWidget {
  final List floorGoodsList;

  FloorContent({Key key, this.floorGoodsList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          _firstRow(),
          _otherGoods()
        ],
      ),
    );
  }

  Widget _firstRow() {
    return Row(
      children: <Widget>[
        _goodsItem(floorGoodsList[0]),
        Column(
          children: <Widget>[
            _goodsItem(floorGoodsList[1]),
            _goodsItem(floorGoodsList[2]),
          ],
        )
      ],
    );
  }

  Widget _otherGoods() {
    return Row(
      children: <Widget>[
        _goodsItem(floorGoodsList[3]),
        _goodsItem(floorGoodsList[4])
      ],
    );
  }

  Widget _goodsItem(Map goods) {
    print(goods);
    return Container(
      width: ScreenUtil().setWidth(375),
      child: InkWell(
        onTap: () {print('点击了楼层商品');},
        child: Image.network(goods['image']),
      ),
    );
  }
}