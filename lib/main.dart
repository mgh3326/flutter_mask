import 'package:flutter/material.dart';
import 'package:fluttermask/ui/view/main_page.dart';
import 'package:fluttermask/view_model/store_model.dart';
import 'package:provider/provider.dart';

void main() => runApp(ChangeNotifierProvider.value(
      value: StoreModel(),
      child: MyApp(),
    ));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainPage(),
    );
  }
}
