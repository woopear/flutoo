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
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Conditions générales'),
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: const [
                Text('coucou')
              ],
            ),
          ),
        ),
      ),
    );
  }
}
