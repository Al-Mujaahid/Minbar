import 'package:flutter/material.dart';

class MinbarDataStatItem extends StatelessWidget {
  String label;
  String value;
  MinbarDataStatItem({this.label, this.value});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.fromLTRB(10, 40, 10, 20),
        width: MediaQuery.of(context).size.width * .40,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('$value', style: TextStyle(
              fontSize: MediaQuery.of(context).size.width * .10, fontWeight: FontWeight.w200
            ),),
            Text('$label', style: TextStyle(
             fontWeight: FontWeight.w500
            ),),
          ],
        ),
      ),
    );
  }
}