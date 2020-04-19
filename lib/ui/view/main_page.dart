import 'package:flutter/material.dart';
import 'package:fluttermask/model/store_entity.dart';
import 'package:fluttermask/view_model/store_model.dart';
import 'package:provider/provider.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final storeModel = Provider.of<StoreModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("마스크 재고 있는 곳 : ${storeModel.stores.where((e) {
          return e.remainStat == 'plenty' ||
              e.remainStat == 'some' ||
              e.remainStat == 'few';
        }).length}곳"),
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
        children: storeModel.stores.where((e) {
          return e.remainStat == 'plenty' ||
              e.remainStat == 'some' ||
              e.remainStat == 'few';
        }).map((e) {
          return ListTile(
            title: Text(e.name),
            subtitle: Text(e.addr),
            trailing: _buildRemainStatWidget(e),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildRemainStatWidget(StoreEntity store) {
    var remainStat = '판매중지';
    var description = '판매중지';
    Color color = Colors.black;
    if (store.remainStat == 'plenty') {
      remainStat = '충분';
      description = '100개 이상';
      color = Colors.green;
    } else if (store.remainStat == 'some') {
      remainStat = '보통';
      description = '30개 이상';
      color = Colors.yellow;
    } else if (store.remainStat == 'few') {
      remainStat = '부족';
      description = '2 ~ 30개';
      color = Colors.red;
    } else if (store.remainStat == 'empty') {
      remainStat = '소진임박';
      description = '1개 이하';
      color = Colors.grey;
    }
    return Column(
      children: <Widget>[
        Text(
          remainStat,
          style: TextStyle(color: color, fontWeight: FontWeight.bold),
        ),
        Text(description,
            style: TextStyle(
              color: color,
            )),
      ],
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
