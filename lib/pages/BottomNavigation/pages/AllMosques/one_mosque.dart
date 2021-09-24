import 'package:flutter/material.dart';
import 'package:minbar_data/models/mosque.model.dart';

class OneMosque extends StatelessWidget {
  Mosque mosque;
  OneMosque({this.mosque});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        leading: Image.network('${mosque.mosqueImage}', height: 30, width: 30,),
        title: Text('${mosque.mosqueName}'),
        subtitle: Text('${mosque.mosqueAddress}'),
        trailing: IconButton(
          icon: Text('edit'),
          onPressed: () => Navigator.pushNamed(context, '/edit_mosque', arguments: mosque),
        ),
      ),
    );
  }
} 