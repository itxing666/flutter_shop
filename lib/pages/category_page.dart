import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/model/category.dart';
import 'package:flutter_shop/model/categoryGoodsList.dart';
import 'package:flutter_shop/provide/category_goods_list.dart';
import 'package:flutter_shop/provide/child_category.dart';
import 'package:flutter_shop/service/service_method.dart';
import 'package:provide/provide.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  void initState() {
    // _getCategory();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // return Container(
    //   child: Center(
    //     child: LeftCategoryNav(),
    //   )
    // );
    return Scaffold(
      appBar: AppBar(
        title: Text('商品分类'),
      ),
      body: Container(
        child: Row(
          children: <Widget>[
            LeftCategoryNav(),
            Column(
              children: <Widget>[
                RightCategoryNav(),
                CategoryGoodsList()
              ],
            )
          ],
        ),
      ),
    );
  }
}

class LeftCategoryNav extends StatefulWidget {
  @override
  _LeftCategoryNavState createState() => _LeftCategoryNavState();
}

class _LeftCategoryNavState extends State<LeftCategoryNav> {
  List list = [];
  int listIndex = 0; // 索引
  @override
  void initState() {
    _getCategory();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(180),
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(width: 1, color: Colors.black12)
        )
      ),
      child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          return _leftInkWell(index);
        },
      ),
    );
  }

  void _getCategory() async {
    await request('getCategory').then((val) {
      var data = json.decode(val.toString());
      CategoryModel category = new CategoryModel.fromJson(data);
      setState(() {
        list = category.data;
      });
      Provide.value<ChildCategory>(context).getChildCategory( category.data[0].bxMallSubDto);
    });
  }

  Widget _leftInkWell(int index) {
    bool isClick = false;
    isClick = (index == listIndex) ? true : false;
    return InkWell(
      onTap: () {
        setState(() {
          listIndex = index;
        });
        var childList = list[index].bxMallSubDto;
        Provide.value<ChildCategory>(context).getChildCategory(childList);
      },
      child: Container(
        height: ScreenUtil().setHeight(100),
        padding: EdgeInsets.only(left: 10, top: 20),
        decoration: BoxDecoration(
          color: isClick?Color.fromRGBO(236, 238, 239, 1.0):Colors.white,
          border: Border(
            bottom: BorderSide(width: 1, color: Colors.black12)
          )
        ),
        child: Text(list[index].mallCategoryName, style: TextStyle(
          fontSize: ScreenUtil().setSp(28)
        )),
      ),
    );
  }
}

//右侧小类类别

class RightCategoryNav extends StatefulWidget {
  _RightCategoryNavState createState() => _RightCategoryNavState();
}

class _RightCategoryNavState extends State<RightCategoryNav> {

  // List list = ['名酒','宝丰','北京二锅头'];
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Provide<ChildCategory>(
        builder: (context, child, childCategory) {
          return Container(
            height: ScreenUtil().setHeight(80),
            width: ScreenUtil().setWidth(570),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(width: 1,color: Colors.black12)
              )
            ),
            child:ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: childCategory.childCategoryList.length,
              itemBuilder: (context, index){
                return _rightInkWell(childCategory.childCategoryList[index]);
              },
            )
          );
        },
      )
    );
  }
  Widget _rightInkWell(BxMallSubDto item){

    return InkWell(
      onTap: (){},
      child: Container(
        padding:EdgeInsets.fromLTRB(5.0,10.0,5.0,10.0),
        child: Text(
          item.mallSubName,
          style: TextStyle(fontSize:ScreenUtil().setSp(28)),
        ),
      ),
    );
  }
}


// 商品列表 可以上拉加载
class CategoryGoodsList extends StatefulWidget {
  @override
  _CategoryGoodsListState createState() => _CategoryGoodsListState();
}

class _CategoryGoodsListState extends State<CategoryGoodsList> {
  List list = [];
  @override
  void initState() {
    _getGoodList();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        width: ScreenUtil().setWidth(570),
        height: ScreenUtil().setHeight(980),
        child: ListView.builder(
          itemCount: list.length,
          itemBuilder: (context,index){
            return _listWidget(index);
          },
        )
      ),
    );
  }

  void _getGoodList({String categoryId}) async {
    var data = {
      'categoryId':categoryId==null?'4':categoryId,
      'categorySubId': "",
      'page':1
    };
    await request('getMallGoods', formData: data).then((val) {
      var data = json.decode(val.toString());
      CategoryGoodsListModel goodsList = CategoryGoodsListModel.fromJson(data);
      Provide.value<CategoryGoodsListProvide>(context).getGoodsList(goodsList.data);
    });
  }

  Widget _goodsImage(index) {
    return Container(
      width: ScreenUtil().setWidth(200.0),
      child: Image.network(list[index].image),
    );
  }

  Widget _goodsName(index) {
    return Container(
      padding: EdgeInsets.all(5.0),
      width: ScreenUtil().setWidth(370),
      child: Text(
        list[index].goodsName,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: ScreenUtil().setSp(28)
        )
      ),
    );
  }

  Widget _goodsPrice(index) {
    return Container(
      margin: EdgeInsets.only(top: 20.0),
      width: ScreenUtil().setWidth(370),
      child: Row(
        children: <Widget>[
          Text(
            '价格:¥${list[index].presentPrice}',
            style: TextStyle(
              color: Colors.pink,
              fontSize:ScreenUtil().setSp(30)
            )
          ),
          Text(
            '¥${list[index].oriPrice}',
            style: TextStyle(
              color: Colors.black26,
              decoration: TextDecoration.lineThrough
            )
          )
        ],
      ),
    );
  }

  Widget _listWidget(int index) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(
              width: 1.0,
              color: Colors.black12
            )
          )
        ),
        child: Row(
          children: <Widget>[
            _goodsImage(index),
            Column(
              children: <Widget>[
                _goodsName(index),
                _goodsPrice(index)
              ],
            )
          ],
        ),
      ),
    );
  }
}