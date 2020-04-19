import 'package:flutter/material.dart';
import 'package:fluttermask/model/store_entity.dart';
import 'package:url_launcher/url_launcher.dart';

class RemainStatListTile extends StatelessWidget {
  final StoreEntity store;

  RemainStatListTile(this.store);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(store.name),
      subtitle: Text(store.addr),
      trailing: _buildRemainStatWidget(store),
      onTap: () {
        _launchURL(store.lat, store.lng);
      },
    );
    ;
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

  _launchURL(double lat, double lng) async {
    final url = 'https://google.com/maps/search/?api=1&query=$lat,$lng';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
