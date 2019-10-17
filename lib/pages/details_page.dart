import 'package:flutter/material.dart';
import 'package:flutter_shop/provide/details_info.dart';
import 'package:provide/provide.dart';
class DetailsPage extends StatelessWidget {
  final String goodsId;
  DetailsPage(this.goodsId);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('商品ID为：${goodsId}'),
    );
  }

  void _getBackInfo(BuildContext context )async{
      await  Provide.value<DetailInfoProvide>(context).getGoodsInfo(goodsId);
      print('加载完成............');
  }
}

