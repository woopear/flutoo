import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutoo/models/todo/todo_constant.dart';
import 'package:flutoo/models/todo/todo_schema.dart';
import 'package:flutoo/models/todo/todo_state.dart';
import 'package:flutoo/models/user/user_state.dart';
import 'package:flutoo/utils/services/validator/validator.dart';
import 'package:flutoo/widget_shared/notif_message/notif_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woo_widget_input/woo_widget_input.dart';

class TodoCreate extends ConsumerStatefulWidget {
  const TodoCreate({Key? key}) : super(key: key);

  @override
  _TodoCreateState createState() => _TodoCreateState();
}

class _TodoCreateState extends ConsumerState<TodoCreate> {
  final _formKey = GlobalKey<FormState>();
  String? inputLibelle;

  /// clique btn creation todo
  Future<void> createTodo(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      /// creation de la todo
      final newTodo =
          TodoSchema(libelle: inputLibelle, uid: ref.watch(userCurrent)!.uid, date: Timestamp.now());
      ref.watch(todoState).addTodo(newTodo);

      /// reset variable pour input
      setState(() => {
            inputLibelle = '',
          });

      /// reset form
      _formKey.currentState!.reset();

      /// message de confirmation
      NotifMessage(
        text: TodoConstant.createTodoMessageSucces,
        error: false,
      ).notification(context);
    } else {
      /// message d'erreur
      NotifMessage(
        text: TodoConstant.createTodoMessageError,
        error: true,
      ).notification(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 50.0),
      padding: const EdgeInsets.only(left: 20.0, right: 20.0),

      /// form creation todo
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Row(
              children: [
                /// input libelle todo
                Expanded(
                  child: InputCustom(
                    label: Text(TodoConstant.createLabelInputTodo),
                    validator: (value) => Validator.validatorInputTextBasic(
                      textError: Validator.inputTodoText,
                      value: value,
                    ),
                    onChange: (value) => inputLibelle = value,
                  ),
                ),

                /// btn creation todo
                Container(
                  margin: const EdgeInsets.only(left: 30.0),
                  child: ElevatedButton(
                    onPressed: () async {
                        await createTodo(context);
                    },
                    child: const Text('Valider'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
