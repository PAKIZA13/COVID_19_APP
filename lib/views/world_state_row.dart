import 'package:flutter/material.dart';

class WorldStateRow extends StatelessWidget {
  String title;
  String value;
   WorldStateRow({super.key,required this.title,required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Text(title),
              Spacer(),
              Text(value),
            ],
          ),
          SizedBox(height: 5,),
        ],
      ),


    );
  }
}
