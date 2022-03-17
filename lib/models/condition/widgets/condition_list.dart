import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutoo/models/condition/condition_provider.dart';
import 'package:flutoo/models/condition/widgets/condition_list_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ConditionList extends StatefulWidget {
  const ConditionList({Key? key}) : super(key: key);

  @override
  State<ConditionList> createState() => _ConditionListState();
}

class _ConditionListState extends State<ConditionList> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: context.watch<ConditionProvider>().conditions,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        /// error
        if (snapshot.hasError) {
          return const Text('Impossible de récupérer les données ...');
        }

        /// en chargement
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            margin: const EdgeInsets.only(top: 50.0),
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        return Container(
          constraints: const BoxConstraints(minHeight: 200.0),
          margin: const EdgeInsets.only(top: 30.0, bottom: 50.0),
          child: Column(
            children: [
              /// haut du tableau
              Table(
                children: [
                  TableRow(
                    children: [
                      TableCell(
                        child: Row(
                          children: const [
                            Expanded(
                              child: Text('TITRE',
                                  style: TextStyle(fontSize: 26.0)),
                            ),
                            Text('ACTIONS', style: TextStyle(fontSize: 26.0)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              /// corps du tableau
              Table(
                children: snapshot.data!.docs.map(
                  (DocumentSnapshot document) {
                    Map<String, dynamic> data =
                        document.data()! as Map<String, dynamic>;
                    context.read<ConditionProvider>().findAllConditions(snapshot.data!.docs);
                    return TableRow(
                      children: [
                        ConditionListCard(
                          title: data['title'],
                          activate: data['activate'],
                          id: document.id,
                        ),
                      ],
                    );
                  },
                ).toList(),
              ),
            ],
          ),
        );
      },
    );
  }
}
