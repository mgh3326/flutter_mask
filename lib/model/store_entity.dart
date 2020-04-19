import 'package:fluttermask/generated/json/base/json_convert_content.dart';
import 'package:fluttermask/generated/json/base/json_filed.dart';

class StoreEntity with JsonConvert<StoreEntity> {
  String code;
  String name;
  String addr;
  String type;
  double lat;
  double lng;
  @JSONField(name: "stock_at")
  String stockAt;
  @JSONField(name: "remain_stat")
  String remainStat;
  @JSONField(name: "created_at")
  String createdAt;
}
