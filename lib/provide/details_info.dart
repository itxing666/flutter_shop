
import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:flutter_shop/model/detail.dart';
import 'package:flutter_shop/service/service_method.dart';

class DetailInfoProvide with ChangeNotifier{
  DetailsModel goodsInfo;
  // 从后台获取商品信息
  getGoodsInfo(String id) {
    var formData = { 'goodId': id };
    request('getGoodDetailById',formData:formData).then((val){
      var responseData = json.decode(val.toString());
      print(responseData);
      goodsInfo = DetailsModel.fromJson(responseData);
      notifyListeners();
    });
  }

}