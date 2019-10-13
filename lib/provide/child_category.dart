// ChangeNotifier 的混入是不用管理听众

import 'package:flutter/foundation.dart';
import 'package:flutter_shop/model/category.dart';

class ChildCategory with ChangeNotifier {
  List<BxMallSubDto> childCategoryList = [];
  int childIndex = 0;
  String categoryId = '4'; // 大类ID
  String subId = ''; // 小类ID
  int page = 1; // 列表页数，当改变大类或者小类时进行改变
  String noMoreText = ''; // 显示更多的标识
  getChildCategory(List<BxMallSubDto> list, String id) {
    BxMallSubDto all =  BxMallSubDto();
    childIndex = 0;
    categoryId = id;
    subId=''; //点击大类时，把子类ID清空
    //------------------关键代码start
    page=1;
    noMoreText = '';
    //------------------关键代码end
    //--------修改的关键代码start
    all.mallSubId='';
    //--------修改的关键代码end
    all.mallCategoryId='00';
    all.mallSubName = '全部';
    all.comments = 'null';
    childCategoryList=[all];
    childCategoryList.addAll(list);
    notifyListeners();
  }
  //改变子类索引
  changeChildIndex(index, String id) {
    childIndex = index;
    //------------------关键代码start
    page=1;
    noMoreText = ''; //显示更多的表示
    //------------------关键代码end
    subId=id;
    notifyListeners();
  }
  // 增加Page的方法f
  addPage(){
    page++;
    // notifyListeners();
  }
  //改变noMoreText数据
  changeNoMore(String text){
    noMoreText=text;
    notifyListeners();
  }
}