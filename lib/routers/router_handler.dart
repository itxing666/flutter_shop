

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop/pages/details_page.dart';

Handler detailsHandler = Handler(
  handlerFunc: (BuildContext context, params){
    print('================$params');
    String goodsId = params['id'].first;
    print('index>details goodsID is ${goodsId}');
    return DetailsPage(goodsId);
  }
);