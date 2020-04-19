import 'package:flutter/cupertino.dart';
import 'package:fluttermask/model/store_entity.dart';
import 'package:fluttermask/repository/store_repository.dart';

class StoreModel with ChangeNotifier {
  bool isLoading = false;
  List<StoreEntity> stores = [];
  final _storeRepository = StoreRepository();

  StoreModel() {
    fetch();
  }

  Future fetch() async {
    isLoading = true;
    notifyListeners();
    stores = await _storeRepository.fetch();
    isLoading = false;
    notifyListeners();
  }
}
