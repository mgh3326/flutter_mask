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
        title: Text("마스크 재고 있는 곳 : 0곳"),
      ),
      body: ListView(
        children: stores.map((e) {
          return ListTile(
            title: Text(e.name),
            subtitle: Text(e.addr),
            trailing: Text(e.remainStat ?? '매진'),
          );
        }).toList(),
      ),
    );
  }

  Future fetch() async {
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
    });
  }
}
