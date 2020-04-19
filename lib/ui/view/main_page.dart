import 'package:flutter/material.dart';
import 'package:fluttermask/ui/widget/Remain_stat_list_tile.dart';
import 'package:fluttermask/view_model/store_model.dart';
import 'package:provider/provider.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final storeModel = Provider.of<StoreModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("마스크 재고 있는 곳 : ${storeModel.stores.length}곳"),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              storeModel.fetch();
            },
            icon: Icon(Icons.refresh),
          )
        ],
      ),
      body: storeModel.isLoading
          ? loadingWidget()
          : ListView(
              children: storeModel.stores.map((e) {
                return ListTile(
                  title: Text(e.name),
                  subtitle: Text(e.addr),
                  trailing: RemainStatListTile(e),
                );
              }).toList(),
            ),
    );
  }

  Widget loadingWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[Text('정보를 가져오는 중'), CircularProgressIndicator()],
      ),
    );
  }
}
