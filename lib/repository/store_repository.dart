import 'package:fluttermask/generated/json/store_entity_helper.dart';
import 'package:fluttermask/model/store_entity.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class StoreRepository {
  Future<List<StoreEntity>> fetch(double lat, double lng) async {
    final stores = List<StoreEntity>();

    var url =
        "https://8oi9s0nnth.apigw.ntruss.com/corona19-masks/v1/storesByGeo/json?lat=$lat&lng=$lng&m=5000";
    var response = await http.get(url);
    final jsonResult = jsonDecode(utf8.decode(response.bodyBytes));
    final jsonStores = jsonResult['stores'];
    jsonStores.forEach((e) {
      stores.add(storeEntityFromJson(new StoreEntity(), e));
    });
    return stores.where((e) {
      return e.remainStat == 'plenty' ||
          e.remainStat == 'some' ||
          e.remainStat == 'few';
    }).toList();
  }
}
