import 'package:fluttermask/generated/json/store_entity_helper.dart';
import 'package:fluttermask/model/store_entity.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class StoreRepository {
  Future<List<StoreEntity>> fetch() async {
    final stores = List<StoreEntity>();

    var url =
        "https://8oi9s0nnth.apigw.ntruss.com/corona19-masks/v1/storesByGeo/json?lat=37.404786&lng=127.1166762&m=5000";
    var response = await http.get(url);
    final jsonResult = jsonDecode(utf8.decode(response.bodyBytes));
    final jsonStores = jsonResult['stores'];
    jsonStores.forEach((e) {
      stores.add(storeEntityFromJson(new StoreEntity(), e));
    });
    return stores;
  }
}