import 'package:flutter/cupertino.dart';
import 'package:fluttermask/model/store_entity.dart';
import 'package:fluttermask/repository/location_repository.dart';
import 'package:fluttermask/repository/store_repository.dart';
import 'package:geolocator/geolocator.dart';

class StoreModel with ChangeNotifier {
  bool isLoading = false;
  List<StoreEntity> stores = [];
  final _storeRepository = StoreRepository();
  final _locationRepository = LocationRepository();

  StoreModel() {
    fetch();
  }

  Future fetch() async {
    isLoading = true;
    notifyListeners();
    Position position = await _locationRepository.getCurrentLocation();
    stores =
        await _storeRepository.fetch(position.latitude, position.longitude);
    isLoading = false;
    notifyListeners();
  }
}
