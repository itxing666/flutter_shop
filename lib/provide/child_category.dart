// ChangeNotifier 的混入是不用管理听众

import 'package:flutter/foundation.dart';
import 'package:flutter_shop/model/category.dart';

class ChildCategory with ChangeNotifier {
  List<BxMallSubDto> childCategoryList = [];
  int childIndex = 0;
  String categoryId = '4';
  getChildCategory(List<BxMallSubDto> list, String id) {
    BxMallSubDto all =  BxMallSubDto();
    childIndex = 0;
    categoryId = id;
    all.mallSubId='00';
    all.mallCategoryId='00';
    all.mallSubName = '全部';
    all.comments = 'null';
    childCategoryList=[all];
    childCategoryList.addAll(list);
    notifyListeners();
  }
  //改变子类索引
  changeChildIndex(index) {
    childIndex = index;
    notifyListeners();
  }
}