import 'package:flutter/material.dart';
import 'package:fluttermask/model/store_entity.dart';

class RemainStatListTile extends StatelessWidget {
  final StoreEntity store;

  RemainStatListTile(this.store);

  @override
  Widget build(BuildContext context) {
    return _buildRemainStatWidget(store);
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
}
