import 'package:fluttermask/model/store_entity.dart';

storeEntityFromJson(StoreEntity data, Map<String, dynamic> json) {
	if (json['code'] != null) {
		data.code = json['code']?.toString();
	}
	if (json['name'] != null) {
		data.name = json['name']?.toString();
	}
	if (json['addr'] != null) {
		data.addr = json['addr']?.toString();
	}
	if (json['type'] != null) {
		data.type = json['type']?.toString();
	}
	if (json['lat'] != null) {
		data.lat = json['lat']?.toDouble();
	}
	if (json['lng'] != null) {
		data.lng = json['lng']?.toDouble();
	}
	if (json['stock_at'] != null) {
		data.stockAt = json['stock_at']?.toString();
	}
	if (json['remain_stat'] != null) {
		data.remainStat = json['remain_stat']?.toString();
	}
	if (json['created_at'] != null) {
		data.createdAt = json['created_at']?.toString();
	}
	return data;
}

Map<String, dynamic> storeEntityToJson(StoreEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['code'] = entity.code;
	data['name'] = entity.name;
	data['addr'] = entity.addr;
	data['type'] = entity.type;
	data['lat'] = entity.lat;
	data['lng'] = entity.lng;
	data['stock_at'] = entity.stockAt;
	data['remain_stat'] = entity.remainStat;
	data['created_at'] = entity.createdAt;
	return data;
}