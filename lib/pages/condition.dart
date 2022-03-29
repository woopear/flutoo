import 'package:flutoo/models/condition_actived/widgets/condition_actived_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Condition extends ConsumerStatefulWidget {
  const Condition({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ConditionState();
}

class _ConditionState extends ConsumerState<Condition> {
  @override
  Widget build(BuildContext context) {
    /// recupere la largeur de l'ecran
    double widthTodo = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Conditions générales'),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: SizedBox(
              width: widthTodo > 700 ? 700.0 : double.infinity,
              child: Column(
                children: const [
                  ConditionActivedList(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
