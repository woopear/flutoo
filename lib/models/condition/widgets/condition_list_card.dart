import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ConditionListCard extends StatefulWidget {
  String? title;
  bool? activate;
  Timestamp? date;
  
  ConditionListCard({Key? key, this.title, this.activate, this.date})
      : super(key: key);

  @override
  State<ConditionListCard> createState() => _ConditionListCardState();
}

class _ConditionListCardState extends State<ConditionListCard> {
  

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
      child: const Card(),
    );
  }
}
