import 'package:flutoo/models/todo/todo_constant.dart';
import 'package:flutoo/models/todo/todo_provider.dart';
import 'package:flutoo/models/todo/todo_schema.dart';
import 'package:flutoo/utils/services/validator/validator.dart';
import 'package:flutoo/widget_shared/notif_message/notif_message.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woo_widget_input/woo_widget_input.dart';

class TodoUpdate extends StatefulWidget {
  String? inputLibelle;
  bool? check;
  String? id;
  String? uid;
  void Function()? closedUpdated;

  TodoUpdate({
    Key? key,
    required this.inputLibelle,
    required this.id,
    required this.check,
    required this.uid,
    required this.closedUpdated,
  }) : super(key: key);

  @override
  State<TodoUpdate> createState() => _TodoUpdateState();
}

class _TodoUpdateState extends State<TodoUpdate> {
  final _formKey = GlobalKey<FormState>();

  /// modifie la todo, son libelle
  void updateTodo(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      /// update libelle de la todo
      final libelle = TodoSchema(
        libelle: widget.inputLibelle,
        check: widget.check,
        uid: widget.uid,
      );
      context.read<TodoProvider>().updateTodo(widget.id!, libelle);

      /// ferme le volet update todo
      widget.closedUpdated!();

      /// affiche le message de succes
      NotifMessage(
        text: TodoConstant.updateTodoMessageSucces,
        error: false,
      ).notification(context);
    } else {
      /// affiche le message d'erreur
      NotifMessage(
        text: TodoConstant.updateTodoMessageError,
        error: true,
      ).notification(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 5.0, right: 5.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Row(
              children: [
                /// input du libelle
                Expanded(
                  child: InputCustom(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 5.0),
                    initialValue: widget.inputLibelle,
                    label: Text(TodoConstant.updateLabelInputTodo),
                    validator: (value) => Validator.validatorInputTextBasic(
                      textError: Validator.inputTodoText,
                      value: value,
                    ),
                    onChange: (value) => widget.inputLibelle = value,
                  ),
                ),

                /// validation du libelle (update todo)
                Container(
                  margin: const EdgeInsets.only(left: 10.0),
                  child: IconButton(
                    color: Colors.green,
                    onPressed: () => updateTodo(context),
                    icon: const Icon(Icons.done),
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
