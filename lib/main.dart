import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttermask/model/store_entity.dart';
import 'package:http/http.dart' as http;

import 'generated/json/store_entity_helper.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

final stores = List<StoreEntity>();
var isLoading = true;

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    fetch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("마스크 재고 있는 곳 : ${stores.where((e) {
          return e.remainStat == 'plenty' ||
              e.remainStat == 'some' ||
              e.remainStat == 'few';
        }).length}곳"),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              fetch();
            },
            icon: Icon(Icons.refresh),
          )
        ],
      ),
      body: isLoading
          ? loadingWidget()
          : ListView(
              children: stores.where((e) {
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

  Future fetch() async {
    setState(() {
      isLoading = true;
    });
    var url =
        "https://8oi9s0nnth.apigw.ntruss.com/corona19-masks/v1/storesByGeo/json?lat=37.404786&lng=127.1166762&m=5000";
    var response = await http.get(url);
    final jsonResult = jsonDecode(utf8.decode(response.bodyBytes));
    final jsonStores = jsonResult['stores'];
    setState(() {
      stores.clear();
      jsonStores.forEach((e) {
        stores.add(storeEntityFromJson(new StoreEntity(), e));
      });
      isLoading = false;
    });
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
